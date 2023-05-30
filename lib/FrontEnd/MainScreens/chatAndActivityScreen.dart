// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/Backend/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
import 'package:google_signin/Backend/sqlite_management/local_database_management.dart';
import 'package:google_signin/FrontEnd/Services/ChatManagement/chat_screen.dart';
import 'package:google_signin/FrontEnd/Services/search_screen.dart';
import 'package:google_signin/Global_Uses/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_signin/Global_Uses/enum_generation.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:animations/animations.dart';
import 'package:lottie/lottie.dart';

class ChatAndActivityScreen extends StatefulWidget {
  const ChatAndActivityScreen({Key? key}) : super(key: key);

  @override
  _ChatAndActivityScreenState createState() => _ChatAndActivityScreenState();
}

class _ChatAndActivityScreenState extends State<ChatAndActivityScreen> {
  bool _isLoading = false;

  final List<String> _allConnectionsUserName = [];

  final CloudStoreDataManagement _cloudStoreDataManagement =
      CloudStoreDataManagement();

  final LocalDatabase _localDatabase = LocalDatabase();

  static final FirestoreFieldConstants _firestoreFieldConstants =
      FirestoreFieldConstants();

  /// For New Connected User Data Entry
  Future<void> _checkingForNewConnection(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final List<dynamic> _connectionRequestList =
        queryDocumentSnapshot.get(_firestoreFieldConstants.connectionRequest);

    for (var connectionRequestData in _connectionRequestList) {
      if (connectionRequestData.values.first.toString() ==
              OtherConnectionStatus.Invitation_Accepted.toString() ||
          connectionRequestData.values.first.toString() ==
              OtherConnectionStatus.Request_Accepted.toString()) {
        for (var everyDocument in docs) {
          if (everyDocument.id == connectionRequestData.keys.first.toString()) {
            final String _connectedUserName =
                everyDocument.get(_firestoreFieldConstants.userName);
            final String _token =
                everyDocument.get(_firestoreFieldConstants.token);
            final String _about =
                everyDocument.get(_firestoreFieldConstants.about);
            final String _accCreationDate =
                everyDocument.get(_firestoreFieldConstants.creationDate);
            final String _accCreationTime =
                everyDocument.get(_firestoreFieldConstants.creationTime);

            if (mounted) {
              setState(() {
                if (!_allConnectionsUserName.contains(_connectedUserName)) {
                  _allConnectionsUserName.add(_connectedUserName);
                }
              });
            }

            final bool _newConnectionUserNameInserted =
                await _localDatabase.insertOrUpdateDataForThisAccount(
                    userName: _connectedUserName,
                    userMail: everyDocument.id,
                    userToken: _token,
                    userAbout: _about,
                    userAccCreationDate: _accCreationDate,
                    userAccCreationTime: _accCreationTime);

            if (_newConnectionUserNameInserted) {
              await _localDatabase.createTableForEveryUser(
                  userName: _connectedUserName);
            }
          }
        }
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Fetch Real Time Data From Cloud Firestore
  Future<void> _fetchRealTimeDataFromCloudStorage() async {
    final realTimeSnapshot =
        await _cloudStoreDataManagement.fetchRealTimeDataFromFirestore();

    realTimeSnapshot!.listen((querySnapshot) {
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        if (queryDocumentSnapshot.id ==
            FirebaseAuth.instance.currentUser!.email.toString()) {
          _checkingForNewConnection(queryDocumentSnapshot, querySnapshot.docs);
        }
      }
    });
  }

  @override
  void initState() {
    _fetchRealTimeDataFromCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 117, 231, 212),
        floatingActionButton: _externalConnectionManagement(),
        body: LoadingOverlay(
          color: const Color.fromRGBO(0, 0, 0, 0.5),
          progressIndicator: const CircularProgressIndicator(
            backgroundColor: Colors.black87,
          ),
          isLoading: _isLoading,
          child: ListView(
            children: [
              const SizedBox(
                height: 6,
              ),
              const SizedBox(
                height: 70,
                child: Card(
                  elevation: 1,
                  color: Color.fromARGB(255, 39, 230, 220),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcome Here!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              _connectionList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _connectionList(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Container(
        padding: const EdgeInsets.only(top: 18.0, bottom: 10.0),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 39, 230, 220),
              blurRadius: 1,
              spreadRadius: 0.0,
            ),
          ],
          image: DecorationImage(
            image: AssetImage('assets/images/pic2.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        child: ReorderableListView.builder(
          onReorder: (first, last) {
            if (mounted) {
              setState(() {
                final String _draggableConnection =
                    _allConnectionsUserName.removeAt(first);

                _allConnectionsUserName.insert(
                    last >= _allConnectionsUserName.length
                        ? _allConnectionsUserName.length
                        : last > first
                            ? --last
                            : last,
                    _draggableConnection);
              });
            }
          },
          itemCount: _allConnectionsUserName.length,
          itemBuilder: (context, position) {
            return chatTileContainer(
                context, position, _allConnectionsUserName[position]);
          },
        ),
      ),
    );
  }

  Widget chatTileContainer(BuildContext context, int index, String _userName) {
    return Card(
        key: Key('$index'),
        elevation: 0.0,
        color: Colors.grey,
        child: Container(
          color: Colors.green,
          padding: const EdgeInsets.only(left: 3, right: 3),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
            ),
            onPressed: () {
              log("Chat List Pressed");
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    bottom: 3.0,
                  ),
                  child: OpenContainer(
                    closedShape: const CircleBorder(),
                    closedElevation: 0.0,
                    transitionDuration: const Duration(milliseconds: 500),
                    transitionType: ContainerTransitionType.fadeThrough,
                    openBuilder: (_, __) {
                      return const Center();
                    },
                    closedBuilder: (_, __) {
                      return const CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.black12,
                        backgroundImage:
                            ExactAssetImage('assets/images/userPro.jpeg'),
                      );
                    },
                  ),
                ),
                OpenContainer(
                  closedElevation: 0.0,
                  openElevation: 0.0,
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (context, openWidget) {
                    return ChatScreen(
                      userName: _userName,
                    );
                  },
                  closedBuilder: (context, closeWidget) {
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 + 30,
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                        left: 5.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            _userName.length <= 18
                                ? _userName
                                : _userName.replaceRange(
                                    18, _userName.length, '...'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          const Text(
                            'Hello User',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      bottom: 2.0,
                    ),
                    child: Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_OHjIOS.json'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _externalConnectionManagement() {
    return OpenContainer(
      closedShape: const CircleBorder(),
      closedElevation: 15.0,
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (_, __) {
        return const SearchScreen();
      },
      closedBuilder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.green,
            size: 37.0,
          ),
        );
      },
    );
  }
}

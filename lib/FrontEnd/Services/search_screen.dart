import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_signin/Backend/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_signin/Global_Uses/enum_generation.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> _availableUsers = [];
  List<Map<String, dynamic>> _sortedAvailableUsers = [];
  List<dynamic> _myConnectionRequestCollection = [];

  bool _isLoading = false;

  final CloudStoreDataManagement _cloudStoreDataManagement =
      CloudStoreDataManagement();

  Future<void> _initialDataFetchAndCheckUp() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final List<Map<String, dynamic>> takeUsers =
        await _cloudStoreDataManagement.getAllUsersListExceptMyAccount(
            currentUserEmail:
                FirebaseAuth.instance.currentUser!.email.toString());

    final List<Map<String, dynamic>> takeUsersAfterSorted = [];

    if (mounted) {
      setState(() {
        for (var element in takeUsers) {
          if (mounted) {
            setState(() {
              takeUsersAfterSorted.add(element);
            });
          }
        }
      });
    }

    final List<dynamic> _connectionRequestList =
        await _cloudStoreDataManagement.currentUserConnectionRequestList(
            email: FirebaseAuth.instance.currentUser!.email.toString());

    if (mounted) {
      setState(() {
        _availableUsers = takeUsers;
        _sortedAvailableUsers = takeUsersAfterSorted;
        _myConnectionRequestCollection = _connectionRequestList;
      });
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _initialDataFetchAndCheckUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: LoadingOverlay(
          isLoading: _isLoading,
          color: Colors.black54,
          child: Container(
            margin: const EdgeInsets.all(12.0),
            width: double.maxFinite,
            height: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Center(
                  child: Text(
                    'Available Connections',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Expanded(child: Container()),
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'circe'),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search for Friends"),
                          onChanged: (writeText) {
                            if (mounted) {
                              setState(() {
                                _isLoading = true;
                              });
                            }

                            if (mounted) {
                              setState(() {
                                _sortedAvailableUsers.clear();

                                log('Available Users: $_availableUsers');

                                for (var userNameMap in _availableUsers) {
                                  if (userNameMap.values.first
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(writeText.toLowerCase())) {
                                    _sortedAvailableUsers.add(userNameMap);
                                  }
                                }
                              });
                            }

                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  height: MediaQuery.of(context).size.height - 50,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 74, 240, 231),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _sortedAvailableUsers.length,
                    itemBuilder: (connectionContext, index) {
                      return connectionShowUp(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget connectionShowUp(int index) {
    return Card(
      elevation: 0.5,
      color: const Color.fromARGB(255, 240, 244, 248),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _sortedAvailableUsers[index]
                      .values
                      .first
                      .toString()
                      .split('[user-name-about-divider]')[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Lora',
                  ),
                ),
                Text(
                  _sortedAvailableUsers[index]
                      .values
                      .first
                      .toString()
                      .split('[user-name-about-divider]')[1],
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: BorderSide(
                      color: _getRelevantButtonConfig(
                          connectionStateType:
                              ConnectionStateType.ButtonBorderColor,
                          index: index)),
                )),
                child: _getRelevantButtonConfig(
                    connectionStateType: ConnectionStateType.ButtonNameWidget,
                    index: index),
                onPressed: () async {
                  final String buttonName = _getRelevantButtonConfig(
                      connectionStateType: ConnectionStateType.ButtonOnlyName,
                      index: index);

                  if (mounted) {
                    setState(() {
                      _isLoading = true;
                    });
                  }

                  if (buttonName == ConnectionStateName.Connect.toString()) {
                    if (mounted) {
                      setState(() {
                        _myConnectionRequestCollection.add({
                          _sortedAvailableUsers[index].keys.first.toString():
                              OtherConnectionStatus.Request_Pending.toString(),
                        });
                      });
                    }

                    await _cloudStoreDataManagement.changeConnectionStatus(
                        oppositeUserMail:
                            _sortedAvailableUsers[index].keys.first.toString(),
                        currentUserMail:
                            FirebaseAuth.instance.currentUser!.email.toString(),
                        connectionUpdatedStatus:
                            OtherConnectionStatus.Invitation_Came.toString(),
                        currentUserUpdatedConnectionRequest:
                            _myConnectionRequestCollection);
                  } else if (buttonName ==
                      ConnectionStateName.Accept.toString()) {
                    if (mounted) {
                      setState(() {
                        for (var element in _myConnectionRequestCollection) {
                          if (element.keys.first.toString() ==
                              _sortedAvailableUsers[index]
                                  .keys
                                  .first
                                  .toString()) {
                            _myConnectionRequestCollection[
                                _myConnectionRequestCollection
                                    .indexOf(element)] = {
                              _sortedAvailableUsers[index]
                                      .keys
                                      .first
                                      .toString():
                                  OtherConnectionStatus.Invitation_Accepted
                                      .toString(),
                            };
                          }
                        }
                      });
                    }

                    await _cloudStoreDataManagement.changeConnectionStatus(
                        storeDataAlsoInConnections: true,
                        oppositeUserMail:
                            _sortedAvailableUsers[index].keys.first.toString(),
                        currentUserMail:
                            FirebaseAuth.instance.currentUser!.email.toString(),
                        connectionUpdatedStatus:
                            OtherConnectionStatus.Request_Accepted.toString(),
                        currentUserUpdatedConnectionRequest:
                            _myConnectionRequestCollection);
                  }

                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }

  dynamic _getRelevantButtonConfig(
      {required ConnectionStateType connectionStateType, required int index}) {
    bool _isUserPresent = false;
    String _storeStatus = '';

    for (var element in _myConnectionRequestCollection) {
      if (element.keys.first.toString() ==
          _sortedAvailableUsers[index].keys.first.toString()) {
        _isUserPresent = true;
        _storeStatus = element.values.first.toString();
      }
    }

    if (_isUserPresent) {
      log('User Present in Connection List');

      if (_storeStatus == OtherConnectionStatus.Request_Pending.toString() ||
          _storeStatus == OtherConnectionStatus.Invitation_Came.toString()) {
        if (connectionStateType == ConnectionStateType.ButtonNameWidget) {
          return Text(
            _storeStatus == OtherConnectionStatus.Request_Pending.toString()
                ? ConnectionStateName.Pending.toString()
                    .split(".")[1]
                    .toString()
                : ConnectionStateName.Accept.toString()
                    .split(".")[1]
                    .toString(),
            style: const TextStyle(color: Colors.pink),
          );
        } else if (connectionStateType == ConnectionStateType.ButtonOnlyName) {
          return _storeStatus ==
                  OtherConnectionStatus.Request_Pending.toString()
              ? ConnectionStateName.Pending.toString()
              : ConnectionStateName.Accept.toString();
        }

        return Colors.pink;
      } else {
        if (connectionStateType == ConnectionStateType.ButtonNameWidget) {
          return Text(
            ConnectionStateName.Connected.toString().split(".")[1].toString(),
            style: const TextStyle(color: Colors.green),
          );
        } else if (connectionStateType == ConnectionStateType.ButtonOnlyName) {
          return ConnectionStateName.Connected.toString();
        }

        return Colors.green;
      }
    } else {
      log('User Not Present in Connection List');

      if (connectionStateType == ConnectionStateType.ButtonNameWidget) {
        return Text(
          ConnectionStateName.Connect.toString().split(".")[1].toString(),
          style: const TextStyle(color: Colors.lightBlue),
        );
      } else if (connectionStateType == ConnectionStateType.ButtonOnlyName) {
        return ConnectionStateName.Connect.toString();
      }

      return Colors.lightBlue;
    }
  }
}

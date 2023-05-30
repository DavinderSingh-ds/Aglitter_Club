// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: this._isLoading,
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            firstPortion(context),
            const SizedBox(
              height: 40.0,
            ),
            otherInformation('About', '@ClubHouse'),
            otherInformation('Join Date', "08-11-2000"),
            otherInformation('Join Time', "11:30 PM"),
            _deleteButton(context),
            const SizedBox(
              height: 30,
            ),
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_fdo8bkv7.json'),
          ],
        ),
      ),
    );
  }

  Widget firstPortion(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                OpenContainer(
                  closedShape: const CircleBorder(),
                  closedElevation: 0.0,
                  transitionDuration: const Duration(
                    milliseconds: 500,
                  ),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (context, openWidget) {
                    return const Center();
                  },
                  closedBuilder: (context, closeWidget) {
                    return CircleAvatar(
                      backgroundImage:
                          const ExactAssetImage('assets/images/ds.jpg'),
                      backgroundColor: const Color.fromARGB(255, 232, 241, 248),
                      radius: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height * (1.2 / 8) / 2.5
                          : MediaQuery.of(context).size.height *
                              (2.5 / 8) /
                              2.5,
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Davinder Singh',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Lora',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget otherInformation(String leftText, String rightText) {
    return Card(
      elevation: 0.5,
      child: Container(
        height: 60.0,
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  leftText,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Lora',
                    fontStyle: FontStyle.normal,
                    color: Colors.lightBlue,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 10.0),
                alignment: Alignment.centerRight,
                child: Text(
                  rightText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Lora',
                    color: Colors.green,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deleteButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            alignment: Alignment.center,
            child: Row(
              children: const [
                Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                Expanded(
                  child: Text(
                    'Delete My Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () async {
            await _deleteConformation();
          },
        ),
      ),
    );
  }

  Future<void> _deleteConformation() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: const Color.fromRGBO(34, 48, 60, 0.6),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              title: const Center(
                child: Text(
                  'Sure to Delete Your Account?',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                  ),
                ),
              ),
              content: Container(
                color: Colors.transparent,
                height: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Center(
                      child: Text(
                        'If You delete this account, your entire data will lost forever...\n\nDo You Want to Continue?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: const BorderSide(color: Colors.green),
                          )),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Sure',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: const BorderSide(color: Colors.red),
                          )),
                          onPressed: () async {
                            Navigator.pop(context);

                            if (mounted) {
                              setState(() {
                                _isLoading = true;
                              });
                            }
                            log("Deletion Event");

                            /// await deleteMyGenerationAccount();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}

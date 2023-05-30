import 'dart:developer';

import 'package:flutter/material.dart';

// import 'package:url_launcher/url_launcher.dart';

class SupportInputTaker extends StatefulWidget {
  final String subject;
  final String appbarTitle;

  const SupportInputTaker(
      {Key? key, required this.subject, required this.appbarTitle})
      : super(key: key);

  @override
  _SupportInputTakerState createState() => _SupportInputTakerState();
}

class _SupportInputTakerState extends State<SupportInputTaker> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _problemTitleController = TextEditingController();
  final TextEditingController _problemDescriptionController =
      TextEditingController();

  @override
  void initState() {
    _problemTitleController.text = '';
    _problemDescriptionController.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _problemTitleController.dispose();
    _problemDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        shadowColor: Colors.white70,
        title: Text(
          widget.appbarTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Form(
          key: _globalKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 40,
                child: TextFormField(
                  controller: _problemTitleController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  validator: (inputValue) {
                    if (inputValue!.isEmpty) {
                      return 'Please Provide a Problem Title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: '${widget.subject} Title',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lora',
                        letterSpacing: 1.0,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      ))),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 40,
                child: TextFormField(
                  maxLines: null,
                  controller: _problemDescriptionController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  validator: (inputValue) {
                    if (inputValue!.isEmpty) {
                      return 'Please Provide a Problem Description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: '${widget.subject} Description',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lora',
                        letterSpacing: 1.0,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      ))),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  top: 30.0,
                  bottom: 20.0,
                ),
                child: TextButton(
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    side: const BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      await _sendMail();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendMail() async {
    Navigator.pop(context);

    final Uri params = Uri(
      scheme: 'mailto',
      path: 'davindersingh00743@gmail.com',
      query:
          'subject=${widget.subject}: ${_problemTitleController.text} &body=${_problemDescriptionController.text}', //add subject and body here
    );

    final String url = params.toString();
    try {
      //await launch(url);
      (url);
    } catch (e) {
      log('Mail Sending Error: ${e.toString()}');
    }
  }
}

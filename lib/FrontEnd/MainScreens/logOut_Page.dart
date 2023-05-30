// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_signin/Backend/firebase/Auth/email_and_pwd_auth.dart';
import 'package:google_signin/Backend/firebase/Auth/fb_auth.dart';
import 'package:google_signin/Backend/firebase/Auth/google_auth.dart';
import 'package:google_signin/FrontEnd/AuthUI/log_in.dart';
import 'package:lottie/lottie.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({Key? key}) : super(key: key);

  @override
  _LogOutPageState createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final FacebookAuthentication _facebookAuthentication =
      FacebookAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Let's Go",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_l3qxn9jy.json'),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: const Text('Log Out'),
              onPressed: () async {
                final bool googleResponse =
                    await _googleAuthentication.logOut();

                if (!googleResponse) {
                  final bool fbResponse =
                      await _facebookAuthentication.logOut();

                  if (!fbResponse) await _emailAndPasswordAuth.logOut();
                }

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LogInScreen()),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}

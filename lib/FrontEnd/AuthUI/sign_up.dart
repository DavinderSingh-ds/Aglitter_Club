import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_signin/Backend/firebase/Auth/email_and_pwd_auth.dart';
import 'package:google_signin/Backend/firebase/Auth/fb_auth.dart';
import 'package:google_signin/Backend/firebase/Auth/google_auth.dart';
import 'package:google_signin/FrontEnd/AuthUI/log_in.dart';
import 'package:google_signin/FrontEnd/NewUserEntry/new_user_entry.dart';
import 'package:google_signin/Global_Uses/enum_generation.dart';
import 'package:google_signin/Global_Uses/reg_exp.dart';

import 'package:loading_overlay/loading_overlay.dart';

import 'common_auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _conformPwd = TextEditingController();

  final EmailAndPasswordAuth _emailAndPasswordAuth = EmailAndPasswordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final FacebookAuthentication _facebookAuthentication =
      FacebookAuthentication();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _isLoading,
          color: Colors.black54,
          child: Container(
            color: Colors.transparent,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const Center(
                  child: Text(
                    'Sign-Up',
                    style: TextStyle(fontSize: 28.0, color: Colors.black),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.65,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                  child: Form(
                    key: _signUpKey,
                    child: ListView(
                      children: [
                        commonTextFormField(
                            hintText: 'Email',
                            validator: (inputVal) {
                              if (!emailRegex.hasMatch(inputVal.toString())) {
                                return 'Email Format not Matching';
                              }
                              return null;
                            },
                            textEditingController: _email),
                        commonTextFormField(
                            hintText: 'Password',
                            validator: (String? inputVal) {
                              if (inputVal!.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            textEditingController: _pwd),
                        commonTextFormField(
                            hintText: 'Conform Password',
                            validator: (String? inputVal) {
                              if (inputVal!.length < 6) {
                                return 'Conform Password Must be at least 6 characters';
                              }
                              if (_pwd.text != _conformPwd.text) {
                                return 'Password and Conform Password Not Same Here';
                              }
                              return null;
                            },
                            textEditingController: _conformPwd),
                        signUpAuthButton(context, 'Sign-Up'),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Or Continue With',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
                signUpSocialMediaIntegrationButtons(),
                switchAnotherAuthScreen(
                    context, "Already have an account? ", "Log-In"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpAuthButton(BuildContext context, String buttonName) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width - 60, 30.0),
            elevation: 5.0,
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 7.0,
              bottom: 7.0,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            )),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 25.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () async {
          if (_signUpKey.currentState!.validate()) {
            log('Validated');

            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }

            SystemChannels.textInput.invokeMethod('TextInput.hide');

            final EmailSignUpResults response = await _emailAndPasswordAuth
                .signUpAuth(email: _email.text, pwd: _pwd.text);
            if (response == EmailSignUpResults.SignUpCompleted) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LogInScreen()));
            } else {
              final String msg =
                  response == EmailSignUpResults.EmailAlreadyPresent
                      ? 'Email Already Present'
                      : 'Sign Up Not Completed';
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));
            }
          } else {
            log('Not Validated');
          }

          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
      ),
    );
  }

  Widget signUpSocialMediaIntegrationButtons() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              log('Google Pressed');
              if (mounted) {
                setState(() {
                  _isLoading = true;
                });
              }

              final GoogleSignInResults _googleSignInResults =
                  await _googleAuthentication.signInWithGoogle();

              String msg = '';

              if (_googleSignInResults == GoogleSignInResults.SignInCompleted) {
                msg = 'Sign In Completed';
              } else if (_googleSignInResults ==
                  GoogleSignInResults.SignInNotCompleted) {
                msg = 'Sign In not Completed';
              } else if (_googleSignInResults ==
                  GoogleSignInResults.AlreadySignedIn) {
                msg = 'Already Google SignedIn';
              } else {
                msg = 'Unexpected Error Happen';
              }

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));

              if (_googleSignInResults == GoogleSignInResults.SignInCompleted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TakePrimaryUserData()),
                    (route) => false);
              }

              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            child: Image.asset(
              'assets/images/google.png',
              width: 50.0,
            ),
          ),
          const SizedBox(
            width: 80.0,
          ),
          GestureDetector(
            onTap: () async {
              log('Facebook Pressed');

              if (mounted) {
                setState(() {
                  _isLoading = true;
                });
              }

              final FBSignInResults _fbSignInResults =
                  await _facebookAuthentication.facebookLogIn();

              String msg = '';

              if (_fbSignInResults == FBSignInResults.SignInCompleted) {
                msg = 'Sign In Completed';
              } else if (_fbSignInResults ==
                  FBSignInResults.SignInNotCompleted) {
                msg = 'Sign In not Completed';
              } else if (_fbSignInResults == FBSignInResults.AlreadySignedIn) {
                msg = 'Already Google SignedIn';
              } else {
                msg = 'Unexpected Error Happen';
              }

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg)));

              if (_fbSignInResults == FBSignInResults.SignInCompleted) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TakePrimaryUserData()),
                    (route) => false);
              }

              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            child: Image.asset(
              'assets/images/fbook.png',
              width: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}

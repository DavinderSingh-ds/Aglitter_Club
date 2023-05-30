import 'dart:developer';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_signin/Global_Uses/enum_generation.dart';

class FacebookAuthentication {
  final FacebookAuth _facebookLogin = FacebookAuth.instance;

  Future<FBSignInResults> facebookLogIn() async {
    try {
      if (await _facebookLogin.accessToken == null) {
        final LoginResult _fbLogInResult = await _facebookLogin.login();

        if (_fbLogInResult.status == LoginStatus.success) {
          final OAuthCredential _oAuthCredential =
              FacebookAuthProvider.credential(
                  _fbLogInResult.accessToken!.token);

          if (FirebaseAuth.instance.currentUser != null) {
            FirebaseAuth.instance.signOut();
          }

          final UserCredential fbUser = await FirebaseAuth.instance
              .signInWithCredential(_oAuthCredential);

          log('Fb Log In Info: ${fbUser.user}    ${fbUser.additionalUserInfo}');

          return FBSignInResults.SignInCompleted;
        }
        return FBSignInResults.UnExpectedError;
      } else {
        log('Already Fb Logged In');
        await logOut();
        return FBSignInResults.AlreadySignedIn;
      }
    } catch (e) {
      log('Facebook Log In Error: ${e.toString()}');
      return FBSignInResults.UnExpectedError;
    }
  }

  Future<bool> logOut() async {
    try {
      log('Facebook Log Out');
      if (await _facebookLogin.accessToken != null) {
        await _facebookLogin.logOut();
        await FirebaseAuth.instance.signOut();
        return true;
      }
      return false;
    } catch (e) {
      log('Facebook Log out Error: ${e.toString()}');
      return false;
    }
  }
}

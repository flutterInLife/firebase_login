import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/modals/user.dart';
import 'package:firebase_login/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService {

  final _codeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModal _userFromUser(User user) {
    return user != null ? UserModal(uid: user.uid) : null;
  }

  //Auth change stream
  Stream<UserModal> get user {
    return _auth.authStateChanges()
        .map(_userFromUser);
  }

  //Sign In Anonymously
  Future signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Log Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In with google
  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount account = await GoogleSignIn().signIn();
      UserCredential credential = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken,
          )
      );
      User user = credential.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In with Facebook
  Future signInWithFacebook() async {
    try {
      FacebookLoginResult account = await FacebookLogin().logIn(['email']);
      UserCredential credential = await _auth.signInWithCredential(
          FacebookAuthProvider.credential(account.accessToken.token)
      );
      User user = credential.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In with Phone
  Future signInWithPhone(String phone, BuildContext contextSignIn,) async {
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential verification) async {
          UserCredential credential = await _auth.signInWithCredential(
              verification);
          User user = credential.user;
          return _userFromUser(user);
        },
        verificationFailed: (FirebaseAuthException e) {
          return null;
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
            context: contextSignIn,
            builder: (contextSignIn) {
              return AlertDialog(
                title: Text('Enter the Verification Code'),
                content: TextField(
                  controller: _codeController,
                ),
                actions: [
                  FlatButton(
                    child: Text('Confirm'),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      AuthCredential verification = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                      UserCredential credential = await _auth.signInWithCredential(
                          verification);
                      User user = credential.user;
                      return _userFromUser(user);
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {}
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
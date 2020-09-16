import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/modals/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          if(user!=null) {
            Navigator.pop(contextSignIn);
            _userFromUser(user);
          } else {
            return null;
          }

        },
        verificationFailed: (e) {
          return null;
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
            context: contextSignIn,
            builder: (contextSignIn) {
              return AlertDialog(
                title: Text(
                  'Enter the Verification Code',
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        fontSize: 20,
                      )
                  ),
                ),
                content: TextField(
                  controller: _codeController,
                ),
                actions: [
                  FlatButton(
                    child: Text(
                        'Confirm',
                      style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                              fontSize: 17,
                              color: Colors.green
                          )
                      ),
                    ),
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      AuthCredential verification = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                      UserCredential credential = await _auth.signInWithCredential(
                          verification);
                      User user = credential.user;
                      if(user!=null) {
                        Navigator.pop(contextSignIn);
                        _userFromUser(user);
                      } else {
                        return null;
                      }
                    },
                  )
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              );
            }
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {return null;}
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
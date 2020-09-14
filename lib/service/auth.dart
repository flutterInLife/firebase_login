import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/modals/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModal _userFromUser(User user) {
    return user!=null ? UserModal(uid: user.uid) : null;
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
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Log Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In with google

  //Sign In with Facebook

  //Sign In with Phone


}
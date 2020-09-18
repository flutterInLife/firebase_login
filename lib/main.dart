import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_login/modals/user.dart';
import 'package:firebase_login/screens/wrapper.dart';
import 'package:firebase_login/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//just added a comment SAMYUSH

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModal>.value(
      value: AuthService().user,
      child: Wrapper(),
    );
  }
}

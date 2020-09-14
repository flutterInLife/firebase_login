import 'package:firebase_login/modals/user.dart';
import 'package:firebase_login/screens/authentication/sign_in.dart';
import 'package:firebase_login/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModal>(context);

    if(user==null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}

import 'package:firebase_login/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrapper();
  }
}

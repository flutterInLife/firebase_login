import 'package:firebase_login/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to the Home',
                style: GoogleFonts.rubik(
                    textStyle:
                    TextStyle(color: Colors.black, fontSize: 33, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 10,),
              MaterialButton(
                elevation: 0,
                height: 55,
                minWidth: 180,
                color: Colors.white,
                onPressed: () async {
                  await _auth.signOut();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Container(
                  width: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.exit_to_app, size: 30,),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Log Out',
                        style: GoogleFonts.rubik(
                            textStyle:
                            TextStyle(color: Colors.black, fontSize: 15)),
                      ),
                    ],
                  ),
                ),
              ), //Phone Sign In
            ],
          ),
        ),
      ),
    );
  }
}

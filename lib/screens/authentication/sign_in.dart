import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/background.jpeg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  elevation: 0,
                  height: 55,
                  minWidth: 240,
                  color: Colors.white,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Container(
                    width: 255,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/google-icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Sign In with Google',
                          style: GoogleFonts.rubik(
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                ), //Google Sign In
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  elevation: 0,
                  height: 55,
                  minWidth: 240,
                  color: Colors.white,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Container(
                    width: 255,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/facebook-icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Sign In with Facebook',
                          style: GoogleFonts.rubik(
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                ), //facebook Sign In
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  elevation: 0,
                  height: 55,
                  minWidth: 240,
                  color: Colors.white,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Container(
                    width: 255,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/phone-icon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Sign In with Phone Number',
                          style: GoogleFonts.rubik(
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                ), //Phone Sign In
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Text(
              'Firebase Sign In',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  textStyle:
                  TextStyle(color: Colors.black, fontSize: 35,)),
            ),
          )
        ],
      ),
    );
  }
}

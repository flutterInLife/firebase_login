import 'package:firebase_login/loading.dart';
import 'package:firebase_login/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_phone_input/international_phone_input.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool loading = false;
  bool loadingGoogle = false;
  bool loadingFacebook = false;
  bool loadingPhone = false;
  bool signInPhone = false;

  String _phone = "";

  final _phoneController = TextEditingController();

  void onPhoneChanged(String number, String completeNumber, String isoCode) {
    setState(() {
      _phone=completeNumber;
    });
    print(_phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  onPressed: () async {
                    setState(() {
                      loadingGoogle = true;
                    });
                    dynamic result = await _auth.signInWithGoogle();
                    if (result == null) {
                      setState(() {
                        loadingGoogle = false;
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Container(
                    width: 255,
                    child: loadingGoogle
                        ? Loading()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 25,
                                width: 25,
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
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 15)),
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
                  color: Color(0xff3C5998),
                  onPressed: () async {
                    setState(() {
                      loadingFacebook = true;
                    });
                    dynamic result = await _auth.signInWithFacebook();
                    if (result == null) {
                      setState(() {
                        loadingFacebook = false;
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Container(
                    width: 255,
                    child: loadingFacebook
                        ? Loading()
                        : Row(
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
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                            ],
                          ),
                  ),
                ), //facebook Sign In
                signInPhone
                    ? SizedBox(
                        height: 30,
                      )
                    : SizedBox(),
                signInPhone
                    ? Container(
                      color: Colors.green.withOpacity(0.6),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: InternationalPhoneInput(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(fontSize: 15),
                              contentPadding: EdgeInsets.only(
                                left: 20,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)))),
                          initialSelection: 'NP',
                          onPhoneNumberChange: onPhoneChanged,
                        ),
                      ),
                    )
                    : SizedBox(),
                SizedBox(
                  height: 10,
                ),
                signInPhone
                    ? MaterialButton(
                        elevation: 0,
                        height: 55,
                        minWidth: 155,
                        color: Colors.green,
                        onPressed: () async {
                          if(_phone!="") {
                            setState(() {
                              loadingPhone = true;
                            });
                            dynamic result =
                            await _auth.signInWithPhone(_phone, context);
                          } else {
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 0,
                                  duration: Duration(milliseconds: 800),
                                  backgroundColor: Colors.red[700],
                                  content: Text(
                                      'Mobile Number not valid!',
                                      style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            letterSpacing: 1
                                        ),
                                      )
                                  ),
                                )
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          width: 155,
                          child: loadingPhone
                              ? Loading()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Next',
                                      style: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                    ),
                                  ],
                                ),
                        ),
                      )
                    : MaterialButton(
                        elevation: 0,
                        height: 55,
                        minWidth: 240,
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            signInPhone = true;
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          width: 255,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(
                                  'assets/phone-icon.svg',
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Sign In with Phone Number',
                                style: GoogleFonts.rubik(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 15)),
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
                  textStyle: TextStyle(
                color: Colors.black,
                fontSize: 35,
              )),
            ),
          )
        ],
      ),
    );
  }
}

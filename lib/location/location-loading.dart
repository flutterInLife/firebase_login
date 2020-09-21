import 'package:firebase_login/location/location-screen.dart';
import 'package:firebase_login/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final AuthService _auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationPermission();
  }


  getLocationPermission() async {
    // bool isLocationServiceEnabled = await isLocationServiceEnabled();
    LocationPermission permission = await requestPermission();
    print(permission);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LocatingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SpinKitDoubleBounce(
        color: Colors.grey,
        size: 100.0,
        // duration: const Duration(seconds: 3),
      ),
    );
  }
}
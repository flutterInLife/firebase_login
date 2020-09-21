import 'package:firebase_login/location/location-loading.dart';
import 'package:firebase_login/main.dart';
import 'package:firebase_login/modals/location-list.dart';
import 'package:firebase_login/screens/authentication/sign_in.dart';
import 'package:firebase_login/screens/wrapper.dart';
import 'package:firebase_login/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class LocatingPage extends StatefulWidget {
  @override
  _LocatingPageState createState() => _LocatingPageState();
}

class _LocatingPageState extends State<LocatingPage> {

  LocationList loc = LocationList();

  final AuthService _auth = AuthService();

  final LoadingScreen loadingScreen = LoadingScreen();

  double latitudes,
      longitudes,
      distanceInMeter,
      endLatitude,
      endLongitude,
      shortestDistance;

  List<double> distanceList = [];

  Future<void> getCurrentLocation() async {
    try {
      Position position =
      await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitudes = position.latitude;
      longitudes = position.longitude;

      print(position);
    } catch (e) {
      print(e);
    }
  }

  void updateEndLocation() {
    try {
      setState(() {
        endLatitude = loc.getNextLatitude();
        endLongitude = loc.getNextLongitude();
        print('endLatitude $endLatitude and endLongitude $endLongitude');
        loc.nextLocation();
      });
    } catch (e) {
      print(e);
    }
  }

  void sortingDistance() {
    distanceList.sort();
    print(distanceList);
    setState(() {
      shortestDistance = distanceList[0];
    });
    print('shortest distance is $shortestDistance');
  }

  void measureDistance() {
    // startLatitude	double	Latitude of the start position
    // startLongitude	double	Longitude of the start position
    // endLatitude	double	Latitude of the destination position
    // endLongitude	double	Longitude of the destination position
    try {
      double distanceInMeters =
      distanceBetween(latitudes, longitudes, endLatitude, endLongitude);
      print('distance $distanceInMeters');
      setState(() {
        distanceList.add(distanceInMeters);
      });
      if (distanceInMeters != null) {
        setState(() {
          distanceInMeter = distanceInMeters;
        });
        print('distance list is $distanceList');
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    measureDistance();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Distance between two location'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // color: Colors.lightGreen,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child:
                          Text('Longitude: $longitudes \n\n Latitude:$latitudes'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text('Distance: $distanceInMeter'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text('Nearest location is $shortestDistance'),
                        ),
                      ),
                    ),
                    Column(
                      children: [Text(distanceList.toString(), textAlign: TextAlign.center,)],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: MaterialButton(
                        elevation: 0,
                        height: 55,
                        minWidth: 180,
                        color: Colors.white,
                        onPressed: () async {
                          _auth.signOut();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => Main()
                          ));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: Container(
                          width: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.exit_to_app,
                                size: 30,
                                color: Colors.black,
                              ),
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 31),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton.extended(
                    heroTag: 'one',
                    onPressed: () {
                      sortingDistance();
                    },
                    label: Text('Search nearest'),
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.extended(
                  heroTag: 'two',
                  onPressed: () {
                    updateEndLocation();
                    measureDistance();
                  },
                  label: Text('Add location'),
                  icon: Icon(Icons.add_circle),
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          )),
    );
  }
}
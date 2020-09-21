import 'package:firebase_login/modals/location-format.dart';

class LocationList {
  int _nextLocation = 0;

  List<LocationFormat> _locationList = [
    LocationFormat(987.243, 789.24424),
    LocationFormat(123.243, 321.24424),
    LocationFormat(090.243, 010.24424),
    LocationFormat(342.243, 434.24424),
    LocationFormat(120.243, 80.24424),
    LocationFormat(672.243, 1456.24424),
    LocationFormat(123.243, 213.24424),
    LocationFormat(655.243, 345.24424),
  ];
  void nextLocation() {
    if (_nextLocation < _locationList.length - 1) {
      _nextLocation++;
    }
  }

  double getNextLatitude() {
    return _locationList[_nextLocation].endLatitude;
  }

  double getNextLongitude() {
    return _locationList[_nextLocation].endLongitude;
  }
}
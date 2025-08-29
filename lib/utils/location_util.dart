import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<(double, double)> getCurrentLocationCoordinates() async {
  LocationPermission permission = await Geolocator.checkPermission();

  //get permission from user to access location
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  //get current user coordinates
  LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
  );
  Position position = await Geolocator.getCurrentPosition(
    locationSettings: locationSettings,
  );

  return (position.latitude, position.longitude);
}

//Gets location name from coordinates
Future<String> getCurrentLocationName(double lat, double lon) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

  return placemarks[0].locality ?? "";
}

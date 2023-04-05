import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentPosition() async {
  bool serviceEnable;
  LocationPermission permission;

  serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnable) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return pos;
}

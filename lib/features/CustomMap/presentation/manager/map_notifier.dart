import 'package:geolocator/geolocator.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapNotifier extends StateNotifier<void> {
  MapNotifier(void state) : super(state);

  Future<Position> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Geolocator.openAppSettings();
    }
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.

      return Future.error('Location permissions are denied');
    }
// When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart' as loc;
import 'i_location_service.dart';

final locationService = Provider<ILocationService>(
  (ref) => GeoLocatorLocationService(),
);

class GeoLocatorLocationService implements ILocationService {
  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> isWhileInUsePermissionGranted() async {
    return await Geolocator.checkPermission() == LocationPermission.whileInUse;
  }

  @override
  Future<bool> isAlwaysPermissionGranted() async {
    return await Geolocator.checkPermission() == LocationPermission.always;
  }

  @override
  Future<bool> enableLocationService() async {
    bool serviceEnabled = await isLocationServiceEnabled();
    if (serviceEnabled) {
      return true;
    } else {
      serviceEnabled = await loc.Location().requestService();
      return serviceEnabled;
    }
  }

  @override
  Future<bool> requestWhileInUsePermission() async {
    if (await isWhileInUsePermissionGranted()) {
      return true;
    } else {
      final permissionGranted = await Geolocator.requestPermission();
      return permissionGranted == LocationPermission.whileInUse;
    }
  }

  @override
  Future<bool> requestAlwaysPermission() async {
    if (await isAlwaysPermissionGranted()) {
      return true;
    } else {
      await Geolocator.requestPermission();
      return await isAlwaysPermissionGranted();
    }
  }

  

  @override
  Future<Position?> getLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds:20),
      );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

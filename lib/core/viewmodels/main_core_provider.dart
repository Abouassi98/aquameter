import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../utils/services/connectivity_service.dart';
import '../utils/services/location_service/i_location_service.dart';
import '../utils/services/location_service/location_service.dart';

final mainCoreProvider =
    Provider<MainCoreProvider>((ref) => MainCoreProvider(ref));

class MainCoreProvider {
  MainCoreProvider(this.ref) {
    _locationService = ref.watch(locationService);
    _connectivityService = ref.watch(connectivityService);
  }

  final Ref ref;

  late ILocationService _locationService;
  late IConnectivityService _connectivityService;

  ///Location module methods
  Future<bool> enableLocationAndRequestPermission() async {
    bool locationServiceEnabled = await enableLocationService();
    if (locationServiceEnabled) {
      return await requestLocationPermission();
    } else {
      return false;
    }
  }

  Future<bool> enableLocationService() async {
    return await _locationService.enableLocationService();
  }

  Future<bool> requestLocationPermission() async {
    final inUse = await _locationService.requestWhileInUsePermission();
    if (Platform.isAndroid) {
      final always = await _locationService.requestAlwaysPermission();
      return inUse || always;
    } else {
      return inUse;
    }
  }

  Future<bool> isAllLocationPermissionsRequired() async {
    if (Platform.isAndroid) {
      return await _locationService.isLocationServiceEnabled() &&
          await _locationService.isAlwaysPermissionGranted();
    } else {
      return await _locationService.isLocationServiceEnabled() &&
          await _locationService.isWhileInUsePermissionGranted();
    }
  }

  Future<Position?> getCurrentUserLocation() async {
    return await _locationService.getLocation();
  }

  ///Connection module methods
  Future<bool> isConnectedToInternet() async {
    return await _connectivityService.checkIfConnected();
  }
}

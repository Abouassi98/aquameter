import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Home/Data/clients_model/client_model.dart';

final AutoDisposeStateProvider<String?> mapAddress =
    StateProvider.autoDispose<String?>((ref) => null);
final StateNotifierProvider<MapNotifier, Object?> mapNotifier =
    StateNotifierProvider(
  (ref) => MapNotifier(ref),
);

class MapNotifier extends StateNotifier<AsyncValue<String>> {
  MapNotifier(this.ref) : super(const AsyncValue.data(''));
  final Ref ref;
  final Set<Marker> markers = {};
  
  BitmapDescriptor? userLocationIcon;
  Marker? _addressMarker;

  void selectAddress(String addressParm) {
    state = AsyncValue.data(addressParm);
  }

  Future<Uint8List> _getBytesFromAsset(
    String path,
    int width,
  ) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  setCustomMapPin() async {
    final Uint8List homeIcon =
        // await _getBytesFromAsset('assets/images/loc.png', 90);
        await _getBytesFromAsset('assets/images/marker.png', 90);

    userLocationIcon = BitmapDescriptor.fromBytes(homeIcon);
    debugPrint('get Map Image');
  }

  Future<Position> addMareker(Client client) async {
    await setCustomMapPin();
    await placemarkFromCoordinates(client.lat,client.long).then((value) {
      state = AsyncValue.data(value[0].street!);
    });
    _addressMarker = Marker(
      markerId: const MarkerId('address2'),
      position: LatLng(client.lat,client.long),
      infoWindow: InfoWindow(title: 'موقع العميل', onTap: () {}),
      icon: userLocationIcon!,
    );
    markers.add(_addressMarker!);

    return Position(
        longitude:client.long,
        latitude: client.lat,
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        timestamp: DateTime.now(),
        floor: null,
        isMocked: false);
  }

  Future<Position> determinePosition() async {
  
    state = const AsyncValue.data('');
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

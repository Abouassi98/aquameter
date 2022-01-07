import 'dart:async';
import 'dart:io';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_launcher/map_launcher.dart';
import '../providers.dart';
import 'maps_sheet.dart';

// ignore: must_be_immutable
class CustomMap extends HookConsumerWidget {
  CustomMap({
    Key? key,
  }) : super(key: key);

  final Set<Marker> _markers = {};

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Placemark> placemarks = [];
  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      // Permissions are denied forever, handle appropriately.
      await Geolocator.openAppSettings();
      return Future.error('Location permissions are denied');
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else if (!serviceEnabled) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return Future.error('Location services are disabled.');
    }

    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double intialLat = 0.0, intialLong = 0.0;
  bool init = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );

    ValueNotifier<bool> init = useState<bool>(false);
    Future.delayed(const Duration(microseconds: 0)).then((value) async {
      await _determinePosition(context).then((value) async {
        intialLat = value.latitude;
        intialLong = value.longitude;
      });
      init.value = true;
    });
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      body: init.value == false
          ? const AppLoader()
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  mapToolbarEnabled: true,
                  zoomControlsEnabled: true,
                  scrollGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  onCameraMove: (v) {
                    addClient.lat = v.target.latitude.toString();
                    addClient.long = v.target.longitude.toString();
                    placemarkFromCoordinates(
                            v.target.latitude, v.target.longitude)
                        .then((value) => addClient.address = value[0].street!);
                  },
                  markers: _markers.toSet(),
                  initialCameraPosition: CameraPosition(
                    zoom: 14,
                    target: LatLng(intialLat, intialLong),
                  ),
                ),
                pin(),
                Platform.isIOS
                    ? InkWell(
                        onTap: () {
                          MapsSheet.show(
                            context: context,
                            onMapTap: (map) {
                              map.showMarker(
                                coords: Coords(intialLat, intialLong),
                                title: '  ',
                                // zoom: zoom,
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Icon(
                                Icons.location_on,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }

  Widget pin() {
    return IgnorePointer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Icon(Icons.place, size: 56),
            SizedBox(
                width: 60,
                height: 60,
                child: Image.asset('assets/images/marker.png')),
            Container(
              decoration: const ShapeDecoration(
                shadows: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black38,
                  ),
                ],
                shape: CircleBorder(
                  side: BorderSide(
                    width: 4,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}

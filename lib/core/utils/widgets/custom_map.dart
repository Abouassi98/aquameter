import 'dart:async';
import 'dart:io';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/localization/manager/app_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'app_loader.dart';
import 'custom_dialog.dart';
import 'maps_sheet.dart';

class CustomMap extends StatefulWidget {
  final double driverLat, driverLong;
  const CustomMap({
    Key? key,
    required this.driverLat,
    required this.driverLong,
  }) : super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final Set<Marker> _markers = {};
  BitmapDescriptor? driverLocationIcon;
  BitmapDescriptor? userLocationIcon;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await Geolocator.openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (!serviceEnabled) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: localization
                  .text('please_activate_the_geographical_location'),
              widget: [
                Center(
                  child: CustomTextButton(
                    title: localization.text('activate'),
                    function: () {
                      Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high)
                          .then((value) {
                        pop();
                        pushReplacement(CustomMap(
                            driverLat: widget.driverLat,
                            driverLong: widget.driverLong));
                      });
                    },
                  ),
                )
              ],
            );
          });
      return Future.error('Location services are disabled.');
    }

    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  bool init = true;
  @override
  void didChangeDependencies() async {
    if (init) {
      await Future.delayed(const Duration(microseconds: 0)).then((value) async {
        await _determinePosition().then((value) async {});
      });
      setState(() {
        init = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      body: init == true
          ? const Center(
              child: AppLoader(),
            )
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
                  onCameraMove: (_) {},
                  markers: _markers.toSet(),
                  initialCameraPosition: CameraPosition(
                    zoom: 14,
                    target: LatLng(widget.driverLat, widget.driverLong),
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
                                coords:
                                    Coords(widget.driverLat, widget.driverLong),
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

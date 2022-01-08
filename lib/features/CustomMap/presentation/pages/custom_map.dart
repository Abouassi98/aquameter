import 'dart:io';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../../../core/utils/providers.dart';
import '../../../../core/utils/widgets/maps_sheet.dart';

class CustomMap extends HookConsumerWidget {
  CustomMap({
    Key? key,
  }) : super(key: key);

  final FutureProvider<Position> provider =
      FutureProvider<Position>((ref) async {
    return await ref
        .read(mapNotifier.notifier)
        .determinePosition(); //; may cause `provider` to rebuild
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'تحديد موقع العميل',
              style: MainTheme.headingTextStyle,
            ),
          ),
          body: ref.watch(provider).when(
                error: (e, o) {
                  debugPrint(e.toString());
                  debugPrint(o.toString());
                  return const Text('error');
                },
                loading: () => const AppLoader(),
                data: (e) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GoogleMap(
                      mapToolbarEnabled: true,
                      zoomControlsEnabled: true,
                      scrollGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      gestureRecognizers: <
                          Factory<OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      onCameraMove: (v) {
                        addClient.lat = v.target.latitude.toString();
                        addClient.long = v.target.longitude.toString();
                        placemarkFromCoordinates(
                                v.target.latitude, v.target.longitude)
                            .then((value) =>
                                addClient.address = value[0].street!);
                      },
                      initialCameraPosition: CameraPosition(
                        zoom: 14,
                        target: LatLng(e.latitude, e.longitude),
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
                                    coords: Coords(e.latitude, e.longitude),
                                    title: '  ',
                                    // zoom: zoom,
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 10),
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
              ),
        ));
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

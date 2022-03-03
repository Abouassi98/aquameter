import 'dart:io';

import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/functions/helper.dart';
import 'package:aquameter/core/utils/functions/helper_functions.dart';
import 'package:aquameter/core/utils/widgets/app_loader.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../../core/utils/size_config.dart';
import '../manager/map_notifier.dart';
import '../widgets/maps_sheet.dart';

class CustomMap extends HookConsumerWidget {
  final bool? show;
  final String? address;
  CustomMap({
    Key? key,
    this.show,
    this.address,
  }) : super(key: key);

  final FutureProvider<Position> provider =
      FutureProvider<Position>((ref) async {
    return await ref
        .read(mapNotifier.notifier)
        .determinePosition(); //; may cause `provider` to rebuild
  });
  final FutureProvider<Position> provider2 =
      FutureProvider<Position>((ref) async {
    return await ref
        .read(mapNotifier.notifier)
        .addMareker(); //; may cause `provider` to rebuild
  });
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );
    final MapNotifier map = ref.read(
      mapNotifier.notifier,
    );
    final newAddress = ref.watch(mapAddress);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'تحديد موقع العميل',
              style: MainTheme.headingTextStyle,
            ),
          ),
          body: ref.watch(map.initialLat == null ? provider : provider2).when(
                error: (e, o) {
                  debugPrint(e.toString());
                  debugPrint(o.toString());

                  return const Center(
                      child: Text(
                          'بعد الموافقه ع اذن الوصول للخرائط يرجي الرجوع ودخول نفس الصفحه مره اخري'));
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
                      markers: map.initialLat == null ? {} : map.markers,
                      onCameraMove: (v) {
                        if (show != true) {
                          addClient.lat = v.target.latitude.toString();
                          addClient.long = v.target.longitude.toString();

                          placemarkFromCoordinates(
                                  v.target.latitude, v.target.longitude)
                              .then((value) {
                            addClient.address = value[0].street!;
                            ref
                                .read(
                                  mapAddress.state,
                                )
                                .state = value[0].street!;
                          });
                        }
                      },
                      initialCameraPosition: CameraPosition(
                        zoom: 14,
                        target: LatLng(e.latitude, e.longitude),
                      ),
                    ),
                    if (show != true) pin(),
                    Platform.isIOS && (show == true || map.initialLat != null)
                        ? InkWell(
                            onTap: () {
                              MapsSheet.show(
                                context: context,
                                onMapTap: (maps) {
                                  maps.showMarker(
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
          floatingActionButtonLocation:
              show != true ? FloatingActionButtonLocation.centerDocked : null,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
                  Container(
                    width: SizeConfig.screenWidth * 0.7,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black38),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: SizeConfig.screenWidth * 0.5,
                            child: Text(
                                newAddress ??address??
                                    'حرك المؤشر ليتم اختيار العنوان المناسب لك',
                                style: MainTheme.hintTextStyle
                                    .copyWith(color: Colors.black),
                                maxLines: null)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 15,
                            child: const Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.white,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (show != true)
                CustomTextButton(
                  title: 'حفظ',
                  function: () {
                    if (addClient.lat == null) {
                      HelperFunctions.errorBar(context,
                          message: 'يجب عليك اختيار عنوان ');
                    } else {
                      pop();
                    }
                  },
                ),
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

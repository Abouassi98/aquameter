import 'dart:io';
import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../../../core/component/retry_again_component.dart';
import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/loading_indicators.dart';
import '../../../Home/Data/clients_model/client_model.dart';
import '../manager/map_notifier.dart';
import '../widgets/maps_sheet.dart';

final FutureProviderFamily<Position, Client> provider2 =
    FutureProvider.family<Position, Client>((ref, client) async {
  return await ref
      .read(mapNotifier.notifier)
      .addMareker(client); //; may cause `provider` to rebuild
});

class CustomMapEditAndShowAddress extends ConsumerWidget {
  final bool? show;
  final String? address;
  final Client? client;
  const CustomMapEditAndShowAddress({
    Key? key,
    this.show,
    this.address,
    this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );
    final MapNotifier map = ref.read(
      mapNotifier.notifier,
    );
    final newAddress = ref.watch(mapAddress);
    return PopUpPage(
      appBar: PlatformAppBar(
        title: Text(
          show == true ? 'موقع العميل' : 'تحديد موقع العميل',
          style: MainTheme.headingTextStyle,
        ),
      ),
      body: ref.watch(provider2(client!)).when(
            loading: () => LoadingIndicators.instance.defaultLoadingIndicator(
              context,
              message: tr(context).determine_location,
            ),
            error: (e, o) {
              debugPrint(e.toString());
              debugPrint(o.toString());
              return const RetryAgainComponent(
                description: 'يرجي اغلاق التطبيق ثم فتحه',
              );
            },
            data: (e) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  mapToolbarEnabled: true,
                  zoomControlsEnabled: true,
                  scrollGesturesEnabled: true,
                  rotateGesturesEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  liteModeEnabled: show==true?true:false,
                  markers: map.markers,
                  onCameraMove: (v) {
                    if (show != true) {
                      addClient.lat = v.target.latitude.toString();
                      addClient.long = v.target.longitude.toString();

                      placemarkFromCoordinates(
                              v.target.latitude, v.target.longitude)
                          .then((value) {
                        addClient.address = value[0].street!;
                      });
                    }
                  },
                  onCameraIdle: () {
                    if (show != true) {
                      ref
                          .read(
                            mapAddress.state,
                          )
                          .state = addClient.address;
                    }
                  },
                  initialCameraPosition: CameraPosition(
                    zoom: 14,
                    target: LatLng(e.latitude, e.longitude),
                  ),
                ),
                if (show != true) pin(),
                Platform.isIOS && (show == true)
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
          ),
      floatingActionButtonLocation:
          show != true ? FloatingActionButtonLocation.centerDocked : null,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: Sizes.fullScreenWidth(context) * 0.7,
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
                      width: Sizes.fullScreenWidth(context) * 0.5,
                      child: Text(
                          newAddress ??
                              address ??
                              'حرك المؤشر ليتم اختيار العنوان المناسب لك',
                          style: MainTheme.hintTextStyle
                              .copyWith(color: Colors.black),
                          maxLines: null)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.white,
                      ),
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
                    NavigationService.goBack(
                      context,
                    );
                  }
                },
              ),
          ],
        ),
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

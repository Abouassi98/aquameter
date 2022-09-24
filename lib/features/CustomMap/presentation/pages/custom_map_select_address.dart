
import 'package:aquameter/core/screens/popup_page.dart';
import 'package:aquameter/core/themes/themes.dart';
import 'package:aquameter/core/utils/widgets/text_button.dart';
import 'package:aquameter/features/profileClient/presentation/manager/add_client_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/component/retry_again_component.dart';
import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/location_error.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/services/localization_service.dart';
import '../../../../core/utils/sizes.dart';
import '../../../../core/utils/widgets/loading_indicators.dart';
import '../../../../core/viewmodels/location_service_provider/location_service_provider.dart';
import '../../../../core/viewmodels/location_service_provider/location_service_state.dart';
import '../manager/map_notifier.dart';

class CustomMapSelectAddress extends ConsumerWidget {
  const CustomMapSelectAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationServiceState locationService =
        ref.watch(locationServiceProvider);
    final AddClientNotifier addClient = ref.read(
      addClientNotifier.notifier,
    );

    final newAddress = ref.watch(mapAddress);
    return PopUpPage(
      appBar: PlatformAppBar(
        title: Text(
          'تحديد موقع العميل',
          style: MainTheme.headingTextStyle,
        ),
      ),
      body: locationService.when(
        loading: () => LoadingIndicators.instance.defaultLoadingIndicator(
          context,
          message: tr(context).determine_location,
        ),
        error: (error) => RetryAgainComponent(
          description: getLocationErrorText(context, error),
        ),
        available: (e) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              mapToolbarEnabled: true,
              zoomControlsEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onCameraMove: (v) {
                addClient.lat = v.target.latitude.toString();
                addClient.long = v.target.longitude.toString();

                placemarkFromCoordinates(v.target.latitude, v.target.longitude)
                    .then((value) {
                  addClient.address = value[0].street!;
                });
              },
              onCameraIdle: () {
                ref
                    .read(
                      mapAddress.state,
                    )
                    .state = addClient.address;
              },
              initialCameraPosition: CameraPosition(
                zoom: 14,
                target: LatLng(e.latitude, e.longitude),
              ),
            ),
            pin(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

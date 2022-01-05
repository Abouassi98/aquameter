import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationProvider extends StateNotifier<void> {
  double? lat;
  double? long;
  String? address;
  LocationProvider(void state) : super(state);
  void assignLocation(
      {double? latitude, double? longtuide, String? addressDetails}) {
    address = addressDetails;
  }
}

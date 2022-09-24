import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../utils/location_error.dart';
import '../../utils/services/location_service/i_location_service.dart';
import '../../utils/services/location_service/location_service.dart';
import '../main_core_provider.dart';
import 'location_service_state.dart';

final locationServiceProvider =
    StateNotifierProvider<LocationServiceNotifier, LocationServiceState>((ref) {
  return LocationServiceNotifier(ref);
});

class LocationServiceNotifier extends StateNotifier<LocationServiceState> {
  LocationServiceNotifier(this.ref)
      : super(const LocationServiceState.loading()) {
    _mainCoreProvider = ref.watch(mainCoreProvider);
    locationServicE = ref.watch(locationService);
    getCurrentLocation();
  }

  final Ref ref;
  late MainCoreProvider _mainCoreProvider;
  late ILocationService locationServicE;

  StreamSubscription? _currentLocationSubscription;
  Timer? _locationChangeTimer;
  bool isEnableOnLocationChanged = true;

  Future getCurrentLocation() async {
    state = const LocationServiceState.loading();

    bool enabled = await _mainCoreProvider.enableLocationService();
    if (!enabled) {
      toggleError(LocationError.notEnabledLocation);
      return;
    }
    bool locationGranted = await _mainCoreProvider.requestLocationPermission();
    if (!locationGranted) {
      toggleError(LocationError.notGrantedLocationPermission);
      return;
    }

    final currentLocation = await _mainCoreProvider.getCurrentUserLocation();
    if (currentLocation == null) {
      toggleError(LocationError.getLocationTimeout);
      return;
    } else {
      state = LocationServiceState.available(currentLocation);
    }
  }

  toggleError(LocationError error) {
    state = LocationServiceState.error(error);
  }

  @override
  void dispose() {
    _currentLocationSubscription?.cancel();
    _locationChangeTimer?.cancel();
    super.dispose();
  }
}

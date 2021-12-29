import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';

class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        debugPrint('ConnectivityStatus Cellular');
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        debugPrint('ConnectivityStatus WiFi');
        return ConnectivityStatus.wifi;
      case ConnectivityResult.none:
        debugPrint('ConnectivityStatus Offline');
        return ConnectivityStatus.offline;
      default:
        debugPrint('ConnectivityStatus Offline');
        return ConnectivityStatus.offline;
    }
  }
}

enum ConnectivityStatus { wifi, cellular, offline }

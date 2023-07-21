import 'package:connectivity_checker/connectivity_checker.dart';

class CheckConnectivity {
  isConnected() async {
    return await ConnectivityWrapper.instance.isConnected;
  }
}

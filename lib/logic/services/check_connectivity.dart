import 'package:connectivity_checker/connectivity_checker.dart';

class CheckConnectivity {
  final Future<bool> _isConnectedFuture = ConnectivityWrapper.instance.isConnected;
  Stream<bool> getConnectedStream() => _isConnectedFuture.asStream();
}

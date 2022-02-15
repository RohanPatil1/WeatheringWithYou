import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkConnected() async {
  final result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) return false;
  return true;
}

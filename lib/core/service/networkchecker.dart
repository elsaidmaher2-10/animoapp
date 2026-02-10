import 'package:connectivity_plus/connectivity_plus.dart';

class Networkchecker {
 static Future<bool> checkinternet() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    return !(connectivityResult.contains(ConnectivityResult.none));
  }
}

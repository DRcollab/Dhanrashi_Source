//
// import 'package:flutter/material.dart';
//
//
// class ConnectivityChangeNotifier extends ChangeNotifier {
//   ConnectivityChangeNotifier() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       resultHandler(result);
//     });
//   }
//   ConnectivityResult _connectivityResult = ConnectivityResult.none;
//
//
//   ConnectivityResult get connectivity => _connectivityResult;
//
//
//   void resultHandler(ConnectivityResult result) {
//     _connectivityResult = result;
//     if (result == ConnectivityResult.none) {
//       // _svgUrl = 'assets/serverDown.svg';
//       // _pageText =
//       //'Currently connected to no network. Please connect to a wifi network!';
//     } else if (result == ConnectivityResult.mobile) {
//       // _svgUrl = 'assets/noWifi.svg';
//       // _pageText =
//       // 'Currently connected to a celluar network. Please connect to a wifi network!';
//     } else if (result == ConnectivityResult.wifi) {
//       // _svgUrl = 'assets/connected.svg';
//       // _pageText = 'Connected to a wifi network!';
//     }
//     notifyListeners();
//   }
//
//   void initialLoad() async {
//     ConnectivityResult connectivityResult =
//     await (Connectivity().checkConnectivity());
//     resultHandler(connectivityResult);
//   }
// }
//

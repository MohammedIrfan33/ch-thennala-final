//
//
// import 'dart:async';
// import 'dart:developer' as developer;
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
//
//
//
//
//
// class MyHomePagenew extends StatefulWidget {
//   const MyHomePagenew({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePagenew> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePagenew> {
//   List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initConnectivity() async {
//     late List<ConnectivityResult> result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       developer.log('Couldn\'t check connectivity status', error: e);
//       return;
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//
//       if (result.contains(ConnectivityResult.wifi)) {
//        // print("Connected to WiFi");
//       } else if (result.contains(ConnectivityResult.mobile)) {
//        // print("Connected to Mobile Data");
//       } else if (result.contains(ConnectivityResult.ethernet)) {
//        // print("Connected to Ethernet");
//       } else if (result.contains(ConnectivityResult.vpn)) {
//        // print("Connected via VPN");
//       } else if (result.contains(ConnectivityResult.bluetooth)) {
//        // print("Connected via Bluetooth");
//       } else if (result.contains(ConnectivityResult.other)) {
//        // print("Connected via Other Network");
//       } else {
//        // print("No Internet Connection");
//       }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connectivity Plus Example'),
//         elevation: 4,
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Spacer(flex: 2),
//           Text(
//             'Active connection types:',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const Spacer(),
//           ListView(
//             shrinkWrap: true,
//             children: List.generate(
//                 _connectionStatus.length,
//                     (index) => Center(
//                   child: Text(
//                     _connectionStatus[index].toString(),
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                 )),
//           ),
//           const Spacer(flex: 2),
//         ],
//       ),
//     );
//   }
// }
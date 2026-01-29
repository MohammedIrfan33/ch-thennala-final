// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
//
// import '../ApiLists/Apis.dart';
//
//
//
//
// class GoogleScreen extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<GoogleScreen> {
//   final _paymentItems = [
//     PaymentItem(
//       label: 'Total',
//       amount: '99.99',
//       status: PaymentItemStatus.final_price,
//     )
//   ];
//
//   void onGooglePayResult(paymentResult) {
//     // Handle the result of the payment
//    //print(paymentResult);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text('Google Pay Integration'),
//       ),
//       body: Center(
//         child:Container(
//           height: 100,
//           width: 500,
//           color: Colors.yellow,
//           child: GooglePayButton(
//             paymentConfiguration: PaymentConfiguration.fromJsonString(
//                 defaultGooglePay),
//             paymentItems: _paymentItems,
//             type: GooglePayButtonType.buy,
//
//
//             margin: const EdgeInsets.only(top: 15.0),
//             onPaymentResult: onGooglePayResult,
//             loadingIndicator: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

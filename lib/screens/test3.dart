import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class paymenttest extends StatefulWidget{
  @override
  State<paymenttest> createState() => _paymenttestState();
}

class _paymenttestState extends State<paymenttest> {











  Future<void> launchUPI() async {

    String mc="2050263";
    String transactionRef = "hdfcbank${DateTime.now().millisecondsSinceEpoch}$mc";



    String upiUrl = "upi://pay?pa=chcentretirur.76073368@hdfcbank&pn=INDIAN+UNION+MUSLIM+LEAGUE+KOZHIKODE+DIST+CMTE&mc=2050263&tr=$transactionRef&tn=CALICUT+BAFAQI1738747031471211Ln&am=2.00&cu=INR";

    Uri uri = Uri.parse(upiUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch UPI payment";
    }
  }




  @override
  Widget build(BuildContext context) {

   return  Scaffold(

     body: Center(
       child: ElevatedButton(onPressed: () => launchUPI(), child: Text("PAY")),
     ),


   );
  }
}
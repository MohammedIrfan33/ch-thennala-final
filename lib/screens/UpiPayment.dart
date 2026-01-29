import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/my_textfield.dart';


class UpiPayment extends StatelessWidget {
  final String upiId = "sooriachu@okicici";
  final String name = "Sooraj R.K";
  final double amount = 1.00;
  //final String transactionNote = "Payment";
  final String transactionRefId = "T0000999";

  void _initiateTransaction(BuildContext context,String amt,String usrname,String ward) async {

     if(amt.isEmpty&& ward.isEmpty&&usrname.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Text box can't be blank")),
       );
       return;
     }


    // UPI URL scheme
    String upiUrl = "upi://pay?pa=$upiId&pn=$name&am=$amt&tr=$transactionRefId&cu=INR";
    //String encodedUrl = Uri.encodeFull("upi://pay?pa=receiver@upi&pn=Receiver Name&mc=&tid=&tr=T123456789&tn=Payment&am=10.00&cu=INR");

    // Encode the URL
    String encodedUrl = Uri.encodeFull(upiUrl);

    // Check if there is any app that can handle this URL
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      // Show an error if no UPI apps are available
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No UPI apps found on your device')),
      );
    }
  }
  TextEditingController Aount=TextEditingController();
  TextEditingController nameoftheward=TextEditingController();
  TextEditingController enterid=TextEditingController();

  PreferredSize get _appBar {
    return const PreferredSize(
      preferredSize:  Size.fromHeight(90),
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
                'Close Your Payment',
                style: TextStyle(
                  color: Color(0xFF3A3A3A),
                  fontSize: 20,
                  fontFamily: 'Fontsemibold',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),textScaleFactor: 1.0
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.only(bottom:100),
        child: SingleChildScrollView(
          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height*(1/7),),
              MyTextField(
                height: 50,
                isNumber: true,
                fontPading: 24,
                hintText:"Enter the ward ",
                obscureText: false,
                controller: nameoftheward,
              ),
              SizedBox(height: 24,),
              MyTextField(
                height: 50,
                isNumber: true,
                fontPading: 24,
                hintText:"Enter your id  ",
                obscureText: false,
                controller: enterid,
              ),
              SizedBox(height: 24,),
              MyTextField(
                height: 50,
                isNumber: true,
                fontPading: 24,
                hintText:"Enter the amount ",
                obscureText: false,
                controller: Aount,
              ),
              SizedBox(height: 24,),
          
              ElevatedButton(
                onPressed: () => _initiateTransaction(context,Aount.text,enterid.text,nameoftheward.text),
                child: Text("Pay Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

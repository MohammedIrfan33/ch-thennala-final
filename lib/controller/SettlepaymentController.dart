import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../ApiLists/Apis.dart';
import '../Utils/colors.dart';
import '../modles/ModelClosePayment.dart';
import '../screens/paymenTintent2.dart';


class SettlePaymentController  extends GetxController{

  var isLoading = false.obs;
  var isLoading1 = false.obs;
  RxString totalPrice = "0".obs;
  RxString balance = "0".obs;
  String vollunteer_id="0";
  String _name="0";

  String _mobile="0";


  String amount="0";
  String orderid="";
  TextEditingController txtAmount = TextEditingController();





  ChallengeHistory(String? id,String? name,String? mobile) async {
    try {
      isLoading1(true);
      vollunteer_id=id!;
      _name=name??"";
      _mobile=mobile??"";

      var _result = await fetchChallengeHistory(id);
      totalPrice.value=_result;
      balance.value=_result;

    } finally {
      isLoading1(false);
    }
  }

  Future<String> fetchChallengeHistory(String? id) async {
     totalPrice.value="0";
     balance.value="0";
     txtAmount.clear();
   //// print("your id>>>>>>challenge${id}");
    final response = await http.post(
        Uri.parse(amountTotal),
        body: {
          'id':id.isNull?"0":id,
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
     //// print(response.body.toString());
      if (parsedJson['Status'] == 'true') {
        String amount = parsedJson['data'][0]['Amount'].toString();

        return amount;
      }
      return "0";
    } else {
      throw Exception('Failed to load challenges');
    }
  }




  calculate ()
  {
    double value=txtAmount.text.isEmpty?0:double.parse(txtAmount.text);
    double value2=double.parse(totalPrice.value);
    if(value>value2){
      Get.snackbar(
        'Error ',
        // Title of the Snackbar
        "Please Enter amount less than ₹${totalPrice.value}",
        // Message of the Snackbar
        snackPosition: SnackPosition.BOTTOM,
        // Position of the Snackbar
        backgroundColor:  AppColors.primaryColor2,
        // Background color of the Snackbar
        colorText: Colors.white,
        // Text color of the Snackbar
        borderRadius: 10,
        // Border radius of the Snackbar
        margin: const EdgeInsets.all(10),
        titleText: const Text(
          'Error',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fmedium', // Set your custom font family here
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), textScaleFactor: 1.0,
        ),
        messageText:  Text(
          'Please Enter amount less than ₹${totalPrice.value}',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontsemibold', // Set your custom font family here
            fontSize: 14,
          ), textScaleFactor: 1.0,
        ),
        // Margin around the Snackbar
        duration: const Duration(
            seconds:
            3), // Duration for which the Snackbar is displayed
      );
    }else{

      double balamt=value2-value;
      balance.value=balamt.toString().replaceFirst(".0", "");

    }

  }

  validateandproceed (){

    double value=txtAmount.text.isEmpty?0:double.parse(txtAmount.text);
    double value2=double.parse(totalPrice.value);

   if(txtAmount.text.isEmpty){
     Get.snackbar(
       'Error ',
       // Title of the Snackbar
       "Please Enter amount",
       // Message of the Snackbar
       snackPosition: SnackPosition.BOTTOM,
       // Position of the Snackbar
       backgroundColor:  AppColors.primaryColor2,
       // Background color of the Snackbar
       colorText: Colors.white,
       // Text color of the Snackbar
       borderRadius: 10,
       // Border radius of the Snackbar
       margin: const EdgeInsets.all(10),
       titleText: const Text(
         'Error',
         style: TextStyle(
           color: Colors.white,
           fontFamily: 'Fmedium', // Set your custom font family here
           fontSize: 16,
           fontWeight: FontWeight.bold,
         ), textScaleFactor: 1.0,
       ),
       messageText:  Text(
         'Please Enter amount ',
         style: TextStyle(
           color: Colors.white,
           fontFamily: 'Fontsemibold', // Set your custom font family here
           fontSize: 14,
         ), textScaleFactor: 1.0,
       ),
       // Margin around the Snackbar
       duration: const Duration(
           seconds:
           3), // Duration for which the Snackbar is displayed
     );
   } else if(value>value2){
      Get.snackbar(
        'Error ',
        // Title of the Snackbar
        "Please Enter amount less than ₹${totalPrice.value}",
        // Message of the Snackbar
        snackPosition: SnackPosition.BOTTOM,
        // Position of the Snackbar
        backgroundColor:  AppColors.primaryColor2,
        // Background color of the Snackbar
        colorText: Colors.white,
        // Text color of the Snackbar
        borderRadius: 10,
        // Border radius of the Snackbar
        margin: const EdgeInsets.all(10),
        titleText: const Text(
          'Error',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fmedium', // Set your custom font family here
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ), textScaleFactor: 1.0,
        ),
        messageText:  Text(
          'Please Enter amount less than ₹${totalPrice.value}',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontsemibold', // Set your custom font family here
            fontSize: 14,
          ), textScaleFactor: 1.0,
        ),
        // Margin around the Snackbar
        duration: const Duration(
            seconds:
            3), // Duration for which the Snackbar is displayed
      );
    }else{
     amount=txtAmount.text;
     settlePayment(value??0);



    }
  }





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();



  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    txtAmount.clear();

  }




















  settlePayment(double amount) async {
    isLoading(true);
    final response = await http.post(Uri.parse(volunteerreceiptAPI), body: {
      'userid': vollunteer_id,
      'Amount': amount.toString(),
      'mode':"1"
    });
    isLoading(false);

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        isLoading(false);
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'].toString().toLowerCase() == 'true') {
          var data=modelClosePaymentFromJson(response.body);

          bool isUpi=  await canLaunchUrl(Uri.parse("gpay://upi/pay?pa=chmuhammedkoyamem697890@fbl&pn=CH+MUHAMMED+KOYA+MEMORIAL+CHARITABLE+CENTRE&mc=8398&tr=FBLOMNI405324184PAY2907374559031741&tn=Test&am=2.00&cu=INR"));
          bool isUpiPhonepe=  await canLaunchUrl(Uri.parse("phonepe://pay?pa=chmuhammedkoyamem697890@fbl&pn=CH+MUHAMMED+KOYA+MEMORIAL+CHARITABLE+CENTRE&mc=8398&tr=FBLOMNI405324184PAY2907374559031741&tn=Test&am=2.00&cu=INR"));

        //  print("isUpi :::::::::::: ${isUpi.toString()}");
        //  print("isUpiPhonepe :::::::::::: ${isUpiPhonepe.toString()}");

          if(data.isNull)
          {}
          else
            {
              Get.to(Paymentintent2(model: data,
                totalmaount: amount.toString()??"",count:2,isUpi: isUpi,isUpiPhonepe: isUpiPhonepe,));
            }
        }else{

        }
      }
    } else {

      throw Exception('Failed to load data');
    }
  }




}
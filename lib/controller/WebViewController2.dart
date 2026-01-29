import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payment_gateway_plugin/payment_gateway_plugin.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../Utils/hashtagGenerator.dart';
import '../modles/ChallenegeListModel.dart';
import '../screens/PaymentIntent.dart';
import '../screens/PaymentfailedScreen.dart';
import '../screens/PaymentsuccessScreen.dart';
import '../widgets/testshowclass.dart';

class Webviewcontroller2 extends GetxController{
  String headerID = "0";
  var showthewebview=false.obs;
  var showthewebviewLoading=false.obs;
  var isLoadingAlert = true.obs;



  int coount=0;
  List<Challegelistmodel> list = <Challegelistmodel>[];
  String Amount="0";
  String number="";
  Map<String,String>? orderBody;









  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }



  void openCheckout(String orderid) {

    Map<String,dynamic> options = {
      'key': 'rzp_live_ubJQvkRJBjSpvg',
      'amount': double.parse(Amount).toInt() * 100,
      'name': 'Ch Centre Tirur',
      'order_id': orderid,
      'description': 'Payment channel',
      'prefill': {
        'contact': '${number}',
        'email': '${number}@shadekadapadi.in',
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    print("opencheckout>>>>>>>>>>");




  }

  saveFulldatatotheseverSponsor(var _request) async {


    final response = await _request.send();
    print("Responese of data${response}");
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();


      if (responseData.isEmpty) {

      } else {
        Map<String, dynamic> parsedJson = jsonDecode(responseData);
        if (parsedJson['Status'] == 'True') {
          print("Customer data saved >>>>>>>>>>>>>>>>");
          getGatewaydetected(parsedJson['data'].toString(),parsedJson['order_id'].toString(),parsedJson['hash'].toString(),parsedJson['name'].toString());
        } else {
          Get.back();
        }
      }
    } else {

      throw Exception('Failed to load data');
    }
  }


  saveFulldatatothesever(Map<String,dynamic>? fullSave) async {
    print("data to send of data${jsonEncode(fullSave)}");


    // Encode the JSON body as a query parameter
    String encodedBody = Uri.encodeComponent(jsonEncode(fullSave));

    // Construct the full URL with body as a query parameter
    String fullUrl = "$setthefulldatas?data=$encodedBody";

    print("Full URL with Data: ${fullUrl.replaceAll("%22%3A%22", "=").replaceAll("%22%2C%22", "&").replaceAll("%20", "").replaceFirst("data=%7B%22", "")}");

    final response = await post(Uri.parse(setthefulldatas),body:fullSave);
    print("Responese of data${response.body}");
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {

      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'] == 'True') {
          print("Customer data saved >>>>>>>>>>>>>>>>");
          getGatewaydetected(parsedJson['data'].toString(),parsedJson['order_id'].toString(),parsedJson['hash'].toString(),parsedJson['name'].toString());
        } else {
          Get.back();
        }
      }
    } else {

      throw Exception('Failed to load data');
    }
  }


  // customersave() async {
  //   print("customersave>>>>>>>>>>>>>>>>");
  //
  //   final response = await post(Uri.parse(Savecustomer), body:bodycustomesaver);
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //       // Check the status
  //       if (parsedJson['Status'] == 'True') {
  //         getGatewaydetected(parsedJson['data'].toString());
  //       } else {
  //
  //       }
  //     }
  //   } else {
  //
  //     throw Exception('Failed to load data');
  //   }
  // }


  getGatewaydetected(String customerId,String order_id,String hash,String? name) async {
    print("getGatewaydetected>>>>>>>>>>>>>>>>>>>>>>");
    final response = await get(Uri.parse(Gatewaycheck));
    headerID=customerId;

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {

      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        //Check the status
        if (parsedJson['Status'].toString().toLowerCase() == 'true') {

          gettheOrderId(customerId);//get gate way
        } else if (parsedJson['Status'].toString().toLowerCase() == 'false') {

          showthewebview(true);
        }else{
          final params = getParams(Amount,name??orderBody!["customer"],order_id,hash,orderBody!["mobile"]); // Get parameters from hash_generator
          print("Params => " + params.toString());


          // // Initiate payment
          // open(params, Get.context).then((value) {
          //
          //   if(response!=null){
          //
          //
          //
          //     CheckThePayment(order_id);
          //
          //
          //
          //   }else {
          //
          //     goBackTwoPages();
          //     Get.to(PaymentfailedScreen());
          //
          //
          //   }
          //   },);






          bool isUpi=  await canLaunchUrl(Uri.parse("gpay://upi/pay?pa=chmuhammedkoyamem697890@fbl&pn=CH+MUHAMMED+KOYA+MEMORIAL+CHARITABLE+CENTRE&mc=8398&tr=FBLOMNI405324184PAY2907374559031741&tn=Test&am=2.00&cu=INR"));
          bool isUpiPhonepe=  await canLaunchUrl(Uri.parse("phonepe://pay?pa=chmuhammedkoyamem697890@fbl&pn=CH+MUHAMMED+KOYA+MEMORIAL+CHARITABLE+CENTRE&mc=8398&tr=FBLOMNI405324184PAY2907374559031741&tn=Test&am=2.00&cu=INR"));

          Get.off(Paymentintent(customerID: customerId,
            totalmaount: Amount??"",name: name??"",nameOrg: orderBody!["customer"]??""
            ,hash:hash??"" ,order_id:order_id??"",count:coount??0,isUpi: isUpi,isUpiPhonepe: isUpiPhonepe,phone:orderBody!["mobile"]??"" ,));




        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }


  gettheOrderId(String customerId) async {

    print("gettheOrderId>>>>>>>>>>>");

    orderBody.isNull?null:orderBody!["Custid"]=customerId;







    final response = await post(Uri.parse(OrderId), body:orderBody);


    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        if (parsedJson['Status'] == 'True') {
          openCheckout(parsedJson['data'].toString());
        } else {
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  CheckThePayment(String? orderid) async {
    showthewebviewLoading(true);



    final response = await post(Uri.parse(CheckPayment), body: {
      'order_id': orderid,

    });
    //isLoading(false);
    // print(">>>>>>>>>>>>>>>>>>>>>>> details  save${response.body}");

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {

      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'].toString().toLowerCase() == 'true') {


          await goBackTwoPages();
          Get.to(PaymentsuccessScreen(isShare:AppData.volunteerId==null?1:0, name:orderBody!["customer"]??""));


        } else {
          await goBackTwoPages();
          Get.to(PaymentfailedScreen());

        }
      }
    } else {
      await goBackTwoPages();
      Get.to(PaymentfailedScreen());
      throw Exception('Failed to load data');
    }
  }




  transationupdate(String id, String? tdi) async {
    showthewebviewLoading(true);

    Future.delayed(Duration(seconds: 1), () {

    });

    final response = await post(Uri.parse(Updatetransation), body: {
      'id': id,
      'Transid': tdi.isNull ? "0" : tdi,
      'Received': Amount
    });
    //isLoading(false);
    // print(">>>>>>>>>>>>>>>>>>>>>>> details  save${response.body}");

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {

      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'] == 'True') {


          await goBackTwoPages();
          Get.to(PaymentsuccessScreen(isShare:AppData.volunteerId==null?1:0, name:orderBody!["customer"]??""));


        } else {
          await goBackTwoPages();
          Get.to(PaymentfailedScreen());

        }
      }
    } else {

      throw Exception('Failed to load data');
    }
  }

  Future<void> goBackTwoPages() async {
    int count = 0;
    Get.until((route) => count++ == coount);
  }



  // dynamic response;
  // String paymentResponse = "";
  // Future<dynamic> open(Map<String, dynamic> request, BuildContext? context) async {
  //   List<String>reValue=["",""];
  //
  //
  //   try {
  //     print("Request Params => " + request.toString());
  //     response = await PaymentGatewayPlugin.open('https://pgbiz.omniware.in', request);
  //
  //     return response;
  //
  //
  //     // if (response != null) {
  //     //   print("Response => ${response.toString()}"); // This prints the map to console
  //     //   reValue[0] = response['status'] ?? 'Unknown';
  //     //   String responseMessage = response['response']?.toString() ?? 'No response';
  //     //
  //     //   Map<String, dynamic> jsonMap = jsonDecode(responseMessage);
  //     //
  //     //
  //     //   reValue[1]= jsonMap['transaction_id'];
  //     //   Get.to(tesstshowclass(respone:"${responseMessage}",status: "${reValue[0]} transation id ${reValue[1]} ",));
  //     //
  //     //    paymentResponse = "Status: ${reValue[0]}\nResponse: $responseMessage";
  //     //
  //     //
  //     //
  //     //
  //     // }
  //     // else {
  //     //
  //     //     paymentResponse = "No response received from the payment gateway.";
  //     //     Get.to(tesstshowclass(respone:"${paymentResponse}",status: "${reValue[0]} transation id ${reValue[1]} ",));
  //     //
  //     //
  //     // }
  //   } on PlatformException {
  //
  //     paymentResponse = 'Failed to initiate payment.';
  //
  //
  //   }
  //   print("payment>>>>>${paymentResponse}");
  //
  //
  //
  //
  //   return response;
  //
  //
  // }


}
enum gateway{ razorpay,ccevenue}
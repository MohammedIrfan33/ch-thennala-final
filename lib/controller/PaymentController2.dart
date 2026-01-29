import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payment_gateway_plugin/payment_gateway_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../Utils/colors.dart';
import '../Utils/hashtagGenerator.dart';
import '../modles/ModelClosePayment.dart';
import '../screens/PaymentfailedScreen.dart';
import '../screens/PaymentsuccessScreen.dart';

class Paymentcontroller2 extends GetxController {
  var isChecked1 = false.obs;
  var isChecked2 = false.obs;
  var isChecked3 = false.obs;

  var isLoading = false.obs;

  bool paymentLaunched = false;
  bool hasReturnedFromPayment = false;
  sendTheData(
    ModelClosePayment model,
    String Amount,
    int count,
    bool isUpi,
    bool isUpiPhonepe,
  ) async {
    coount = count;
    if (isChecked3.value == false &&
        isChecked2.value == false &&
        isChecked1.value == false) {
      Get.snackbar(
        'Choosing', // Title of the Snackbar
        "Choosing the method of payment", // Message of the Snackbar
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'Choosing',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fmedium', // Set your custom font family here
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: const Text(
          'Choosing the method of payment',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Fontsemibold', // Set your custom font family here
            fontSize: 14,
          ),
        ), // Position of the Snackbar
        backgroundColor:
            AppColors.primaryColor2, // Background color of the Snackbar
        colorText: Colors.white, // Text color of the Snackbar
        borderRadius: 10, // Border radius of the Snackbar
        margin: EdgeInsets.all(10), // Margin around the Snackbar
        duration: Duration(
          seconds: 3,
        ), // Duration for which the Snackbar is displayed
      );
      return;
    }

    print("isUpi :::::::::::: ${isUpi.toString()}");
    print("isUpiPhonepe :::::::::::: ${isUpiPhonepe.toString()}");

    print("isChecked1 :::::::::::: ${isChecked1.toString()}");
    print("isChecked2 :::::::::::: ${isChecked2.toString()}");

    isLoading(true);

    if ((isChecked1.isTrue && isUpi) || (isUpiPhonepe && isChecked2.isTrue)) {
      String url = await fetchPanchayt(
        Amount,
        model.name,
        model.orderId,
        model.hash,
        model.mobile,
      );
      isLoading(false);
      isChecked1.value == true
          ? url = url.replaceFirst("upi://pay", "gpay://upi/pay")
          : null;
      isChecked2.value == true
          ? url = url.replaceFirst("upi://pay", "phonepe://pay")
          : null;

      print(">>>>>>>>>>>url>>>${url}");
      if (await canLaunchUrl(Uri.parse(url)) &&
          (isChecked1.value == true || isChecked2.value == true)) {
        final _paymentStarted = await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );

        print(">>>>>>>>>>>relaese>>>>${_paymentStarted}");
        paymentLaunched = _paymentStarted;
      } else {
        Get.snackbar(
          'UPI App Not Found', // Title of the Snackbar
          "Selected UPI app not found on this device", // Message of the Snackbar
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'UPI App Not Found',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Fmedium', // Set your custom font family here
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          messageText: const Text(
            'Selected UPI app not found on this device',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Fontsemibold', // Set your custom font family here
              fontSize: 14,
            ),
          ), // Position of the Snackbar
          backgroundColor:
              AppColors.primaryColor2, // Background color of the Snackbar
          colorText: Colors.white, // Text color of the Snackbar
          borderRadius: 10, // Border radius of the Snackbar
          margin: EdgeInsets.all(10), // Margin around the Snackbar
          duration: Duration(
            seconds: 3,
          ), // Duration for which the Snackbar is displayed
        );
      }

      return;
    }
    //fetchnew_HASH(Amount,customerId,name_org);

    Platform.isIOS
        ? fetchnew_HASH(Amount, AppData.volunteerId ?? "", model.mobile)
        : paymentInistiate(
            Amount,
            model.name,
            model.orderId,
            model.hash,
            model.mobile,
          );
  }

  paymentInistiate(
    String? Amount,
    String? name,
    String? order_id,
    String? hash,
    String phone,
  ) {
    print("calling this");

    final params = getParams(
      Amount,
      name,
      phone,
      order_id,
      hash,
    ); // Get parameters from hash_generator
    print("Params => " + params.toString());
    open(params, Get.context).then((value) {
      if (value != null) {
        CheckThePayment(order_id);
      } else {}
    });
  }

  CheckThePayment(String? orderid) async {
    print("order id .........$orderid");

    final response = await http.post(
      Uri.parse(checkpaymentStatus2),
      body: {'order_id': orderid},
    );

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'].toString().toLowerCase() == 'true') {
          await goBackTwoPages();
          Get.to(PaymentsuccessScreen(name: "", isShare: 0));
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

  dynamic response;
  String paymentResponse = "";
  Future<dynamic> open(
    Map<String, dynamic> request,
    BuildContext? context,
  ) async {
    List<String> reValue = ["", ""];

    try {
      print("Request Params => " + request.toString());
      response = await PaymentGatewayPlugin.open(
        'https://pgbiz.omniware.in',
        request,
      );

      return response;

      // if (response != null) {
      //   print("Response => ${response.toString()}"); // This prints the map to console
      //   reValue[0] = response['status'] ?? 'Unknown';
      //   String responseMessage = response['response']?.toString() ?? 'No response';
      //
      //   Map<String, dynamic> jsonMap = jsonDecode(responseMessage);
      //
      //
      //   reValue[1]= jsonMap['transaction_id'];
      //   Get.to(tesstshowclass(respone:"${responseMessage}",status: "${reValue[0]} transation id ${reValue[1]} ",));
      //
      //    paymentResponse = "Status: ${reValue[0]}\nResponse: $responseMessage";
      //
      //
      //
      //
      // }
      // else {
      //
      //     paymentResponse = "No response received from the payment gateway.";
      //     Get.to(tesstshowclass(respone:"${paymentResponse}",status: "${reValue[0]} transation id ${reValue[1]} ",));
      //
      //
      // }
    } on PlatformException {
      paymentResponse = 'Failed to initiate payment.';
    }
    print("payment>>>>>${paymentResponse}");

    return response;
  }

  int coount = 0;

  Future<void> goBackTwoPages() async {
    int count = 0;
    Get.until((route) => count++ == coount);
  }

  Future<void> fetchnew_HASH(
    String? amt,
    String customerId,
    String phone,
  ) async {
    final response = await http.post(
      Uri.parse(buildHash),
      body: {"id": customerId, "received": amt, "mode": "0"},
    );
    print(">>>>>> response ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      if (parsedJson['Status'].toString().toLowerCase() == 'true') {
        paymentInistiate(
          amt,
          parsedJson['name'].toString(),
          parsedJson['order_id'].toString(),
          parsedJson['hash'].toString(),
          phone,
        );
      }
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  Future<String> fetchPanchayt(
    String? amt,
    String? name,
    String? Order_id,
    String? hash,
    String phone,
  ) async {
    var body = {
      'address_line_1': 'ad1',
      'address_line_2': 'ad2',
      'amount': amt ?? "",
      'api_key': '06e478b9-6edb-48d1-ab0c-fa7c80bcf401',
      'city': 'Malappuram',
      'country': 'IND',
      'currency': 'INR',
      'description': 'CH CENTER THENNALA',
      'email': 'support@workmateinfotech.com',
      'mode': 'LIVE',
      'name': name ?? 'Office',
      'order_id': Order_id ?? "",
      'phone': '8138010133',
      'return_url': 'http://localhost:8888/paymentresponse',
      'state': 'kerala',
      'zip_code': '673635',
      'udf1': name ?? "",
      'udf2': phone ?? "",
      'udf3': Order_id ?? "",
      'udf4': "",
      'udf5': "",
      'hash': hash ?? '31bef9dee8d1c6b10e46a1ee43a74ca4fe1e277d',
    };

    print("The Responase body${jsonEncode(body)}");
    final response = await http.post(
      Uri.parse("https://pgbiz.omniware.in/v2/getpaymentrequestintenturl"),
      body: body,
    );

    print("The Responase Back${response.body}");

    print("response ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      final upiIntentUrl = parsedJson['data']['upi_intent_url'];
      return upiIntentUrl;
    } else {
      throw Exception('Failed to load challenges');
    }
  }
}

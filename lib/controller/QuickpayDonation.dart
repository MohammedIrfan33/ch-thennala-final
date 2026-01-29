import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:chcenterthennala/modles/loginModels.dart';
import 'package:chcenterthennala/screens/PaymentsuccessScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../modles/AssembelyModel.dart';
import '../modles/ClubModel.dart';
import '../modles/DistrictModel.dart';
import '../modles/NewAssemblyModel.dart';
import '../modles/PanchayatModel.dart';
import '../modles/Sponsorshipmodel.dart';
import '../modles/WardModel.dart';
import '../screens/PaymentfailedScreen.dart';
import '../screens/Webpaynent.dart';
import '../Utils/colors.dart';

class QuickpayDonationcontroller extends GetxController {
  TextEditingController txtControllername = TextEditingController();
  TextEditingController txtControllerAddress = TextEditingController();
  TextEditingController txtControllerMobile = TextEditingController();
  String Amount = "";
  String hideidendity = "0";
  int? selected_index;

  var isLoading = false.obs;
  var isPaymentpage = false.obs;
  String headerid = "0";
  var Errorcheck = <int>[0, 0, 0, 0, 0, 0, 0, 0].obs;

  full_On_oneSave(String? Volunteer_ID, String? recevied) async {
    // isLoading(true);
    Map<String, dynamic> body = {
      'name': txtControllername.text,
      'Address': txtControllerAddress.text,
      'Mobile': txtControllerMobile.text,
      'isphoto': "0",
      'District': orgdistModel.value.isNull ? "1" : orgdistModel.value!.id,
      'Assembly': orgassemblymodel.value.isNull
          ? "1"
          : orgassemblymodel.value!.id,
      'Panchayat': orgPanchaytModel.value.isNull
          ? "0"
          : orgPanchaytModel.value!.id,
      'Ward': orgwardModel.value.isNull ? "0" : orgwardModel.value!.id,

      'donation': "1",
      'sponsorship': "0",
      'challengeid': "0",
      'orderid': "",
      "uniquedid": AppData.uniqueid,
      'clubid': "0",
      'hideidendity': hideidendity,
      'customerid': "",
      'orderforothers': "0",
      'custname': "",
      'custaddress': "",
      'custmobile': "",
      'Transid': "",
      'Amount': Amount,
      'Received': recevied.isNull ? "0" : recevied,
      'volunteer': Volunteer_ID.isNull ? "0" : Volunteer_ID,
      'mode': "1",
    };
    log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${jsonEncode(body)}");

    Map<String, String> orderBody = {
      'total': Amount,
      'customer': txtControllername.text,
      'mobile': txtControllerMobile.text,
      'Custid': "",
    };

    if (Volunteer_ID.isNull) {
      Get.to(
        WebViewPayment(
          name: txtControllername.text,
          amount: Amount,
          Number: txtControllerMobile.text,
          coount: 2,
          isShow: 1,
          fullsave: body,
          request: "",
          orderBody: orderBody,
        ),
      );
    } else {
      isLoading(true);

      final response = await post(Uri.parse(setthefulldatas), body: body);
      isLoading(false);
      print(">>>>>>>>>>>>>>>>>>>${response.body}");
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          isLoading(false);
        } else {
          Map<String, dynamic> parsedJson = jsonDecode(response.body);

          // Check the status
          if (parsedJson['Status'] == 'True') {
            goBackTwoPages();
            Get.snackbar(
              'successfull', // Title of the Snackbar
              "Payment completed successfully", // Message of the Snackbar
              snackPosition: SnackPosition.BOTTOM,
              titleText: const Text(
                'successfull',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Fmedium',
                  // Set your custom font family here
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              messageText: const Text(
                'Payment completed successfully',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Fontsemibold',
                  // Set your custom font family here
                  fontSize: 14,
                ),
              ),
              // Position of the Snackbar
              backgroundColor: AppColors.primaryColor2,
              // Background color of the Snackbar
              colorText: Colors.white,
              // Text color of the Snackbar
              borderRadius: 10,
              // Border radius of the Snackbar
              margin: EdgeInsets.all(10),
              // Margin around the Snackbar
              duration: Duration(
                seconds: 3,
              ), // Duration for which the Snackbar is displayed
            );

            //Headersave("",parsedJson['data'].toString(),Volunteer_ID,recevied);
          } else {
            isLoading(false);
          }
        }
      } else {
        isLoading(false);
        throw Exception('Failed to load data');
      }
    }

    // print(">>>>>>>>>>>>>>>>>>>${response.body}");
    //  if (response.statusCode == 200) {
    //    if (response.body.isEmpty) {
    //      isLoading(false);
    //    } else {
    //      Map<String, dynamic> parsedJson = jsonDecode(response.body);
    //
    //      // Check the status
    //      if (parsedJson['Status'] == 'True') {
    //        if(Volunteer_ID.isNull){
    //          getGatewaydetected(parsedJson['data'].toString(),Volunteer_ID,recevied);
    //        }else{
    //
    //          goBackTwoPages();
    //          Get.snackbar(
    //            'successfull', // Title of the Snackbar
    //            "Payment completed successfully", // Message of the Snackbar
    //            snackPosition: SnackPosition.BOTTOM,
    //            titleText: const Text(
    //              'successfull',
    //              style: TextStyle(
    //                color: Colors.white,
    //                fontFamily: 'Fmedium',
    //                // Set your custom font family here
    //                fontSize: 16,
    //                fontWeight: FontWeight.bold,
    //              ),
    //            ),
    //            messageText: const Text(
    //              'Payment completed successfully',
    //              style: TextStyle(
    //                color: Colors.white,
    //                fontFamily: 'Fontsemibold',
    //                // Set your custom font family here
    //                fontSize: 14,
    //              ),
    //            ),
    //            // Position of the Snackbar
    //            backgroundColor: AppColors.primaryColor2,
    //            // Background color of the Snackbar
    //            colorText: Colors.white,
    //            // Text color of the Snackbar
    //            borderRadius: 10,
    //            // Border radius of the Snackbar
    //            margin: EdgeInsets.all(10),
    //            // Margin around the Snackbar
    //            duration: Duration(
    //                seconds:
    //                3), // Duration for which the Snackbar is displayed
    //          );
    //        }
    //
    //
    //
    //        //Headersave("",parsedJson['data'].toString(),Volunteer_ID,recevied);
    //      }else{
    //        isLoading(false);
    //      }
    //    }
    //  } else {
    //    isLoading(false);
    //    throw Exception('Failed to load data');
    //  }
  }

  // customersave(String? Volunteer_ID,String? recevied) async {
  //   isLoading(true);
  //   final response = await post(Uri.parse(Savecustomer), body: {
  //     'name': txtControllername.text,
  //     'Address': txtControllerAddress.text,
  //     'Mobile': txtControllerMobile.text,
  //     'isphoto':"0",
  //     'District':orgdistModel.value.isNull?"0":orgdistModel.value!.id,
  //     'Assembly': orgassemblymodel.value.isNull?"0":orgassemblymodel.value!.id,
  //     'Panchayat': orgPanchaytModel.value.isNull?"0":orgPanchaytModel.value!.id,
  //     'Ward': orgwardModel.value.isNull?"0":orgwardModel.value!.id,
  //   });
  //  //// print(">>>>>>>>>>>>>>>>>>>>>>> cutomer save${response.body}");
  //
  //
  //
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //       // Check the status
  //       if (parsedJson['Status'] == 'True') {
  //         if(Volunteer_ID.isNull){
  //           getGatewaydetected(parsedJson['data'].toString(),Volunteer_ID,recevied);
  //         }else{
  //           Headersave("",parsedJson['data'].toString(),Volunteer_ID,recevied,gateway.razorpay);
  //         }
  //
  //
  //
  //         //Headersave("",parsedJson['data'].toString(),Volunteer_ID,recevied);
  //       }else{
  //         isLoading(false);
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }

  // getGatewaydetected(String customerId,String? Volunteer_ID,String? received) async {
  //   final response = await get(Uri.parse(Gatewaycheck));
  //
  //   print(">>>>>>>>>>>>>>>>get>>>>>>> order id${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //       // Check the status
  //       if (parsedJson['Status'].toString().toLowerCase() == 'true') {
  //
  //         gettheOrderId(customerId,Volunteer_ID,received);//get gate way
  //       } else {
  //
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // gettheOrderId(String customerId,String? Volunteer_ID,String? received) async {
  //
  //   final response = await post(Uri.parse(OrderId), body: {
  //     'total':Amount,
  //     'customer': txtControllername.text,
  //     'mobile': txtControllerMobile.text,
  //     'Custid':customerId});
  //
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //       if (parsedJson['Status'] == 'True') {
  //         openCheckout(parsedJson['data']??"");
  //       }else{
  //         isLoading(false);
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }

  // Headersave(String? orderid,String customerid,String? Volunteer_ID,String? received,gateway val) async {
  //
  //   var body= {
  //     'donation': "1",
  //     'sponsorship': "0",
  //     'challengeid':"0",
  //     'orderid':orderid,
  //     "uniquedid": AppData.uniqueid,
  //     'clubid': "0",
  //     'hideidendity':hideidendity,
  //     'customerid': customerid,
  //     'orderforothers':"0",
  //     'name': "",
  //     'address': "",
  //     'mobile': "",
  //     'Transid': "",
  //     'Amount': Amount,
  //     'Received': received.isNull?"0":received,
  //     'volunteer': Volunteer_ID.isNull?"0":Volunteer_ID
  //   };
  //
  //   body.forEach((key, value) {
  //     print("Headerbody key(${key.toString()}) value (${value.toString()})");
  //
  //   },);
  //
  //
  //
  //
  //
  //   final response = await post(Uri.parse(Savethehaderdatails), body:body);
  //  //// print(">>>>>>>>>>>>>>>>>>>>>>> Header save${response.body}");
  //
  //   isLoading(false);
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //       if (parsedJson['Status'] == 'True') {
  //
  //         headerid=parsedJson['data'].toString();
  //         if(Volunteer_ID.isNull){
  //           if(val==gateway.razorpay){
  //
  //
  //           }else{
  //             isLoading(false);
  //
  //           }
  //
  //         }else{
  //
  //
  //           goBackTwoPages();
  //           Get.snackbar(
  //             'successfull', // Title of the Snackbar
  //             "Payment completed successfully", // Message of the Snackbar
  //             snackPosition: SnackPosition.BOTTOM,
  //             titleText: const Text(
  //               'successfull',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontFamily: 'Fmedium',
  //                 // Set your custom font family here
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             messageText: const Text(
  //               'Payment completed successfully',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontFamily: 'Fontsemibold',
  //                 // Set your custom font family here
  //                 fontSize: 14,
  //               ),
  //             ),
  //             // Position of the Snackbar
  //             backgroundColor: AppColors.primaryColor2,
  //             // Background color of the Snackbar
  //             colorText: Colors.white,
  //             // Text color of the Snackbar
  //             borderRadius: 10,
  //             // Border radius of the Snackbar
  //             margin: EdgeInsets.all(10),
  //             // Margin around the Snackbar
  //             duration: Duration(
  //                 seconds:
  //                 3), // Duration for which the Snackbar is displayed
  //           );
  //         }
  //
  //
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }

  void goBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == 1);
  }

  validation(String? volunteer_ID, String? received) {
    for (int i = 0; i < 8; i++) {
      Errorcheck[i] = 0;
    }

    if (Amount.isEmpty) {
      Errorcheck[7] = 1;
    } else if (double.parse(Amount) <= 0) {
      Errorcheck[7] = 1;
    } else if ((txtControllername.text.toString().isEmpty ||
            txtControllerAddress.text.toString().isEmpty ||
            txtControllerMobile.text.toString().isEmpty ||
            txtControllerMobile.text.length != 10) &&
        AppData.volunteerId.isNull) {
      Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
      Errorcheck[1] = txtControllerMobile.text.toString().isEmpty
          ? 1
          : txtControllerMobile.text.length != 10
          ? 2
          : 0;
      Errorcheck[2] = txtControllerAddress.text.toString().isEmpty ? 1 : 0;
    } else if (orgwardModel.value.isNull && AppData.volunteerId.isNull) {
      Errorcheck[3] = orgdistModel.value.isNull ? 1 : 0;
      Errorcheck[4] = orgassemblymodel.value.isNull ? 1 : 0;
      Errorcheck[5] = orgPanchaytModel.value.isNull ? 1 : 0;
      Errorcheck[6] = orgwardModel.value.isNull ? 1 : 0;
    } else if (txtControllername.text.isEmpty && !AppData.volunteerId.isNull) {
      Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
    } else if (txtControllerMobile.text.isNotEmpty &&
        txtControllerMobile.text.length != 10 &&
        !AppData.volunteerId.isNull) {
      Errorcheck[1] = txtControllerMobile.text.length != 10 ? 2 : 0;
    } else {
      senddata(volunteer_ID, received);
    }
  }

  void senddata(String? volunteer_ID, String? received) {
    full_On_oneSave(volunteer_ID, received);
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
  }

  Rx<DistrictModel?> orgdistModel = Rx<DistrictModel?>(null); // Explicit type
  RxList<DistrictModel> distristList = <DistrictModel>[].obs;
  List<DistrictModel> ditrictfulllist = <DistrictModel>[];
  fetchDistrictapi() async {
    if (AppData.DistrictList.isEmpty) {
      //Through online
      final response = await get(Uri.parse(DistrictApi));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var list = List<DistrictModel>.from(
          data['data'].map((x) => DistrictModel.fromJson(x)),
        ).toList();
        if (list.isNull) {
        } else {
          distristList!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.DistrictList);
      var list = List<DistrictModel>.from(
        data['data'] /*.where((item) => item['id'] == "10")*/ .map(
          (x) => DistrictModel.fromJson(x),
        ),
      ).toList();
      if (list.isNull) {
      } else {
        ditrictfulllist!.addAll(list);
        distristList!.addAll(list);
      }
    }
  }

  RxList<NewAssemblyModel> orgassemblyList = <NewAssemblyModel>[].obs;
  Rx<NewAssemblyModel?> orgassemblymodel = Rx<NewAssemblyModel?>(null);
  List<NewAssemblyModel> orgassemblyfullList = <NewAssemblyModel>[];
  fetchAssemblyapi(String S) async {
    // print(">>>>>>>>>>>>calling${S}");

    orgassemblymodel.value = null;
    orgPanchaytModel.value = null;
    orgwardModel.value = null;

    if (AppData.Assembly.isEmpty) {
      final response = await post(
        Uri.parse(AssembelyApi),
        body: {'id': S.toString()},
      );
      // print(">>>>>>>>>>>>callingresponse >${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var list = List<NewAssemblyModel>.from(
          data['data'].map((x) => NewAssemblyModel.fromJson(x)),
        ).toList();
        // list.forEach((element) =>// print("output>>>>>>>>>>>>${element.name}"));

        if (list.isNull) {
        } else {
          orgassemblyList!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.Assembly);
      var list = List<NewAssemblyModel>.from(
        data['data']
            .where((item) => item['districtid'] == S)
            .map((x) => NewAssemblyModel.fromJson(x)),
      ).toList();

      if (list.isNull) {
      } else {
        if (orgassemblyList!.isNotEmpty) orgassemblyList!.clear();

        if (panchayatList!.isNotEmpty) panchayatList!.clear();

        if (wardlist!.isNotEmpty) wardlist!.clear();

        if (orgassemblyfullList!.isNotEmpty) orgassemblyfullList!.clear();

        if (panchayatListfull!.isNotEmpty) panchayatListfull!.clear();

        if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

        orgassemblyList!.addAll(list);
        orgassemblyfullList!.addAll(list);
      }
    }
  }

  RxList<PanchayatModel> panchayatList = <PanchayatModel>[].obs;
  List<PanchayatModel> panchayatListfull = <PanchayatModel>[];
  Rx<PanchayatModel?> orgPanchaytModel = Rx<PanchayatModel?>(null);
  fetchPanchaythapi(List<String> S) async {
    orgPanchaytModel.value = null;
    orgwardModel.value = null;
    // print(">>>>>>>>>>>>callingpanchayth${S}");
    if (AppData.Panchayt.isEmpty) {
      final response = await post(
        Uri.parse(PanchayatApi),
        body: {'id': S.toString()},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var list = List<PanchayatModel>.from(
          data['data'].map((x) => PanchayatModel.fromJson(x)),
        ).toList();

        if (list.isNull) {
        } else {
          panchayatList!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.Panchayt);
      var list = List<PanchayatModel>.from(
        data['data']
            .where((item) => S.contains(item['assemblyid']))
            .map((x) => PanchayatModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        if (panchayatList!.isNotEmpty) panchayatList!.clear();

        if (wardlist!.isNotEmpty) wardlist!.clear();

        if (panchayatListfull!.isNotEmpty) panchayatListfull!.clear();

        if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

        panchayatList!.addAll(list);
        panchayatListfull!.addAll(list);
      }
    }
  }

  RxList<WardModel> wardlist = <WardModel>[].obs;
  List<WardModel> wardlistfull = <WardModel>[];
  Rx<WardModel?> orgwardModel = Rx<WardModel?>(null);
  fetchwardapi(String S) async {
    selected_index = null;

    orgwardModel.value = null;
    if (wardlist!.isNotEmpty) wardlist!.clear();

    if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

    final response = await post(
      Uri.parse(historypageWardAPi),
      body: {'id': S.toString()},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<WardModel>.from(
        data['data'].map((x) => WardModel.fromJson(x)),
      ).toList();
      // list.forEach((element) =>// print("output>>>>>>>>>>>>${element.name}"));

      if (list.isNull) {
      } else {
        wardlist!.addAll(list);
        wardlistfull!.addAll(list);
      }
    } else {
      throw Exception('Failed to load items');
    }
  }
}

enum gateway { razorpay, ccevenue }

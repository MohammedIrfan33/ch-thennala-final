import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:chcenterthennala/screens/PaymentfailedScreen.dart';
import 'package:chcenterthennala/screens/PaymentsuccessScreen.dart';

import '../ApiLists/Apis.dart';
import '../modles/AssembelyModel.dart';
import '../modles/DistrictModel.dart';
import '../modles/NewAssemblyModel.dart';
import '../modles/PanchayatModel.dart';
import '../modles/Sponsorshipmodel.dart';
import '../modles/WardModel.dart';
import '../screens/Webpaynent.dart';
import '../Utils/colors.dart';

class QuickpayScreencontroller extends GetxController {
  List<Sponsorshipmodel> list = <Sponsorshipmodel>[];

  TextEditingController txtControllername = TextEditingController();
  TextEditingController txtControllerAddress = TextEditingController();
  TextEditingController txtControllerMobile = TextEditingController();
  String Amount = "";
  String hideidendity = "0";
  String challengeid = "";
  int? selected_index;

  String uniqueid = "";
  int backCount = 2;

  var isLoading = false.obs;

  String headerid = "0";
  var Errorcheck = <int>[0, 0, 0, 0, 0, 0, 0, 0].obs;

  fullONOneSave() async {
    File file = await getImageFileFromAsset('assets/StaticImg/email.png');

    var uri = Uri.parse(setthefulldatas);
    var request = http.MultipartRequest("POST", uri)
      ..fields['name'] = txtControllername.text
      ..fields['Address'] = txtControllerAddress.text
      ..fields['Mobile'] = txtControllerMobile.text
      ..fields['isphoto'] = "1"
      ..fields['District'] = '1'
      ..fields['Assembly'] = '1'
      ..fields['Panchayat'] = orgPanchaytModel.value.isNull
          ? "0"
          : orgPanchaytModel.value!.id
      ..fields['Ward'] = orgwardModel.value.isNull
          ? "0"
          : orgwardModel.value!.id
      ..fields['donation'] = "0"
      ..fields['orderid'] = ""
      ..fields['sponsorship'] = "1"
      ..fields['challengeid'] = challengeid
      ..fields['Ward'] = orgwardModel.value.isNull
          ? "0"
          : orgwardModel.value!.id
      ..fields['clubid'] = "0"
      ..fields['hideidendity'] = hideidendity
      ..fields['customerid'] = ""
      ..fields['uniquedid'] = AppData.uniqueid ?? ""
      ..fields['orderforothers'] = "0"
      ..fields['custname'] = ""
      ..fields['custaddress'] = ""
      ..fields['custmobile'] = ""
      ..fields['Transid'] = ""
      ..fields['Amount'] = Amount
      ..fields['Received'] = received
      ..fields['volunteer'] = AppData.volunteerId ?? "0"
      ..fields['mode'] = "1"
      ..fields['qty'] = list.first.quantity.toString()
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          file!.path,
          filename: basename(file!.path),
        ),
      );

    Map<String, String> orderBody = {
      'total': Amount,
      'customer': txtControllername.text,
      'mobile': txtControllerMobile.text,
      'Custid': "",
    };

    AppData.volunteerId.isNull
        ? Get.to(
            WebViewPayment(
              name: txtControllername.text,
              amount: Amount,
              Number: txtControllerMobile.text,
              coount: (backCount + 1),
              request: request,
              fullsave: null,
              orderBody: orderBody,
            ),
          )
        : saveFulldatatotheseverSponsor(request);
  }

  Future<File> getImageFileFromAsset(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${basename(assetPath)}');

    await file.writeAsBytes(byteData.buffer.asUint8List());
    print("FILE Name :${file.path}");
    return file;
  }

  saveFulldatatotheseverSponsor(var _request) async {
    isLoading(true);

    final response = await _request.send();
    isLoading(false);
    print("Responese of data${response}");
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();

      print("ResponseData of data${responseData}");
      if (responseData.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(responseData);
        if (parsedJson['Status'] == 'True') {
          print("Customer data saved >>>>>>>>>>>>>>>>");
          goBackTwoPages();
          Get.snackbar(
            'Successfull', // Title of the Snackbar
            "Sponsor payment Successfull .", // Message of the Snackbar
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              'Successfull',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fmedium', // Set your custom font family here
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              'Sponsor payment Successfull .',
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
            margin: const EdgeInsets.all(10), // Margin around the Snackbar
            duration: const Duration(
              seconds: 3,
            ), // Duration for which the Snackbar is displayed
          );
        } else {
          Get.back();
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  validation() {
    this.received = "0";
    Errorcheck.fillRange(0, 7, 0);

    if (txtControllername.text.toString().isEmpty ||
        txtControllerAddress.text.toString().isEmpty ||
        txtControllerMobile.text.toString().isEmpty ||
        txtControllerMobile.text.length != 10) {
      Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
      Errorcheck[1] = txtControllerMobile.text.toString().isEmpty
          ? 1
          : txtControllerMobile.text.length != 10
          ? 2
          : 0;
      Errorcheck[2] = txtControllerAddress.text.toString().isEmpty ? 1 : 0;
    } else if (orgwardModel.value.isNull) {
      Errorcheck[5] = orgPanchaytModel.isNull ? 1 : 0;
      Errorcheck[6] = orgwardModel.value.isNull ? 1 : 0;
    } else {
      senddata();
      print("send calllling");
    }
  }

  void senddata() {
    fullONOneSave();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void openCheckout(String orderid) {
    //// print(">>>>>>>>>>>>>>>>>>>>>>> 1233we4342");
    var options = {
      'key': 'rzp_live_ubJQvkRJBjSpvg',
      'amount':
          double.parse(Amount).toInt() *
          100, // Amount in paise (e.g. 50000 paise = INR 500)
      'name': 'Ch Centre Tirur',
      'order_id': orderid,
      'description': 'Payment channel',
      'prefill': {
        'contact': txtControllerMobile.text,
        'email': '${txtControllerMobile.text}@chcenterthennala.in',
      },
      'external': {
        'wallets': ['paytm'],
      },
    };
    try {
      //// print(">>>>>>>>>>>>>>>>>>>>>>> vvvvvvvvvvvvvvvvvvvvvv");
    } catch (e) {
      //// print(e.toString());
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void goBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == backCount);
  }

  String received = "0";

  savefromvolunterr(String received, String? volunteerid) {
    this.received = received!;
    this.volunteerid = volunteerid;
    Errorcheck.fillRange(0, 7, 0);

    if (txtControllername.text.isEmpty) {
      Errorcheck[0] = txtControllername.text.toString().isEmpty ? 1 : 0;
    } else if (txtControllerMobile.text.isNotEmpty &&
        txtControllerMobile.text.length != 10) {
      Errorcheck[1] = txtControllerMobile.text.length != 10 ? 2 : 0;
    } else {
      senddata();
    }
  }

  String? volunteerid;

  // customersave_volunteer(File? filePath) async {
  //   isLoading(true);
  //
  //
  //   var uri = Uri.parse(Savecustomer);
  //   var request = http.MultipartRequest("POST", uri)
  //     ..fields['name'] = txtControllername.text
  //     ..fields['Address'] = txtControllerAddress.text
  //     ..fields['Mobile'] = txtControllerMobile.text
  //     ..fields['isphoto'] = "1"
  //     ..fields['District'] = orgdistModel.value.isNull?"0":orgdistModel.value!.id
  //     ..fields['Assembly'] = orgassemblymodel.value.isNull?"0":orgassemblymodel.value!.id
  //     ..fields['Panchayat'] = orgPanchaytModel.value.isNull?"0":orgPanchaytModel.value!.id
  //     ..fields['Ward'] =orgwardModel.value.isNull?"0":orgwardModel.value!.id
  //     ..files.add(await http.MultipartFile.fromPath(
  //       'image',
  //       filePath!.path,
  //       filename: basename(filePath!.path),
  //     ));
  //
  //   var response = await request.send();
  //
  //
  //  //// print(">>>>>>>>>>>>>>>>>>>>>>> cutomer save${response}");
  //
  //  //// print("Headersave_volunteer>>>>>>>>>>>>>>>>>>>>>>>>");
  //
  //
  //
  //   if (response.statusCode == 200) {
  //     var responseData = await response.stream.bytesToString();
  //     if (responseData.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(responseData);
  //
  //       // Check the status
  //       if (parsedJson['Status'] == 'True') {
  //         Headersave_volunteer(parsedJson['data'].toString());
  //       }else{
  //         isLoading(false);
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // Headersave_volunteer(String id) async {
  //   final response = await http.post(Uri.parse(Savethehaderdatails), body: {
  //     'donation': "0",
  //     'sponsorship': "1",
  //     'challengeid':challengeid,
  //     'clubid': "0",
  //     'hideidendity':hideidendity,
  //     'customerid': id,
  //     'orderforothers':"0",
  //     'name': "",
  //     'address': "",
  //     'mobile': "",
  //     'Transid': "",
  //     'Amount': Amount,
  //     'Received': received,
  //     'volunteer':volunteerid.isNull?"0":volunteerid
  //   });
  //  //// print(">>>>>>>>>>>>>>>>>>>>>>> Header  save${response.body}");
  //
  //
  //
  //   if (response.statusCode == 200) {
  //     if (response.body.isEmpty) {
  //       isLoading(false);
  //     } else {
  //       Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //       if (parsedJson['Status'] == 'True') {
  //         headerid=parsedJson['data'].toString();
  //         titlesave_volunteer(parsedJson['data'].toString());
  //       }else{
  //         isLoading(false);
  //       }
  //     }
  //   } else {
  //     isLoading(false);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // titlesave_volunteer(String id) async {
  //   int index = 0;
  //   int lastIndex =0;
  //   for (var element in list) {
  //     if(element.quantity!=0){
  //       lastIndex++;
  //     }}
  //   lastIndex--;
  //
  //
  //
  //   for (var element in list) {
  //     if (element.quantity>0) {
  //       final response = await http.post(Uri.parse(Savethetitle), body: {
  //         'hdrid': id,
  //         'item': element.id,
  //         'qty': element.quantity.toString(),
  //         'rate': element.rate,
  //         'amount': (element.quantity * double.parse(element.rate)).toString(),
  //       });
  //      //// print(">>>>>>>>>>>>>>>>>>>>>>> details  save${response.body}");
  //
  //       if (response.statusCode == 200) {
  //         if (response.body.isEmpty) {
  //           isLoading(false);
  //         } else {
  //           Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //           if (parsedJson['Status'] == 'True') {
  //             if (index == lastIndex) {
  //              goBackTwoPages();
  //              Get.back();
  //              Get.snackbar(
  //                'Successfull', // Title of the Snackbar
  //                "Sponsor payment Successfull .", // Message of the Snackbar
  //                snackPosition: SnackPosition.BOTTOM,
  //                titleText:const Text(
  //                  'Successfull',
  //                  style: TextStyle(
  //                    color: Colors.white,
  //                    fontFamily: 'Fmedium', // Set your custom font family here
  //                    fontSize: 16,
  //                    fontWeight: FontWeight.bold,
  //                  ),
  //                ),
  //                messageText:const Text(
  //                  'Sponsor payment Successfull .',
  //                  style: TextStyle(
  //                    color: Colors.white,
  //                    fontFamily: 'Fontsemibold', // Set your custom font family here
  //                    fontSize: 14,
  //                  ),
  //                ),// Position of the Snackbar
  //                backgroundColor:  AppColors.primaryColor2, // Background color of the Snackbar
  //                colorText: Colors.white, // Text color of the Snackbar
  //                borderRadius: 10, // Border radius of the Snackbar
  //                margin: const EdgeInsets.all(10), // Margin around the Snackbar
  //                duration:const  Duration(seconds: 3), // Duration for which the Snackbar is displayed
  //
  //              );
  //             }
  //
  //
  //           }else{
  //             isLoading(false);
  //           }
  //         }
  //       } else {
  //         isLoading(false);
  //         throw Exception('Failed to load data');
  //       }
  //       index++;
  //     }
  //
  //   }
  // }

  transationfailed(String id) async {
    isLoading(true);
    final response = await http.post(
      Uri.parse(failedtransation),
      body: {'id': id},
    );
    //isLoading(false);
    //// print(">>>>>>>>>>>>>>>>>>>>>>> details  save${response.body}");

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        isLoading(false);
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'] == 'True') {
          goBackTwoPages();
          Get.to(PaymentfailedScreen());
        } else {
          isLoading(false);
        }
      }
    } else {
      isLoading(false);
      throw Exception('Failed to load data');
    }
  }

  Rx<DistrictModel?> orgdistModel = Rx<DistrictModel?>(null); // Explicit type
  RxList<DistrictModel> distristList = <DistrictModel>[].obs;
  List<DistrictModel> ditrictfulllist = <DistrictModel>[];
  fetchDistrictapi() async {
    if (AppData.DistrictList.isEmpty) {
      //Through online
      final response = await http.get(Uri.parse(DistrictApi));
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
      final response = await http.post(
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
      final response = await http.post(
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

    final response = await http.post(
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

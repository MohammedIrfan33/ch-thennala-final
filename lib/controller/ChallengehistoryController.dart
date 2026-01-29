import 'dart:convert';

import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/modles/ClubModel.dart';
import 'package:chcenterthennala/modles/WardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLists/Apis.dart';
import '../Utils/colors.dart';
import '../modles/AssembelyModel.dart';
import '../modles/ChallengeSopnsorModel.dart';
import '../modles/ChallengehistroyModel.dart';
import 'package:http/http.dart' as http;

import '../modles/ContributionHistoryModel.dart';
import '../modles/DistrictModel.dart';
import '../modles/NewAssemblyModel.dart';
import '../modles/PanchayatModel.dart';
import '../modles/ReportContributionModel.dart';

class ChallengeHistroyController extends GetxController {
  TextEditingController txtNumber = TextEditingController();

  RxList<ChallengehistoryModel> challengelist = <ChallengehistoryModel>[].obs;
  RxList<ChallengehistoryModel> challengelistClub =
      <ChallengehistoryModel>[].obs;
  RxList<CallengeSponsorModel> challengeSponsorlist =
      <CallengeSponsorModel>[].obs;
  bool loading = false;
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading_Condribution = false.obs;
  RxList<ReprotCondributionModel> contributionList =
      <ReprotCondributionModel>[].obs;

  var isLodingUpdatebutton = false.obs;
  RxDouble totalPrice3 = 0.00.obs;

  var totalPrice = "0".obs;
  var pendingPrice = "0".obs;
  var totalPrice2 = "0".obs;
  var pendingPrice2 = "0".obs;

  var totalPrice4 = "0".obs;
  var pendingPrice4 = "0".obs;

  int count = 0;

  /// challenge history
  ChallengeHistory() async {
    try {
      isLoading(true);
      var _result = await fetchChallengeHistory();
      challengelist.assignAll(_result);
    } finally {
      isLoading(false);
    }
  }

  Future<List<ChallengehistoryModel>> fetchChallengeHistory() async {
    totalPrice.value = "0";
    pendingPrice.value = "0";
    final response = await http.post(
      Uri.parse(HistoryChallenge),
      body: {
        'district': orgdistModel.value.isNull ? "" : orgdistModel.value!.id,
        'assembly': orgassemblymodel.value.isNull
            ? ""
            : orgassemblymodel.value!.id,
        'panchayat': orgPanchaytModel.value.isNull
            ? ""
            : orgPanchaytModel.value!.id,
        'ward': orgwardModel.value.isNull ? "0" : orgwardModel.value!.id,
        'club': "0",
        'uniquedid': AppData.uniqueid ?? "",
      },
    );

    print("fetchChallengeHistory>>($count>>>>>${response.body}");
    count++;
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      //// print(response.body.toString());
      if (parsedJson['Status'] == 'true') {
        totalPrice.value = parsedJson['datareceived'].toString();
        pendingPrice.value = parsedJson['dataqty'].toString();
        var data = List<ChallengehistoryModel>.from(
          parsedJson['data'].map((x) => ChallengehistoryModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <ChallengehistoryModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  ///Sponsor
  /// sponsor Model
  challegesponsorList() async {
    try {
      isLoading1(true);
      var _result = await fetctsponsorlist();
      challengeSponsorlist.assignAll(_result);
    } finally {
      isLoading1(false);
    }
  }

  Future<List<CallengeSponsorModel>> fetctsponsorlist() async {
    final body = {
      'district': orgdistModel_S.value.isNull ? "" : orgdistModel_S.value!.id,
      'assembly': orgassemblymodel_S.value.isNull
          ? ""
          : orgassemblymodel_S.value!.id,
      'panchayat': orgPanchaytModel_S.value.isNull
          ? ""
          : orgPanchaytModel_S.value!.id,
      "ward": orgWardModel_S.value.isNull ? "0" : orgWardModel_S.value!.id,
    };

    // print(">>>>>>>>>>>.send data${body.toString()}");

    totalPrice2.value = "0";
    pendingPrice2.value = "0";
    final response = await http.post(Uri.parse(HistoryCSponsor), body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      if (parsedJson['Status'] == 'true') {
        totalPrice2.value = parsedJson['datareceived'].toString();
        pendingPrice2.value = parsedJson['dataqty'].toString();
        var data = List<CallengeSponsorModel>.from(
          parsedJson['data'].map((x) => CallengeSponsorModel.fromJson(x)),
        ).toList();
        return data;
      }

      return <CallengeSponsorModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  /// condribution /////////////
  ///contribution list api.

  Condributionlist() async {
    try {
      isLoading_Condribution(true);
      var _result = await fetctcondributionlist();
      contributionList.assignAll(_result);
    } finally {
      isLoading_Condribution(false);
    }
  }

  Future<List<ReprotCondributionModel>> fetctcondributionlist() async {
    totalPrice3.value = 0.00;

    final response = await http.post(
      Uri.parse(ContributionListApi),
      body: {
        'district': orgdistModel_D.value.isNull ? "" : orgdistModel_D.value!.id,
        'assembly': orgassemblymodel_D.value.isNull
            ? ""
            : orgassemblymodel_D.value!.id,
        'panchayat': orgPanchaytModel_D.value.isNull
            ? ""
            : orgPanchaytModel_D.value!.id,
        'ward': orgWardModel_D.value.isNull ? "" : orgWardModel_D.value!.id,
        'volunteer': AppData.volunteerId == null ? "0" : AppData.volunteerId,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      // print("Contributuion List>>>>>>>");
      // print(response.body.toString());
      if (parsedJson['Status'] == 'true') {
        int temptotal = parsedJson['datareceived'];
        totalPrice3.value = temptotal.toDouble();

        var data = List<ReprotCondributionModel>.from(
          parsedJson['data'].map((x) => ReprotCondributionModel.fromJson(x)),
        ).toList();
        return data;
      }

      return <ReprotCondributionModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  Future<bool> updatetheward(WardModel? model, String? id) async {
    isLodingUpdatebutton(true);
    final response = await http.post(
      Uri.parse(loginapi),
      body: {
        'id': id, //userid.text.toString(),
        'wardid': model!.id,
        'Mobile': txtNumber.text,
      },
    );
    // print(response.body);
    isLodingUpdatebutton(false);

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Check the status
        if (parsedJson['Status'] == 'true') {
          Get.snackbar(
            'Updated', // Title of the Snackbar
            "Your Ward is updated", // Message of the Snackbar
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              'Updated',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fmedium', // Set your custom font family here
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              'Your Ward is updated',
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
          txtNumber.clear();
          return true;
        } else {
          Get.snackbar(
            'Error', // Title of the Snackbar
            "There is a error in your updation process", // Message of the Snackbar
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              'Error',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fmedium', // Set your custom font family here
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              'There is a error in your updation process',
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
      }
    } else {
      throw Exception('Failed to load data');
    }

    return false;
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
          ditrictfulllist!.addAll(list);
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
        ditrictfulllist.isEmpty ? null : ditrictfulllist.clear();
        distristList!.isEmpty ? null : distristList!.clear();

        if (orgassemblyfullList!.isNotEmpty) orgassemblyfullList!.clear();

        if (panchayatListfull!.isNotEmpty) panchayatListfull!.clear();

        if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

        panchayatList!.isEmpty ? null : panchayatList!.clear();
        wardlist!.isEmpty ? null : wardlist!.clear();
        orgassemblyList!.isEmpty ? null : orgassemblyList!.clear();

        distristList!.addAll(list);
        ditrictfulllist!.addAll(list);
      }
    }
  }

  RxList<NewAssemblyModel> orgassemblyList = <NewAssemblyModel>[].obs;
  Rx<NewAssemblyModel?> orgassemblymodel = Rx<NewAssemblyModel?>(null);
  List<NewAssemblyModel> orgassemblyfullList = <NewAssemblyModel>[];
  fetchAssemblyapi(String S) async {
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
          orgassemblyfullList!.addAll(list);
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
        if (orgassemblyfullList!.isNotEmpty) orgassemblyfullList!.clear();

        if (panchayatListfull!.isNotEmpty) panchayatListfull!.clear();

        if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

        panchayatList!.isEmpty ? null : panchayatList!.clear();
        wardlist!.isEmpty ? null : wardlist!.clear();
        orgassemblyList!.isEmpty ? null : orgassemblyList!.clear();

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
        if (panchayatListfull!.isNotEmpty) panchayatListfull!.clear();

        if (wardlistfull!.isNotEmpty) wardlistfull!.clear();

        panchayatList!.isEmpty ? null : panchayatList!.clear();
        wardlist!.isEmpty ? null : wardlist!.clear();

        panchayatList!.addAll(list);
        panchayatListfull!.addAll(list);
      }
    }
  }

  RxList<WardModel> wardlist = <WardModel>[].obs;
  List<WardModel> wardlistfull = <WardModel>[];
  Rx<WardModel?> orgwardModel = Rx<WardModel?>(null);
  fetchwardapi(String S) async {
    orgwardModel.value = null;

    wardlist!.isEmpty ? null : wardlist!.clear();
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

  ///////////////////////////////sponsor ship////////////////////

  Rx<DistrictModel?> orgdistModel_S = Rx<DistrictModel?>(null); // Explicit type
  RxList<DistrictModel> orgdistristList_S = <DistrictModel>[].obs;
  List<DistrictModel> ditrictfulllist_S = <DistrictModel>[];

  fetchDistrictapi_S() async {
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
          ditrictfulllist_S!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.DistrictList);
      var list = List<DistrictModel>.from(
        data['data']
            .where((item) => item['id'] == "1")
            .map((x) => DistrictModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        if (ditrictfulllist_S!.isNotEmpty) ditrictfulllist_S!.clear();

        if (orgassemblyfullList_S!.isNotEmpty) orgassemblyfullList_S!.clear();

        if (orgpanchayatListfull_S!.isNotEmpty) orgpanchayatListfull_S!.clear();

        if (orgWardListFull_S!.isNotEmpty) orgWardListFull_S!.clear();

        orgdistristList_S!.isEmpty ? null : orgdistristList_S!.clear();
        orgassemblyList_S!.isEmpty ? null : orgassemblyList_S!.clear();
        orgpanchayatList_S!.isEmpty ? null : orgpanchayatList_S!.clear();
        orgWardList_S!.isEmpty ? null : orgWardList_S!.clear();

        orgdistristList_S!.addAll(list);
        ditrictfulllist_S!.addAll(list);
      }
    }
  }

  RxList<NewAssemblyModel> orgassemblyList_S = <NewAssemblyModel>[].obs;
  Rx<NewAssemblyModel?> orgassemblymodel_S = Rx<NewAssemblyModel?>(null);
  List<NewAssemblyModel> orgassemblyfullList_S = <NewAssemblyModel>[];

  fetchAssemblyapi_S(String S) async {
    // print(">>>>>>>>>>>>calling${S}");

    orgassemblymodel_S.value = null;
    orgPanchaytModel_S.value = null;
    orgWardModel_S.value = null;

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
          orgassemblyfullList_S!.addAll(list);
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
        if (orgassemblyfullList_S!.isNotEmpty) orgassemblyfullList_S!.clear();

        if (orgpanchayatListfull_S!.isNotEmpty) orgpanchayatListfull_S!.clear();

        if (orgWardListFull_S!.isNotEmpty) orgWardListFull_S!.clear();

        orgassemblyList_S!.isEmpty ? null : orgassemblyList_S!.clear();
        orgpanchayatList_S!.isEmpty ? null : orgpanchayatList_S!.clear();
        orgWardList_S!.isEmpty ? null : orgWardList_S!.clear();

        orgassemblyList_S!.addAll(list);
        orgassemblyfullList_S!.addAll(list);
      }
    }
  }

  RxList<PanchayatModel> orgpanchayatList_S = <PanchayatModel>[].obs;
  Rx<PanchayatModel?> orgPanchaytModel_S = Rx<PanchayatModel?>(null);
  List<PanchayatModel> orgpanchayatListfull_S = <PanchayatModel>[];

  fetchPanchaythapi_S(List<String> S) async {
    orgPanchaytModel_S.value = null;
    orgWardModel_S.value = null;
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
          orgpanchayatListfull_S!.addAll(list);
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
        if (orgpanchayatListfull_S!.isNotEmpty) orgpanchayatListfull_S!.clear();

        if (orgWardList_S!.isNotEmpty) orgWardList_S!.clear();

        orgpanchayatList_S!.isEmpty ? null : orgpanchayatList_S!.clear();
        orgWardList_S!.isEmpty ? null : orgWardList_S!.clear();

        orgpanchayatList_S!.addAll(list);
        orgpanchayatListfull_S!.addAll(list);
      }
    }
  }

  RxList<WardModel> orgWardList_S = <WardModel>[].obs;
  Rx<WardModel?> orgWardModel_S = Rx<WardModel?>(null);
  List<WardModel> orgWardListFull_S = <WardModel>[];
  fetchwardapi_S(String S) async {
    orgWardModel_S.value = null;
    if (orgWardListFull_S!.isNotEmpty) orgWardListFull_S!.clear();

    final response = await http.post(
      Uri.parse(historypageWardAPi),
      body: {'id': S.toString()},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<WardModel>.from(
        data['data'].map((x) => WardModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        orgWardList_S!.addAll(list);
        orgWardListFull_S!.addAll(list);
      }
    } else {
      throw Exception('Failed to load items');
    }
  }

  ///////////////////////////////Donation ship////////////////////

  Rx<DistrictModel?> orgdistModel_D = Rx<DistrictModel?>(null); // Explicit type
  RxList<DistrictModel> orgdistristList_D = <DistrictModel>[].obs;
  List<DistrictModel> ditrictfulllist_D = <DistrictModel>[];

  fetchDistrictapi_D() async {
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
          ditrictfulllist_D!.addAll(list);
        }
      } else {
        throw Exception('Failed to load items');
      }
    } else {
      Map<String, dynamic> data = json.decode(AppData.DistrictList);
      var list = List<DistrictModel>.from(
        data['data'].map((x) => DistrictModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        if (ditrictfulllist_D!.isNotEmpty) ditrictfulllist_D!.clear();

        if (orgassemblyfullList_D!.isNotEmpty) orgassemblyfullList_D!.clear();

        if (orgpanchayatListfull_D!.isNotEmpty) orgpanchayatListfull_D!.clear();

        if (orgWardListFull_D!.isNotEmpty) orgWardListFull_D!.clear();

        orgdistristList_D!.isEmpty ? null : orgdistristList_D!.clear();
        orgassemblyList_D!.isEmpty ? null : orgassemblyList_D!.clear();
        orgpanchayatList_D!.isEmpty ? null : orgpanchayatList_D!.clear();
        orgWardList_D!.isEmpty ? null : orgWardList_D!.clear();

        orgdistristList_D!.addAll(list);
        ditrictfulllist_D!.addAll(list);
      }
    }
  }

  RxList<NewAssemblyModel> orgassemblyList_D = <NewAssemblyModel>[].obs;
  Rx<NewAssemblyModel?> orgassemblymodel_D = Rx<NewAssemblyModel?>(null);
  List<NewAssemblyModel> orgassemblyfullList_D = <NewAssemblyModel>[];

  fetchAssemblyapi_D(String S) async {
    // print(">>>>>>>>>>>>calling${S}");

    orgassemblymodel_D.value = null;
    orgPanchaytModel_D.value = null;
    orgWardModel_D.value = null;

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
          orgassemblyfullList_D!.addAll(list);
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
        if (orgassemblyfullList_D!.isNotEmpty) orgassemblyfullList_D!.clear();

        if (orgpanchayatListfull_D!.isNotEmpty) orgpanchayatListfull_D!.clear();

        if (orgWardListFull_D!.isNotEmpty) orgWardListFull_D!.clear();

        orgassemblyList_D!.isEmpty ? null : orgassemblyList_D!.clear();
        orgpanchayatList_D!.isEmpty ? null : orgpanchayatList_D!.clear();
        orgWardList_D!.isEmpty ? null : orgWardList_D!.clear();

        orgassemblyList_D!.addAll(list);
        orgassemblyfullList_D!.addAll(list);
      }
    }
  }

  RxList<PanchayatModel> orgpanchayatList_D = <PanchayatModel>[].obs;
  Rx<PanchayatModel?> orgPanchaytModel_D = Rx<PanchayatModel?>(null);
  List<PanchayatModel> orgpanchayatListfull_D = <PanchayatModel>[];

  fetchPanchaythapi_D(String S) async {
    orgPanchaytModel_D.value = null;
    orgWardModel_D.value = null;
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
          orgpanchayatListfull_D!.addAll(list);
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
        if (orgpanchayatListfull_D!.isNotEmpty) orgpanchayatListfull_D!.clear();

        if (orgWardList_D!.isNotEmpty) orgWardList_D!.clear();

        orgpanchayatList_D!.isEmpty ? null : orgpanchayatList_D!.clear();
        orgWardList_D!.isEmpty ? null : orgWardList_D!.clear();

        orgpanchayatList_D!.addAll(list);
        orgpanchayatListfull_D!.addAll(list);
      }
    }
  }

  RxList<WardModel> orgWardList_D = <WardModel>[].obs;
  Rx<WardModel?> orgWardModel_D = Rx<WardModel?>(null);
  List<WardModel> orgWardListFull_D = <WardModel>[];
  fetchwardapi_D(String S) async {
    orgWardModel_D.value = null;
    if (orgWardListFull_D!.isNotEmpty) orgWardListFull_D!.clear();

    final response = await http.post(
      Uri.parse(historypageWardAPi),
      body: {'id': S.toString()},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<WardModel>.from(
        data['data'].map((x) => WardModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        orgWardList_D!.addAll(list);
        orgWardListFull_D!.addAll(list);
      }
    } else {
      throw Exception('Failed to load items');
    }
  }

  /// for challenge Participation //////>>>>>>>>>>>>>>>>>
  Rx<ClubModel?> clubModel = Rx<ClubModel?>(null);
  RxList<ClubModel> clubList = <ClubModel>[].obs;
  List<ClubModel> clubListFull = <ClubModel>[].obs;
  fetchClub() async {
    clubList.isEmpty ? null : clubList.clear();
    clubListFull.isEmpty ? null : clubListFull.clear();

    final response = await http.get(Uri.parse(ClubApi));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      var list = List<ClubModel>.from(
        data['data'].map((x) => ClubModel.fromJson(x)),
      ).toList();
      if (list.isNull) {
      } else {
        clubList!.addAll(list);
        clubListFull!.addAll(list);
      }

      ChallengeHistoryorganisation();
    } else {
      throw Exception('Failed to load items');
    }
  }

  /// challenge history
  ChallengeHistoryorganisation() async {
    try {
      isLoading(true);
      var _result = await fetchChallengeHistoryorganisation();
      challengelistClub.assignAll(_result);
    } finally {
      isLoading(false);
    }
  }

  Future<List<ChallengehistoryModel>>
  fetchChallengeHistoryorganisation() async {
    totalPrice4.value = "0";
    pendingPrice4.value = "0";
    final response = await http.post(
      Uri.parse(ChallengeHistoryOrganisation),
      body: {
        'district': "",
        'assembly': "",
        'panchayat': "",
        'ward': "",
        'club': clubModel.value.isNull ? "0" : clubModel.value!.id,
      },
    );

    // print("fetchChallengeHistoryorganisation>>${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      // print(response.body.toString());
      if (parsedJson['Status'] == 'true') {
        totalPrice4.value = parsedJson['datareceived'].toString();
        pendingPrice4.value = parsedJson['dataqty'].toString();
        var data = List<ChallengehistoryModel>.from(
          parsedJson['data'].map((x) => ChallengehistoryModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <ChallengehistoryModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }
}

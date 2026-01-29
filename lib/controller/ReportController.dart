import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/modles/AssembelyModel.dart';
import 'package:chcenterthennala/modles/ClubModel.dart';
import 'package:chcenterthennala/modles/DistrictModel.dart';
import 'package:chcenterthennala/modles/PanchayatModel.dart';
import 'package:chcenterthennala/modles/WardModel.dart';

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../modles/ChallengeSopnsorModel.dart';
import '../modles/ChallengereportparticipantsModel.dart';
import '../modles/NewAssemblyModel.dart';
import '../modles/ReportContributionModel.dart';
import '../Utils/colors.dart';

class ReportController extends GetxController {
  RxList<CallengereportPartisipationModel> callengepartisipationlist =
      <CallengereportPartisipationModel>[].obs;
  RxList<ReprotCondributionModel> contributionList =
      <ReprotCondributionModel>[].obs;
  RxList<CallengeSponsorModel> challengeSponsorlist =
      <CallengeSponsorModel>[].obs;

  var isLoading = false.obs;
  bool loading = false;
  var isLoadingSponsor = false.obs;
  var isLoading_Condribution = false.obs;
  RxDouble totalPrice = 0.00.obs;
  RxDouble pendingPrice = 0.00.obs;
  RxDouble totalPrice2 = 0.00.obs;
  RxDouble pendingPrice2 = 0.00.obs;
  RxDouble totalPrice3 = 0.00.obs;
  String? volunteer_ID;

  ///partipation list from challenge
  fullproducts() async {
    try {
      loading = true;
      isLoading(true);

      var _result = await fetctpatisipationlist();
      callengepartisipationlist.assignAll(_result);
    } finally {
      loading = false;
      isLoading(false);
    }
  }

  Future<List<CallengereportPartisipationModel>> fetctpatisipationlist() async {
    totalPrice.value = 0.00;
    pendingPrice.value = 0.00;
    final response = await http.post(
      Uri.parse(ChallengeParticipation),
      body: {
        'district': orgdistModel.value.isNull ? "" : orgdistModel.value!.id,
        'assembly': orgassemblymodel.value.isNull
            ? ""
            : orgassemblymodel.value!.id,
        'panchayat': orgPanchaytModel.value.isNull
            ? ""
            : orgPanchaytModel.value!.id,
        'ward': orgwardModel.value.isNull ? "" : orgwardModel.value!.id,
        'club': "",
        'volunteer': volunteer_ID.isNull ? "0" : volunteer_ID,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      if (parsedJson['Status'] == 'true') {
        var data = List<CallengereportPartisipationModel>.from(
          parsedJson['data'].map(
            (x) => CallengereportPartisipationModel.fromJson(x),
          ),
        ).toList();
        int temptotal = parsedJson['datareceived'];
        int temppending = parsedJson['datapending'];
        totalPrice.value = temptotal.toDouble();
        pendingPrice.value = temppending.toDouble();
        return data;
      }

      return <CallengereportPartisipationModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  /// sponsor Model
  challegesponsorList() async {
    try {
      isLoadingSponsor(true);
      var _result = await fetctsponsorlist();
      challengeSponsorlist.assignAll(_result);
    } finally {
      isLoadingSponsor(false);
    }
  }

  Future<List<CallengeSponsorModel>> fetctsponsorlist() async {
    totalPrice2.value = 0.00;
    pendingPrice2.value = 0.00;
    final response = await http.post(
      Uri.parse(ChallengeSponsor),
      body: {
        'district': orgdistModel_S.value.isNull ? "" : orgdistModel_S.value!.id,
        'assembly': orgassemblymodel_S.value.isNull
            ? ""
            : orgassemblymodel_S.value!.id,
        'panchayat': orgPanchaytModel_S.value.isNull
            ? ""
            : orgPanchaytModel_S.value!.id,
        'ward': orgWardModel_S.value.isNull ? "" : orgWardModel_S.value!.id,
        'volunteer': volunteer_ID.isNull ? "0" : volunteer_ID,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      print("Challen report sponsors${response.body.toString()}");
      if (parsedJson['Status'] == 'true') {
        int temptotal = parsedJson['datareceived'];
        int pendingtotal = parsedJson['datapending'];

        totalPrice2.value = temptotal.toDouble();
        pendingPrice2.value = pendingtotal.toDouble();
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

  ///contribution list api.

  Condributionlist(
    DistrictModel? dm,
    AssemblyModel? am,
    PanchayatModel? pm,
    WardModel? wm,
  ) async {
    try {
      isLoading_Condribution(true);
      var _result = await fetctcondributionlist(dm, am, pm, wm);
      contributionList.assignAll(_result);
    } finally {
      isLoading_Condribution(false);
    }
  }

  Future<List<ReprotCondributionModel>> fetctcondributionlist(
    DistrictModel? dm,
    AssemblyModel? am,
    PanchayatModel? pm,
    WardModel? wm,
  ) async {
    totalPrice3.value = 0.00;

    final response = await http.post(
      Uri.parse(ContributionListApi),
      body: {
        'district': dm.isNull ? "" : dm!.id,
        'assembly': am.isNull ? "" : am!.id,
        'panchayat': pm.isNull ? "" : pm!.id,
        'ward': wm.isNull ? "" : wm!.id,
        'volunteer': volunteer_ID.isNull ? "0" : volunteer_ID,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      //// print("Contributuion List>>>>>>>");
      //// print(response.body.toString());
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

  /// update the amount
  updateamount(
    String id,
    DistrictModel? dm,
    NewAssemblyModel? am,
    PanchayatModel? pm,
    WardModel? wm,
    ClubModel? cm,
  ) async {
    isLoading(true);
    final response = await http.post(Uri.parse(reportUpdate), body: {'id': id});
    //// print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      //// print(response.body.toString());
      if (parsedJson['Status'] == 'True') {
        Get.snackbar(
          'Successful', // Title of the Snackbar
          "Payment successfully .", // Message of the Snackbar
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
            'Payment updated .',
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
      }

      fullproducts();
    } else {
      isLoading(false);
      throw Exception('Failed to load challenges');
    }
  }

  updateamountsponsor(
    String id,
    DistrictModel? dm,
    NewAssemblyModel? am,
    PanchayatModel? pm,
    WardModel? wm,
  ) async {
    isLoading(true);
    final response = await http.post(Uri.parse(reportUpdate), body: {'id': id});
    //// print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      // print(response.body.toString());
      if (parsedJson['Status'] == 'True') {
        Get.snackbar(
          'Successful', // Title of the Snackbar
          "Payment successfully .", // Message of the Snackbar
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
            'Payment updated .',
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
      }
      challegesponsorList();
    } else {
      isLoading(false);
      throw Exception('Failed to load challenges');
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
            .where((item) => item['id'] == "10")
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
}

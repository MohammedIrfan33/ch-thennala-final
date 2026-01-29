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
import '../modles/NewReportModel.dart';
import '../modles/ReportContributionModel.dart';
import '../Utils/colors.dart';

class Newreportcontroller extends GetxController {
  RxList<Newreportmodel> newRportList = <Newreportmodel>[].obs;

  var isLoading = false.obs;
  RxString totalPrice = "0.00".obs;
  RxString pendingPrice = "0".obs;

  ///partipation list from challenge
  fullproducts() async {
    try {
      isLoading(true);

      var _result = await fetctpatisipationlist();
      newRportList.assignAll(_result);
    } finally {
      isLoading(false);
    }
  }

  Future<List<Newreportmodel>> fetctpatisipationlist() async {
    print(
      ">>>>>>>>>>>>>>${orgPanchaytModel.value.isNull ? "" : orgPanchaytModel.value!.id}",
    );
    print(
      ">>>>>>>>>>>>>>${orgwardModel.value.isNull ? "" : orgwardModel.value!.id}",
    );

    totalPrice.value = "0.00";
    pendingPrice.value = "0";
    final response = await http.post(
      Uri.parse(newReportApi),
      body: {
        'assembly': orgassemblymodel.value.isNull
            ? ""
            : orgassemblymodel.value!.id,
        'panchayat': orgPanchaytModel.value.isNull
            ? ""
            : orgPanchaytModel.value!.id,
        'ward': orgwardModel.value.isNull ? "" : orgwardModel.value!.id,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      if (parsedJson['Status'] == 'true') {
        var data = List<Newreportmodel>.from(
          parsedJson['data'].map((x) => Newreportmodel.fromJson(x)),
        ).toList();

        totalPrice.value = parsedJson['datareceived'] ?? "0.00";
        pendingPrice.value = parsedJson['dataqty'].toString() ?? "0";

        return data;
      }

      return <Newreportmodel>[];
    } else {
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

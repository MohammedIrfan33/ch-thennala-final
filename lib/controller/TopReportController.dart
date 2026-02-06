import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:chcenterthennala/modles/TopreportAssemblyModel.dart';
import 'package:chcenterthennala/modles/TopreportPanchatModel.dart';

import '../ApiLists/Apis.dart';
import '../modles/TopClubModel.dart';
import '../modles/TopContributorsModel.dart';

class TopreportController extends GetxController {
  RxList<Topcontributorsmodel> contributorsList = <Topcontributorsmodel>[].obs;

  RxList<TopReportassemblyModel> assemblylist = <TopReportassemblyModel>[].obs;
  RxList<TopReportpanchayatModel> panchayatlist =
      <TopReportpanchayatModel>[].obs;
  RxList<TopClubModel> clublist = <TopClubModel>[].obs;

  var isLoading4 = true.obs;
  var isLoading1 = true.obs;
  var isLoading2 = true.obs;
  var isLoading3 = true.obs;

  //Ward assging funtion>>>>>>>>>>.
  //15-03-2025 the title changed to the ward
  fullConstituency() async {
    try {
      isLoading1(true);
      var _result = await fetchConstituency();

      assemblylist.assignAll(_result);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {
      isLoading1(false);
    }
  }

  Future<List<TopReportassemblyModel>> fetchConstituency() async {
    final response = await http.get(Uri.parse(TopWard));

    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);


      // Check the status
      if (parsedJson['Status'] == 'true') {
        var data = List<TopReportassemblyModel>.from(
          parsedJson['data'].map((x) => TopReportassemblyModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <TopReportassemblyModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  //Ward assging funtion>>>>>>>>>>.
  //15-03-2025 the title changed to the ward
  fullContributors() async {
    try {
      isLoading4(true);
      var _result = await fetchContributors();
      contributorsList.assignAll(_result);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {
      isLoading4(false);
    }
  }

  Future<List<Topcontributorsmodel>> fetchContributors() async {
    final response = await http.get(Uri.parse(TopContributors));
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
        var data = List<Topcontributorsmodel>.from(
          parsedJson['data'].map((x) => Topcontributorsmodel.fromJson(x)),
        ).toList();
        return data;
      }
      return <Topcontributorsmodel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  //Ward assging funtion>>>>>>>>>>.
  fullPanchayt() async {
    try {
      isLoading2(true);
      var _result = await fetchPanchayt();
      panchayatlist.assignAll(_result);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {
      isLoading2(false);
    }
  }

  Future<List<TopReportpanchayatModel>> fetchPanchayt() async {
    final response = await http.get(Uri.parse(Toppanchayat));
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
        var data = List<TopReportpanchayatModel>.from(
          parsedJson['data'].map((x) => TopReportpanchayatModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <TopReportpanchayatModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  fullorganisation() async {
    try {
      isLoading3(true);
      var clublistresult = await fetchrganisation();
      clublist.assignAll(clublistresult);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {
      isLoading3(false);
    }
  }

  Future<List<TopClubModel>> fetchrganisation() async {
    final response = await http.get(Uri.parse(TopClub));

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
        var data = List<TopClubModel>.from(
          parsedJson['data'].map((x) => TopClubModel.fromJson(x)),
        ).toList();
        return data;
      }
      return <TopClubModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fullConstituency();
    fullPanchayt();
    fullorganisation();
    fullContributors();
  }
}

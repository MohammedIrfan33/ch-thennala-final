import 'dart:convert';

import 'package:get/get.dart';
import 'package:chcenterthennala/modles/TopClubModel.dart';
import 'package:chcenterthennala/modles/TopvolunteerModel.dart';
import 'package:http/http.dart' as http;

import '../ApiLists/Apis.dart';

class TopClubController extends GetxController {
  RxList<TopClubModel> clublist = <TopClubModel>[].obs;
  List<TopClubModel> templsit = <TopClubModel>[];
  var isLoading = true.obs;

  fulllist() async {
    try {
      isLoading(true);
      var clublistresult = await fetchclub();
      clublist.assignAll(clublistresult);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {
      isLoading(false);
    }
  }

  Future<List<TopClubModel>> fetchclub() async {
    isLoading(true);
    final response = await http.get(Uri.parse(TopClub));
    templsit.clear();

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
        var data = List<TopClubModel>.from(
          parsedJson['data'].map((x) => TopClubModel.fromJson(x)),
        ).toList();
        templsit.assignAll(data);
      }
      return templsit;
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fulllist();
  }

  @override
  void onClose() {
    super.onClose();
    // Cleanup resources if necessary
    clublist.clear();
    //print('Controller disposed');
  }
}

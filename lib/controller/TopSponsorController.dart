import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:chcenterthennala/modles/TopClubModel.dart';
import 'package:chcenterthennala/modles/TopvolunteerModel.dart';
import 'package:http/http.dart' as http;

import '../ApiLists/Apis.dart';
import '../modles/ChallengeSopnsorModel.dart';

class Topsponsorcontroller extends GetxController {
  RxList<CallengeSponsorModel> challengeSponsorlist =
      <CallengeSponsorModel>[].obs;
  var isLoading = true.obs;

  fulllist() async {
    try {
      var clublistresult = await fetchsponsors();
      challengeSponsorlist.assignAll(clublistresult);
    } finally {
      isLoading(false);
    }
  }

  Future<List<CallengeSponsorModel>> fetchsponsors() async {
    final response = await http.post(
      Uri.parse(TopSponsor),
      body: {"ward": "0", "club": "0"},
    );
    //// print("fetchsponsors>>>>>>>>>>>>>>>>>");
    // print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fulllist();
  }

  @override
  void onClose() {
    super.onClose();
    challengeSponsorlist.clear();
    // print('Controller disposed');
  }
}

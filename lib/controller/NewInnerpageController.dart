import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../modles/ChallengehistroyModel.dart';
import '../modles/ChallengereportparticipantsModel.dart';

class Newinnerpagecontroller extends GetxController {
  RxList<ChallengehistoryModel> callengepartisipationlist =<ChallengehistoryModel>[].obs;
  var isLoading = false.obs;

  ///partipation list from challenge
  fullproducts(String pachayathID,String wardID) async {
    try {
      isLoading(true);

      var _result = await fetctpatisipationlist(pachayathID,wardID);
      callengepartisipationlist.assignAll(_result);
    } finally {
      isLoading(false);
    }
  }

  Future<List<ChallengehistoryModel>> fetctpatisipationlist(String pachayathID,String wardID) async {

    final response = await http.post(
        Uri.parse(HistoryChallenge),
        body: {
          'district':"",
          'assembly':"",
          'panchayat':pachayathID,
          'ward':wardID,
          'club':"0",
          'uniquedid':AppData.uniqueid??""

        });

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      if (parsedJson['Status'] == 'true') {


        var data = List<ChallengehistoryModel>.from(
            parsedJson['data']
                .map((x) => ChallengehistoryModel.fromJson(x)))
            .toList();

        return data;
      }

      return <ChallengehistoryModel>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }



}
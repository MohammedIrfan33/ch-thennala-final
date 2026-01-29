import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../ApiLists/Apis.dart';
import '../modles/ChallengeModel.dart';


class Challengecontroller extends GetxController{
  var Challengedeatils =<ChallengeModel>[].obs;
  var isLoading = true.obs;


  ChallengeDeatils() async{

    try {
      isLoading(true);
      var challengesResult = await fetchChallenges();
      Challengedeatils.assignAll(challengesResult);
    } finally {
      isLoading(false);
    }


  }

  @override
  void onInit() {
    // TODO: implement onInit
    ChallengeDeatils();
    super.onInit();
  }

  Future<List<ChallengeModel>> fetchChallenges() async {
    final response = await http.get(Uri.parse(Challengedetails));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<ChallengeModel> challenges = (data['data'] as List)
          .map((challengeJson) => ChallengeModel.fromJson(challengeJson))
          .toList();
      return challenges;
    } else {
      throw Exception('Failed to load challenges');
    }
  }

}
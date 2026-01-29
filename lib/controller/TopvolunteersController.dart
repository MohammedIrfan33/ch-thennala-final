import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:chcenterthennala/modles/TopvolunteerModel.dart';
import 'package:http/http.dart' as http;

import '../ApiLists/Apis.dart';

class TopvolunteerController extends GetxController {
  RxList<TopvolunteersModel> volunterlist = <TopvolunteersModel>[].obs;
  List<TopvolunteersModel> templsit = <TopvolunteersModel>[];
  var isLoading = true.obs;

  fulllist() async {
    try {
      isLoading(true);
      var challengesResult = await fetvolunteerlist();
      volunterlist.assignAll(challengesResult);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {
      isLoading(false);
    }
  }

  fulllist2() async {
    try {
      var challengesResult = await fetvolunteerlist();
      volunterlist.assignAll(challengesResult);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {}
  }

  Future<List<TopvolunteersModel>> fetvolunteerlist() async {
    // isLoading(true);
    final response = await http.get(Uri.parse(TopvolunteerApi));
    templsit.clear();

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
        var data = List<TopvolunteersModel>.from(
          parsedJson['data'].map((x) => TopvolunteersModel.fromJson(x)),
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

    //startApiCallTimer();
  }

  @override
  void onClose() {
    super.onClose();
    // Cleanup resources if necessary
    volunterlist.clear();
    _timer?.cancel();
    // print('Controller disposed');
  }

  Timer? _timer;
  final int intervalSeconds = 5;
  void startApiCallTimer() {
    _timer = Timer.periodic(Duration(seconds: intervalSeconds), (timer) {
      fulllist2();
    });
  }
}

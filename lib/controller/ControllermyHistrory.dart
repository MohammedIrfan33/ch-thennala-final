import 'dart:convert';
import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiLists/Apis.dart';
import 'package:http/http.dart' as http;
import '../modles/ModelMyhistrory.dart';

class Controllermyhistrory extends GetxController {
  RxList<ModelMyHistroy> contributionlist = <ModelMyHistroy>[].obs;

  var isLoading1 = false.obs;
  var isLodingUpdatebutton = false.obs;

  /// challenge history
  ///COntribution
  ContibutionHistory(String? id) async {
    try {
      var _result = await fetchContibutionHistory(id);
      contributionlist.assignAll(_result);
    } finally {
      isLoading1(false);
    }
  }

  Future<List<ModelMyHistroy>> fetchContibutionHistory(String? id) async {
    //print("your id>>>>>>contribution${id}");
    final response = await http.post(
      Uri.parse(myHistoeyApi),
      body: {'uniquedid': id ?? ""},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      print(response.body.toString());
      if (parsedJson['Status'] == 'true') {
        box.write("myhistory", parsedJson);
        var data = List<ModelMyHistroy>.from(
          parsedJson['data'].map((x) => ModelMyHistroy.fromJson(x)),
        ).toList();
        return data;
      } else {
        box.write("myhistory", parsedJson);
      }
      return <ModelMyHistroy>[];
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  final box = GetStorage();

  localdatainbase() async {


    Map<String, dynamic>? parsedJson = box.read("myhistory");

    if (parsedJson.isNull) {
      //print("No data found!");
    } else {
      if (parsedJson!['Status'] == 'true') {
        var data = List<ModelMyHistroy>.from(
          parsedJson!['data'].map((x) => ModelMyHistroy.fromJson(x)),
        ).toList();
        contributionlist.assignAll(data);
      } else {
        contributionlist.assignAll(<ModelMyHistroy>[]);
      }
    }

    ContibutionHistory(AppData.uniqueid);
  }
}

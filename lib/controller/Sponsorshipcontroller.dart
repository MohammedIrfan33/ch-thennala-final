import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:chcenterthennala/modles/Sponsorshipmodel.dart';
import 'package:http/http.dart' as http;

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../modles/itemListmodel.dart';

class Sponsorshipcontroller extends GetxController {
  RxList<Sponsorshipmodel> filteredProducts = <Sponsorshipmodel>[].obs;
  List<Sponsorshipmodel> allProducts = <Sponsorshipmodel>[];
  final txtcontrollers = <TextEditingController>[].obs;

  RxString totalPrice = "0.00".obs;
  var isLoading = true.obs;

  fullproducts() async {
    try {
      isLoading(true);
      var challengesResult = await fetchproductsFromlocal();
      filteredProducts.assignAll(challengesResult);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
    } finally {
      isLoading(false);
    }
  }

  // Future<List<Sponsorshipmodel>> fetchproducts() async {
  //   isLoading(true);
  //   final response = await http.get(Uri.parse(SponsorshipList));
  //   allProducts.clear();
  //
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //     // Check the status
  //     if (parsedJson['Status'] == 'true') {
  //       var data = List<Itemlistmodel>.from(
  //           parsedJson['data'].map((x) => Itemlistmodel.fromJson(x))).toList();
  //
  //       if (data != null)
  //       {
  //         if (data[0].the1.isNotEmpty) {
  //           allProducts.add(Sponsorshipmodel(
  //             id: data[0].id1,
  //               name: data[0].the1,
  //               rate: data[0].rate1,
  //               quantity: 0));
  //         }
  //         if (data[0].the2.isNotEmpty) {
  //           allProducts.add(Sponsorshipmodel(
  //               id: data[0].id2,
  //               name: data[0].the2,
  //               rate: data[0].rate2,
  //               quantity: 0));
  //         }
  //         if (data[0].the3.isNotEmpty) {
  //           allProducts.add(Sponsorshipmodel(
  //               id: data[0].id3,
  //               name: data[0].the3,
  //               rate: data[0].rate3,
  //               quantity: 0));
  //         }
  //         if (data[0].the4.isNotEmpty) {
  //           allProducts.add(Sponsorshipmodel(
  //               id: data[0].id4,
  //               name: data[0].the4,
  //               rate: data[0].rate4,
  //               quantity: 0));
  //         }
  //         if (data[0].the5.isNotEmpty) {
  //           allProducts.add(Sponsorshipmodel(
  //               id: data[0].id5,
  //               name: data[0].the5,
  //               rate: data[0].rate5,
  //               quantity: 0));
  //         }
  //       }
  //       int itemCount = allProducts.length; // Get the count of items from the response
  //       txtcontrollers.value = List.generate(itemCount, (index){
  //         final controller = TextEditingController();
  //         controller.text = allProducts[index].quantity.toString();
  //         return controller;
  //       });
  //
  //
  //
  //
  //     }
  //     return allProducts;
  //   } else {
  //     throw Exception('Failed to load challenges');
  //   }
  // }

  Future<List<Sponsorshipmodel>> fetchproductsFromlocal() async {
    print("Local call>>>>>>>>>>>>>");

    allProducts.clear();
    allProducts.add(
      Sponsorshipmodel(id: "1", name: "Dates", rate: "500", quantity: 0),
    );

    int itemCount =
        allProducts.length; // Get the count of items from the response
    txtcontrollers.value = List.generate(itemCount, (index) {
      final controller = TextEditingController();
      controller.text = allProducts[index].quantity.toString();
      return controller;
    });

    return allProducts;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fullproducts();
  }

  @override
  void onClose() {
    super.onClose();
    // Cleanup resources if necessary
    filteredProducts.clear();
    txtcontrollers.clear();
    //print('Controller disposed');
  }

  void addItemQuantity(int index, String text) {
    if (text.isEmpty) {
      //print(">>>>>>>>>>>>>>>>>>>empty");
      filteredProducts[index].quantity = 0;
      calculateTotalPrice();
    } else {
      //print(">>>>>>>>>>>>>>>>>>>${text}");
      filteredProducts[index].quantity = int.parse(text);
      calculateTotalPrice();
    }
  }

  void increaseItemQuantity(int index) {
    filteredProducts[index].quantity++;
    txtcontrollers[index].text = filteredProducts[index].quantity.toString();
    calculateTotalPrice();
  }

  void decreaseItemQuantity(int index) {
    filteredProducts[index].quantity--;
    txtcontrollers[index].text = filteredProducts[index].quantity.toString();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice.value = "0.00";
    double temptotal = 0;
    for (var element in filteredProducts) {
      temptotal += element.quantity * double.parse(element.rate);
      //print(">>>>>>>>>>>>>>>>>>>>total${totalPrice}");
      //// print(">>>>>>>>>>>>>>>>>>>>totaltemp${temptotal}");
    }
    totalPrice.value = temptotal.toString();
    update();
  }
}

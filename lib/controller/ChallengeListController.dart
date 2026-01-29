import 'dart:convert';

import 'package:chcenterthennala/ApiLists/Appdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:chcenterthennala/modles/ChallenegeListModel.dart';
import 'package:http/http.dart' as http;
import 'package:chcenterthennala/modles/ChallengeListItemModel.dart';

import '../ApiLists/Apis.dart';

class ChallengeListcontroller extends GetxController {
  RxList<Challegelistmodel> filteredProducts = <Challegelistmodel>[].obs;

  List<Challegelistmodel> allProducts = <Challegelistmodel>[];
  final txtcontrollers = <TextEditingController>[].obs;

  RxDouble totalPrice = 0.00.obs;
  var isLoading = true.obs;
  int maxValue = 0;

  fullproducts(int count) async {
    try {
      isLoading(true);
      var challengesResult = await fetchproductsFromlocal();
      filteredProducts.assignAll(challengesResult);
      //isChecked.value = List<bool>.generate(filteredProducts.length, (index) => false);
      Future.delayed(Duration(milliseconds: 10)).then((value) {
        initialValueSet(count.toString());
      });
    } finally {
      isLoading(false);
    }
  }

  // Future<List<Challegelistmodel>> fetchproducts() async {
  //   print("api call>>>>>>>>>>>>>");
  //   final response = await http.get(Uri.parse(challengeitemlist));
  //   allProducts.clear();
  //
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> parsedJson = jsonDecode(response.body);
  //
  //     // Check the status
  //     if (parsedJson['Status'] == 'true') {
  //       var data = List<ChallnegListItems>.from(
  //               parsedJson['data'].map((x) => ChallnegListItems.fromJson(x)))
  //           .toList();
  //
  //       if (data != null) {
  //         if (data[0].pro1.isNotEmpty) {
  //           allProducts.add(Challegelistmodel(
  //
  //               name: data[0].pro1,
  //               productid: data[0].prodid1,
  //               quantity: 0,
  //               img: data[0].img1,
  //               rate: data[0].rate1));
  //         }
  //         if (data[0].pro2.isNotEmpty) {
  //           allProducts.add(Challegelistmodel(
  //
  //               name: data[0].pro2,
  //               productid: data[0].prodid2,
  //               quantity: 0,
  //               img: data[0].img2,
  //               rate: data[0].rate2));
  //         }
  //         if (data[0].pro3.isNotEmpty) {
  //           allProducts.add(Challegelistmodel(
  //               name: data[0].pro3,
  //               productid: data[0].prodid3,
  //               quantity: 0,
  //               img: data[0].img3,
  //               rate: data[0].rate3));
  //         }
  //       }
  //
  //
  //       int itemCount = allProducts.length; // Get the count of items from the response
  //       txtcontrollers.value = List.generate(itemCount, (index){
  //         final controller = TextEditingController();
  //         controller.text = allProducts[index].quantity.toString();
  //         return controller;
  //       });
  //     }
  //     return allProducts;
  //   } else {
  //     throw Exception('Failed to load challenges');
  //   }
  // }
  Future<List<Challegelistmodel>> fetchproductsFromlocal() async {
    print("Local call>>>>>>>>>>>>>");

    allProducts.clear();
    allProducts.add(
      Challegelistmodel(
        name: "Dates",
        productid: "1",
        quantity: 0,
        img: "assets/cart/cartimg.jpg",
        rate: "500",
      ),
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
  }

  @override
  void onClose() {
    // TODO: implement onClose
    filteredProducts.clear();
    allProducts.clear();
    txtcontrollers.clear();

    super.onClose();
  }

  void addItemQuantity(int index, String text) {
    if (text.isEmpty) {
      //// print(">>>>>>>>>>>>>>>>>>>empty");
      filteredProducts[index].quantity = 0;
      calculateTotalPrice();

      update();
    } else {
      //// print(">>>>>>>>>>>>>>>>>>>${text}");
      filteredProducts[index].quantity = int.parse(text);

      calculateTotalPrice();
      update();
    }
  }

  void initialValueSet(String count) {
    filteredProducts[0].quantity = int.parse(count);
    txtcontrollers[0].text = filteredProducts[0].quantity.toString();
    calculateTotalPrice();
    update();
  }

  void increaseItemQuantity(int index) {
    filteredProducts[index].quantity++;
    txtcontrollers[index].text = filteredProducts[index].quantity.toString();
    calculateTotalPrice();

    update();
  }

  void decreaseItemQuantity(int index) {
    filteredProducts[index].quantity--;
    txtcontrollers[index].text = filteredProducts[index].quantity.toString();
    calculateTotalPrice();

    update();
  }

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in filteredProducts) {
      totalPrice.value += element.quantity * double.parse(element.rate);
    }
  }
}

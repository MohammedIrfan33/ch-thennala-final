import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:chcenterthennala/modles/ChallengeListItemModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLists/Apis.dart';
import '../Utils/colors.dart';
import '../modles/ChangeOrderListModel.dart';
import '../modles/ChangeorderModel.dart';

class OrderupdateController extends GetxController {
  RxList<ChangeOrderList> orderlist = <ChangeOrderList>[].obs;
  List<ChangeOrderList> lists = <ChangeOrderList>[];
  var isLoading = false.obs;
  var isLoadingButton = false.obs;
  RxDouble totalPrice = 0.00.obs;

  fullproducts(String id) async {
    try {
      isLoading(true);
      var _result = await fetchproducts(id);
      orderlist.assignAll(_result);
    } finally {
      isLoading(false);
    }
  }

  Future<List<ChangeOrderList>> fetchproducts(String id) async {
    lists.clear();
    final response = await http.post(
      Uri.parse(updateOrderlist),
      body: {'id': id},
    );
    //// print("OrderupdateController>>>>>>>>>>");
    //// print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);

      // Check the status
      if (parsedJson['Status'] == 'true') {
        calculateTotalPrice();
        var data = List<ChangeOrderModel>.from(
          parsedJson['data'].map((x) => ChangeOrderModel.fromJson(x)),
        ).toList();

        if (data != null) {
          if (data[0].productName1.isNotEmpty) {
            lists.add(
              ChangeOrderList(
                name: data[0].productName1,
                productid: data[0].prodid1,
                quantity: data[0].firstorderedproductqty,
                hasOrdered: data[0].firstorderedproductqty,
                img: data[0].productImage1,
                rate: data[0].productAmount1,
              ),
            );
          }
          if (data[0].productName2.isNotEmpty) {
            lists.add(
              ChangeOrderList(
                name: data[0].productName2,
                productid: data[0].prodid2,
                quantity: data[0].secondorderedproductqty,
                hasOrdered: data[0].secondorderedproductqty,
                img: data[0].productImage2,
                rate: data[0].productAmount2,
              ),
            );
          }
          if (data[0].productName3.isNotEmpty) {
            lists.add(
              ChangeOrderList(
                name: data[0].productName3,
                productid: data[0].prodid3,
                quantity: data[0].thirdorderedproductqty,
                hasOrdered: data[0].thirdorderedproductqty,
                img: data[0].productImage3,
                rate: data[0].productAmount3,
              ),
            );
          }
        }
      }
      return lists;
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  void increaseItemQuantity(int index) {
    orderlist[index].quantity++;
    calculateTotalPrice();

    update();
  }

  void decreaseItemQuantity(int index) {
    if (orderlist[index].hasOrdered == orderlist[index].quantity) {
      Get.snackbar(
        "Error",
        "Action denied!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      orderlist[index].quantity--;
      calculateTotalPrice();
    }
  }

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in orderlist) {
      totalPrice.value += element.quantity * double.parse(element.rate);
    }
    update();
  }

  /// ////////////////save apis/////////////////////////////////
  transactionupdate(String id) async {
    isLoadingButton(true);
    final response = await http.post(
      Uri.parse(transactionUpdate),
      body: {'id': id},
    );
    //// print("1>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //// print(response.body);
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        isLoadingButton(false);
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'] == 'True') {
          transactiondetailsupdate(id);
        } else {
          isLoadingButton(false);
        }
      }
    } else {
      isLoadingButton(false);
      throw Exception('Failed to load data');
    }
  }

  transactiondetailsupdate(String id) async {
    final response = await http.post(
      Uri.parse(transactiondetailsUpdate),
      body: {'id': id, 'amount': totalPrice.toString()},
    );
    //// print("2>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //// print(response.body);
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        isLoadingButton(false);
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);
        if (parsedJson['Status'] == 'True') {
          titlesave(id);
        } else {
          isLoadingButton(false);
        }
      }
    } else {
      isLoadingButton(false);

      throw Exception('Failed to load data');
    }
  }

  titlesave(String id) async {
    int index = 0;
    int lastIndex = 0;
    for (var element in orderlist) {
      if (element.quantity != 0) {
        lastIndex++;
      }
    }
    lastIndex--;
    for (var element in orderlist) {
      if (element.quantity != 0) {
        final response = await http.post(
          Uri.parse(Savethetitle),
          body: {
            'hdrid': id,
            'item': element.productid,
            'qty': element.quantity.toString(),
            'rate': element.rate,
            'amount': (element.quantity * double.parse(element.rate))
                .toString(),
          },
        );
        //// print("3>>>>>>>>>>>>>>>>>>>>>>>>>>Index:${index}");
        //// print("3>>>>>>>>>>>>>>>>>>>>>>>>>>last:${lastIndex}");
        //// print(response.body);
        if (response.statusCode == 200) {
          if (response.body.isEmpty) {
          } else {
            Map<String, dynamic> parsedJson = jsonDecode(response.body);
            if (parsedJson['Status'] == 'True') {
              if (index == lastIndex) {
                // isLoadingButton(false);
                // Get.snackbar(
                //   'Updated', // Title of the Snackbar
                //   'Your order is updated.', // Message of the Snackbar
                //   snackPosition: SnackPosition.BOTTOM, // Position of the Snackbar
                //   backgroundColor: Colors.blue, // Background color of the Snackbar
                //   colorText: Colors.white, // Text color of the Snackbar
                //   borderRadius: 10, // Border radius of the Snackbar
                //   margin: EdgeInsets.all(10), // Margin around the Snackbar
                //   duration: Duration(seconds: 3), // Duration for which the Snackbar is displayed
                // );
                Get.back();
                Get.snackbar(
                  'Updated', // Title of the Snackbar
                  "Your order is updated.", // Message of the Snackbar
                  snackPosition: SnackPosition.BOTTOM,
                  titleText: Text(
                    'Updated',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Fmedium', // Set your custom font family here
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  messageText: Text(
                    'Your order is updated.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:
                          'Fontsemibold', // Set your custom font family here
                      fontSize: 14,
                    ),
                  ), // Position of the Snackbar
                  backgroundColor: AppColors
                      .primaryColor2, // Background color of the Snackbar
                  colorText: Colors.white, // Text color of the Snackbar
                  borderRadius: 10, // Border radius of the Snackbar
                  margin: EdgeInsets.all(10), // Margin around the Snackbar
                  duration: Duration(
                    seconds: 3,
                  ), // Duration for which the Snackbar is displayed
                );
              }
            } else {}
          }
        } else {
          isLoadingButton(false);
          throw Exception('Failed to load data');
        }
        index++;
      }
    }

    isLoadingButton(false);
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:chcenterthennala/modles/loginModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLists/Apis.dart';
import '../ApiLists/Appdata.dart';
import '../Utils/colors.dart';

class Usercontroller extends GetxController {
  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();
  var isLoading = false.obs;

  var user = <Usermodel>[].obs;
  // admin
  //'info@workmateinfotech.com'

  volunteerlogin() async {
    isLoading(true);
    final response = await post(
      Uri.parse(loginapi),
      body: {
        'email': userid.text.toString(),
        'password': password.text.toString(),
      },
    );
    //print(response.body);
    isLoading(false);
    //print("user id ${userid.text.toString()}");
    //print("password ${password.text.toString()}");

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
      } else {
        Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Check the status
        if (parsedJson['Status'] == 'true') {
          //print("password ${password.text.toString()}");

          clearcontroller();
          //var data=List<Usermodel>.from(jsonDecode(parsedJson['data'].toString()).map((e)=>Usermodel.fromJson(e))).toList();
          var data = List<Usermodel>.from(
            parsedJson['data'].map((x) => Usermodel.fromJson(x)),
          ).toList();
          // var data=Usermodel.fromJson(jsonDecode(parsedJson['data'].toString()));
          if (data != null) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            await sharedPreferences.setString("id", data[0].id);
            await sharedPreferences.setString("name", data[0].name);
            await sharedPreferences.setString("mobile", data[0].mobile);
            await sharedPreferences.setString("clubid", data[0].clubId);

            Get.back();
            Get.snackbar(
              'Login', // Title of the Snackbar
              "Login Successfull .", // Message of the Snackbar
              snackPosition: SnackPosition.BOTTOM,
              titleText: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Fmedium', // Set your custom font family here
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              messageText: const Text(
                'Login Successfull .',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily:
                      'Fontsemibold', // Set your custom font family here
                  fontSize: 14,
                ),
              ), // Position of the Snackbar
              backgroundColor:
                  AppColors.primaryColor2, // Background color of the Snackbar
              colorText: Colors.white, // Text color of the Snackbar
              borderRadius: 10, // Border radius of the Snackbar
              margin: const EdgeInsets.all(10), // Margin around the Snackbar
              duration: const Duration(
                seconds: 3,
              ), // Duration for which the Snackbar is displayed
            );
          } else {
            Get.snackbar(
              'Error', // Title of the Snackbar
              "Loging denied !", // Message of the Snackbar
              snackPosition: SnackPosition.BOTTOM,
              titleText: const Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Fmedium', // Set your custom font family here
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              messageText: const Text(
                'Loging denied !',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily:
                      'Fontsemibold', // Set your custom font family here
                  fontSize: 14,
                ),
              ), // Position of the Snackbar
              backgroundColor:
                  AppColors.primaryColor2, // Background color of the Snackbar
              colorText: Colors.white, // Text color of the Snackbar
              borderRadius: 10, // Border radius of the Snackbar
              margin: const EdgeInsets.all(10), // Margin around the Snackbar
              duration: const Duration(
                seconds: 3,
              ), // Duration for which the Snackbar is displayed
            );
          }
        } else {
          Get.snackbar(
            'Error', // Title of the Snackbar
            "Invaild credentials!", // Message of the Snackbar
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              'Error',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fmedium', // Set your custom font family here
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              'Invaild credentials!',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Fontsemibold', // Set your custom font family here
                fontSize: 14,
              ),
            ), // Position of the Snackbar
            backgroundColor:
                AppColors.primaryColor2, // Background color of the Snackbar
            colorText: Colors.white, // Text color of the Snackbar
            borderRadius: 10, // Border radius of the Snackbar
            margin: const EdgeInsets.all(10), // Margin around the Snackbar
            duration: const Duration(
              seconds: 3,
            ), // Duration for which the Snackbar is displayed
          );
        }
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  clearcontroller() {
    userid.clear();
    password.clear();
  }
}

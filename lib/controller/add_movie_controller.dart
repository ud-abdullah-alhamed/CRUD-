import 'dart:convert';

import 'package:desktopapp/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddMovie extends GetxController {
  final firstFormkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController genre = TextEditingController();
  validateFiled(String? text) {
    if (GetUtils.isUsername(text!)) {
      return null;
    }
    return 'Filed is not vaild';
  }

  void postData(String name, String title, String genre) async {
    // API endpoint URL
    var apiUrl =
        Uri.parse('https://apiservicesavxav.azurewebsites.net/api/Movies');

    // Your JSON data
    var jsonData = {
      "id": 0, // auto genrated
      "name": name,
      "title": title,
      "genre": genre,
      "releaseDate": "2023-12-26T11:56:43.888",
    };

    // Convert the JSON data to a string
    var jsonString = jsonEncode(jsonData);

    try {
      // Send a POST request to the API
      var response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Data sent successfully');
        print('Response: ${response.body}');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error sending data: $error');
    }
  }

  Future<void> movieAdded(String name, String title, String genre) async {
    if (firstFormkey.currentState!.validate()) {
      postData(name, title, genre);
      Get.back();
    } else {
      Get.snackbar("ERROR", "Invalid Data",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    }
  }
}

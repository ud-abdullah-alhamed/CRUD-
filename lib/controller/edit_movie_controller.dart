import 'dart:convert';

import 'package:desktopapp/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditMovie extends GetxController {
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

  void updateData(String id, String name, String title, String genre) async {
    int editId = int.parse(id);
    // API endpoint URL
    String apiUrl =
        "https://apiservicesavxav.azurewebsites.net/api/Movies/$editId"; // Replace with your API endpoint

    // JSON data to be sent in the request body
    Map<String, dynamic> data = {
      "id": editId,
      "name": name,
      "title": title,
      "genre": genre,
      "releaseDate": "2023-12-26T11:56:43.888",
    };

    // Convert the data to a JSON string
    String jsonData = jsonEncode(data);

    // Send the PUT request
    var response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      print("Data updated successfully");
    } else {
      print("Failed to update data. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }

  Future<void> movieEdit(String name, String title, String genre) async {
    if (firstFormkey.currentState!.validate()) {
    } else {
      Get.snackbar("ERROR", "Invalid Data",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConstants.mainScaffoldBackgroundColor,
          backgroundColor: ColorConstants.snakbarColorError);
    }
  }
}

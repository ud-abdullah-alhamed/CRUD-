import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RxString otp = ''.obs;

  // Function to generate a random 6-digit OTP
  String generateOTP() {
    Random random = Random();
    int otpValue = 100000 +
        random.nextInt(900000); // Random number between 100000 and 999999
    return otpValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP GET Request'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            otp.value = generateOTP();

            // Call the function to make the GET request
            makeGetRequest();
          },
          child: Text('Make GET Request'),
        ),
      ),
    );
  }

  void makeGetRequest() async {
    // Specify the API URL

    final String apiUrl =
        'https://josmsservice.com/SMSServices/Clients/Prof/RestSingleSMS/SendSMS?senderid=Ev%20car&numbers=962787781174&accname=evcar&AccPass=uN7iI6eT4qD5bP5d&msg=$otp';

    try {
      // Make the GET request
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Print the response body
        print('Response: ${response.body}');
      } else {
        // Print an error message if the request was not successful
        print(
            'Failed to make GET request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the request
      print('Error making GET request: $e');
    }
  }
}

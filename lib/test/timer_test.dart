import 'dart:async';
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
    return GetMaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RxBool isButtonDisabled = false.obs;

  final RxInt countdown = 5.obs;

  final RxString otp = ''.obs;

  String generateOTP() {
    Random random = Random();
    int otpValue = 100000 +
        random.nextInt(900000); // Random number between 100000 and 999999
    return otpValue.toString();
  }

  void _onButtonPressed() {
    otp.value = generateOTP();
    isButtonDisabled.value = true;

    // Call the function to make the GET request

    makeGetRequest();

    Timer.periodic(Duration(seconds: 1), (timer) {
      countdown.value -= 1;

      if (countdown.value == 0) {
        isButtonDisabled.value = false;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disable Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => ElevatedButton(
                onPressed: isButtonDisabled.value ? null : _onButtonPressed,
                child: Text('Press Me'),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
                  isButtonDisabled.value
                      ? 'Button Disabled for ${countdown.value} seconds'
                      : '',
                  style: TextStyle(fontSize: 16),
                )),
          ],
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

import 'package:desktopapp/OTP/controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OTPController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disable Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => ElevatedButton(
                onPressed: controller.isButtonDisabled.value
                    ? null
                    : controller.onButtonPressed,
                child: const Text('Press Me'),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
                  controller.isButtonDisabled.value
                      ? 'Button Disabled for ${controller.countdown.value} seconds'
                      : '',
                  style: const TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:desktopapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PortableChargerButton extends StatelessWidget {
  const PortableChargerButton({super.key, required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: AppTheme.lightAppColors.buttoncolor),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'اتصل الان',
                style: TextStyle(
                  color: AppTheme.lightAppColors.background,
                  fontFamily: 'cairo-Medium',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 50,
        ),
        GestureDetector(
            onTap: () {},
            child: IconButton(
                onPressed: () => null,
                icon: const Icon(Icons.message_outlined)))
      ],
    );
  }
}

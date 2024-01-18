import 'package:desktopapp/sizes/sizes.dart';
import 'package:desktopapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChargingStationCard extends StatelessWidget {
  const ChargingStationCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    List<String> feathers = [
      '- الشحن في اي مكان بالممكلة ',
      '- اسعار منافسة',
      '- الشحن في اي مكان بالممكلة ',
      '- اسعار منافسة'
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      height: 0.18 * context.screenHeight,
      width: 0.10 * context.screenWidth,
      decoration: BoxDecoration(
        color: AppTheme.lightAppColors.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Text(
                    'اكسترا للشحن المتنقل ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container())
                ],
              ),
              SizedBox(
                width: 200,
                height: 56,
                child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: feathers.length,
                    itemBuilder: (context, index) {
                      return Text(feathers[index]);
                    }),
              ),
              SizedBox(
                height: context.screenHeight * 0.004,
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                      color: AppTheme.lightAppColors.buttoncolor,
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 2,
                          color: AppTheme.lightAppColors.buttoncolor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Center(
                      child: Text(
                        'اتصل الان',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.04,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5.5,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 2,
                          color: AppTheme.lightAppColors.buttoncolor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Center(
                      child: IconButton(
                          onPressed: () => null,
                          icon: Icon(Icons.message_outlined,
                              size: 20,
                              color: AppTheme.lightAppColors.buttoncolor)),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

String shortenText(String text, {int maxLength = 10}) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}

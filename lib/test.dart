import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChargingStation {
  final String id;
  final String title;
  final String img;
  final String address;
  final String coordinates;
  final String number;
  final String type;
  final List<String> features;
  bool liked;

  ChargingStation(
      {required this.id,
      required this.title,
      required this.img,
      required this.address,
      required this.coordinates,
      required this.number,
      required this.type,
      required this.features,
      this.liked = false});

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
        id: json['_id'],
        title: json['title'],
        img: json['img'],
        address: json['address'],
        coordinates: json['coordinates'],
        number: json['number'],
        type: json['type'],
        features: List<String>.from(json['features']),
        liked: false);
  }
}

class HomeController extends GetxController {
  late RxList<ChargingStation> chargingStations = <ChargingStation>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchChargingStations();
  }

  Future<void> fetchChargingStations() async {
    final response = await http.get(Uri.parse(
        'https://adventurous-yak-pajamas.cyclic.app/stations/getStationsByType/home_charging_provider'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      chargingStations.assignAll(
        jsonList.map((json) => ChargingStation.fromJson(json)).toList(),
      );
    } else {
      throw Exception('Failed to load charging stations');
    }
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Stations'),
      ),
      body: Center(
        child: Obx(
          () {
            if (controller.chargingStations.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: controller.chargingStations.length,
                itemBuilder: (context, index) {
                  ChargingStation chargingStation =
                      controller.chargingStations[index];

                  return ListTile(
                    title: Text(chargingStation.title),
                    subtitle: Text(chargingStation.id),
                    // Add more UI elements as needed
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const GetMaterialApp(
      home: HomeScreen(),
    ),
  );
}

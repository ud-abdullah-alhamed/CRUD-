import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/ChargingStation .dart';

class CharchingScreen extends StatefulWidget {
  const CharchingScreen({super.key});

  @override
  State<CharchingScreen> createState() => _CharchingScreenState();
}

class _CharchingScreenState extends State<CharchingScreen> {
  late Box<ChargingStation> charchingBox;

  @override
  void initState() {
    super.initState();
    fetchCharching();
    charchingBox = Hive.box<ChargingStation>('charchingStation');
  }

  Future<void> fetchCharching() async {
    final response = await http.get(Uri.parse(
        'https://adventurous-yak-pajamas.cyclic.app/stations/getStationsByType/home_charging_provider'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<ChargingStation> charching =
          jsonData.map((item) => ChargingStation.fromJson(item)).toList();

      for (var charching in charching) {
        if (charchingBox.containsKey(charching.id)) {
          charching.liked = charchingBox.get(charching.id)!.liked;
        }
        charchingBox.put(charching.id, charching);
      }
      setState(() {});
    } else {
      throw Exception('Failed to load posts');
    }
  }

  void toggleLike(String charchingID) {
    ChargingStation chargingStation = charchingBox.get(charchingID)!;
    chargingStation.liked = !chargingStation.liked;
    charchingBox.put(charchingID, chargingStation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: charchingBox.listenable(),
        builder: (context, Box<ChargingStation> box, _) {
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                ChargingStation chargingStation = box.getAt(index)!;
                return ListTile(
                  title: Text(chargingStation.title),
                  trailing: IconButton(
                    onPressed: () => toggleLike(chargingStation.id),
                    icon: Icon(
                      chargingStation.liked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: chargingStation.liked ? Colors.red : null,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class CharchingStationsAdapter extends TypeAdapter<ChargingStation> {
  @override
  final int typeId = 3;

  @override
  ChargingStation read(BinaryReader reader) {
    return ChargingStation(
        id: reader.read(),
        title: reader.read(),
        liked: reader.read(),
        features: reader.read());
  }

  @override
  void write(BinaryWriter writer, ChargingStation obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.liked);
    writer.write(obj.features);
  }
}

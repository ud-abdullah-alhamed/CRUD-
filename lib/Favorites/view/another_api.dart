import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:desktopapp/Favorites/model/ChargingStation%20.dart';
import 'package:flutter/material.dart';

class MobileList extends StatefulWidget {
  const MobileList({super.key});

  @override
  _MobileListState createState() => _MobileListState();
}

class _MobileListState extends State<MobileList> {
  List<ChargingStation> chargingStations = [];
  late Box<ChargingStation> charchingBox;
  @override
  void initState() {
    super.initState();

    charchingBox = Hive.box<ChargingStation>('charchingStation');
    fetchData();
  }

  List<ChargingStation> getLikedItems() {
    return charchingBox.values
        .where((chargingStation) => chargingStation.liked)
        .toList();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://adventurous-yak-pajamas.cyclic.app/stations/getStationsByType/mobile_charging'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        chargingStations =
            data.map((json) => ChargingStation.fromJson(json)).toList();
        print(chargingStations.first.id);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charging Stations'),
      ),
      body: chargingStations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: chargingStations.length,
              itemBuilder: (context, index) {
                final station = chargingStations[index];
                return ListTile(
                  title: Text(station.title),
                  subtitle: Text(station.address),
                  trailing: IconButton(
                    onPressed: () => {
                      print(station.id),
                      toggleLike(station),
                    },
                    icon: Icon(
                      station.liked ? Icons.favorite : Icons.favorite_border,
                      color: station.liked ? Colors.red : null,
                    ),
                  ),
                  // You can customize the UI based on your needs
                );
              },
            ),
    );
  }

  void toggleLike(ChargingStation chargingID) {
    String x = chargingID.id;
    ChargingStation? chargingStation = charchingBox.get(x);

    if (chargingStation != null) {
      // ChargingStation found in the box, toggle the liked status
      chargingStation.liked = !chargingStation.liked;
      charchingBox.put(x, chargingStation);
    } else {
      // ChargingStation not found in the box, add a new one
      chargingStation = ChargingStation(
          id: x,
          liked: true,
          title: chargingID.title,
          features: chargingID.features); // Adjust constructor as needed
      charchingBox.put(x, chargingStation);
    }

    setState(() {});
  }
}

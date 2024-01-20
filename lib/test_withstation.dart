import 'dart:convert';
import 'package:desktopapp/test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(
      ChargingStationAdapter()); // Register Hive adapter for your model
  await Hive.openBox<ChargingStation>('chargingStations');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FavoritePageWithApi(),
    );
  }
}

class FavoritePageWithApi extends StatefulWidget {
  const FavoritePageWithApi({Key? key}) : super(key: key);

  @override
  State<FavoritePageWithApi> createState() => _FavoritePageWithApiState();
}

class _FavoritePageWithApiState extends State<FavoritePageWithApi> {
  late Box<ChargingStation> chargingStationBox;

  @override
  void initState() {
    super.initState();
    chargingStationBox = Hive.box<ChargingStation>('chargingTest');
    fetchChargingStations();
    print(chargingStationBox.length);
  }

  Future<void> fetchChargingStations() async {
    final response = await http.get(Uri.parse(
        'https://adventurous-yak-pajamas.cyclic.app/stations/getStationsByType/home_charging_provider'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<ChargingStation> chargingStations =
          jsonData.map((item) => ChargingStation.fromJson(item)).toList();

      for (var chargingStation in chargingStations) {
        if (chargingStationBox.containsKey(chargingStation.id)) {
          chargingStation.liked =
              chargingStationBox.get(chargingStation.id)!.liked;
        }
        chargingStationBox.put(chargingStation.id, chargingStation);
      }
      print(chargingStations);
      setState(() {});
    } else {
      throw Exception('Failed to load charging stations');
    }
  }

  void toggleLike(String chargingStationId) {
    print("Toggling like for $chargingStationId");

    ChargingStation chargingStation =
        chargingStationBox.get(chargingStationId)!;
    chargingStation.liked = !chargingStation.liked;
    chargingStationBox.put(chargingStationId, chargingStation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {
                  Hive.box<ChargingStation>('chargingTest').clear(),
                  // Optionally, you can setState or update your UI after clearing data
                  setState(() {})
                },
            icon: Icon(Icons.delete)),
        title: const Text('Favorite Page'),
      ),
      body: ValueListenableBuilder(
        valueListenable: chargingStationBox.listenable(),
        builder: (context, Box<ChargingStation> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              ChargingStation chargingStation = box.getAt(index)!;

              return ListTile(
                title: Text(chargingStation.title),
                subtitle: Text(chargingStation.address),
                trailing: IconButton(
                    icon: Icon(
                      chargingStation.liked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: chargingStation.liked ? Colors.red : null,
                    ),
                    onPressed: () => {
                          toggleLike(chargingStation.id),
                          print(chargingStation.id)
                        }),
              );
            },
          );
        },
      ),
    );
  }
}

// Hive Adapter for the ChargingStation model
class ChargingStationAdapter extends TypeAdapter<ChargingStation> {
  @override
  final int typeId = 20;

  @override
  ChargingStation read(BinaryReader reader) {
    return ChargingStation(
      id: reader.read(),
      title: reader.read(),
      img: reader.read(),
      address: reader.read(),
      coordinates: reader.read(),
      number: reader.read(),
      type: reader.read(),
      features: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, ChargingStation obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.img);
    writer.write(obj.address);
    writer.write(obj.coordinates);
    writer.write(obj.number);
    writer.write(obj.type);
    writer.write(obj.features);
  }
}

import 'package:desktopapp/Favorites/model/ChargingStation%20.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LikedItemsScreen extends StatefulWidget {
  const LikedItemsScreen({Key? key}) : super(key: key);

  @override
  State<LikedItemsScreen> createState() => _LikedItemsScreenState();
}

class _LikedItemsScreenState extends State<LikedItemsScreen> {
  late Box<ChargingStation> charchingBox;

  @override
  void initState() {
    super.initState();
    charchingBox = Hive.box<ChargingStation>('charchingStation');
  }

  List<ChargingStation> getLikedItems() {
    return charchingBox.values
        .where((chargingStation) => chargingStation.liked)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<ChargingStation> likedItems = getLikedItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Items'),
      ),
      body: ListView.builder(
        itemCount: likedItems.length,
        itemBuilder: (context, index) {
          ChargingStation chargingStation = likedItems[index];
          return ListTile(
            title: Text(chargingStation.title),
            trailing: IconButton(
              onPressed: () => toggleLike(chargingStation.id),
              icon: Icon(
                chargingStation.liked ? Icons.favorite : Icons.favorite_border,
                color: chargingStation.liked ? Colors.red : null,
              ),
            ),
          );
        },
      ),
    );
  }

  void toggleLike(String charchingID) {
    ChargingStation chargingStation = charchingBox.get(charchingID)!;
    chargingStation.liked = !chargingStation.liked;
    charchingBox.put(charchingID, chargingStation);
    setState(() {});
  }
}

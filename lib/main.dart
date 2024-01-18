import 'package:desktopapp/Favorites/model/ChargingStation%20.dart';
import 'package:desktopapp/Favorites/model/post_model.dart';
import 'package:desktopapp/Favorites/view/another_api.dart';
import 'package:desktopapp/Favorites/view/charching_station.dart';
import 'package:desktopapp/Favorites/view/favorites_screen.dart';
import 'package:desktopapp/Favorites/view/getx_favorite.dart';
import 'package:desktopapp/Favorites/view/test_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(CharchingStationsAdapter());

  await Hive.openBox<Post>('posts');
  await Hive.openBox<Post>('postsWithGetx');
  await Hive.openBox<ChargingStation>('charchingStation');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: const Locale('ar', 'AE'),
        title: 'Test Templete',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: const MainWidget());
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Get.to(const FavoritePage()),
                child: const Text('favorites page with Hive')),
            ElevatedButton(
                onPressed: () => Get.to(const FavoritePageWithGetx()),
                child: const Text('favorites page with Hive And getx')),
            ElevatedButton(
                onPressed: () => Get.to(const CharchingScreen()),
                child: const Text('data')),
            ElevatedButton(
                onPressed: () => Get.to(const LikedItemsScreen()),
                child: const Text('All Liked Data')),
            ElevatedButton(
                onPressed: () => Get.to(const MobileList()),
                child: const Text('All  Data')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen(
      {required this.name,
      required this.title,
      required this.releaseDate,
      required this.genre,
      required this.id,
      super.key});

  final String name;
  final String title;
  final String genre;
  final String releaseDate;
  final int id;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          scrolledUnderElevation: 0,
          title: const Text('Movies Details'),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("id :  $id"),
                Text("Name :  $name"),
                Text("title : $title"),
                Text("genre : $genre"),
                Text("relase Date $releaseDate"),
              ],
            )),
      ),
    );
  }
}

import 'package:desktopapp/controller/MovieController.dart';
import 'package:desktopapp/controller/edit_movie_controller.dart';
import 'package:desktopapp/view/edit_movie.dart';
import 'package:desktopapp/widget/action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppContainer extends StatelessWidget {
  const AppContainer(
      {required this.name,
      required this.title,
      required this.releaseDate,
      required this.genre,
      required this.id,
      required this.onTap,
      Key? key})
      : super(key: key);
  final VoidCallback onTap;
  final String name;
  final String title;
  final String genre;
  final String releaseDate;
  final int id;

  @override
  Widget build(BuildContext context) {
    final contrller = Get.put(MovieController());
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 2)),
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            const SizedBox(width: 310),
            Text(title),
            const SizedBox(width: 310),
            Text(genre),
            const SizedBox(width: 310),
            Text(releaseDate),
            const SizedBox(width: 250),
            SizedBox(child: Text("$id")),
            Expanded(child: Container()),
            ActionButton(
                title: "Edit",
                onTap: () => Get.to(EditMoviePage(
                      name: name,
                      title: title,
                      releaseDate: genre,
                      genre: genre,
                      id: id,
                    ))),
            const SizedBox(width: 25),
            ActionButton(
                title: "Delete", onTap: () => contrller.deleteMovieById(id)),
          ],
        ),
      ),
    );
  }
}

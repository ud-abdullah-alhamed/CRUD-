import 'package:desktopapp/controller/MovieController.dart';
import 'package:desktopapp/view/add_movie.dart';
import 'package:desktopapp/view/movie_details.dart';
import 'package:desktopapp/widget/app_container.dart';
import 'package:desktopapp/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieController());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text('Movies App'),
          actions: [
            ProductButton(
                title: "Add movie", onTap: () => Get.to(const AddMoviePage()))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name'),
                      Text('title'),
                      Text('genre'),
                      Text('releaseDate'),
                      Text('id'),
                      Text('actions')
                    ]),
                Container(
                  width: double.infinity,
                  height: 1000,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: FutureBuilder<List<dynamic>>(
                    future: controller.fetchMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppContainer(
                                    name: snapshot.data![index]['name'],
                                    title: snapshot.data![index]['title'],
                                    releaseDate: snapshot.data![index]
                                        ['releaseDate'],
                                    genre: snapshot.data![index]['genre'],
                                    onTap: () => Get.to(MovieDetailsScreen(
                                      name: snapshot.data![index]['name'],
                                      title: snapshot.data![index]['title'],
                                      releaseDate: snapshot.data![index]
                                          ['releaseDate'],
                                      genre: snapshot.data![index]['genre'],
                                      id: snapshot.data![index]['id'],
                                    )),
                                    id: snapshot.data![index]['id'],
                                  ),
                                ]);
                          },
                        );
                      } else if (snapshot.hasError) {
                        // Display an error message if there is an error
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      // Display a loading spinner while the data is being fetched
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// movie_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieController extends GetxController {
  Future<List<dynamic>> fetchMovies() async {
    final Uri apiUrl =
        Uri.parse('https://apiservicesavxav.azurewebsites.net/api/Movies');

    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> deleteMovieById(int id) async {
    final url = Uri.parse(
        'https://apiservicesavxav.azurewebsites.net/api/Movies?id=$id');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // The resource was successfully deleted
        print('Movie with ID $id deleted successfully.');
      } else {
        // Something went wrong
        print('Failed to delete movie. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error while deleting movie: $e');
    }
  }

  void postData(String name, String title, String genre) async {
    // API endpoint URL
    var apiUrl =
        Uri.parse('https://apiservicesavxav.azurewebsites.net/api/Movies');

    // Your JSON data
    var jsonData = {
      "id": 0, // auto genrated
      "name": name,
      "title": title,
      "genre": genre,
      "releaseDate": "2023-12-26T11:56:43.888",
    };

    // Convert the JSON data to a string
    var jsonString = jsonEncode(jsonData);

    try {
      // Send a POST request to the API
      var response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonString,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Data sent successfully');
        print('Response: ${response.body}');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error sending data: $error');
    }
  }
}

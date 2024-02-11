
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class PostsController extends GetxController {
//   var posts = <Post>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchPosts();
//   }

//   Future<void> fetchPosts() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = response.body as List<dynamic>;
//       posts.assignAll(jsonData.map((item) => Post.fromJson(item)).toList());
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }
// }

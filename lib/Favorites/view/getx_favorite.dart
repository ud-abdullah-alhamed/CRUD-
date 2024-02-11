// // pos
// import 'dart:convert';

// import 'package:desktopapp/Favorites/model/post_model.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // posts_controller.dart

// class PostsController extends GetxController {
//   var posts = <Post>[].obs;
//   late Box<Post> postBox;
//   @override
//   void onInit() {
//     super.onInit();
//     postBox = Hive.box<Post>('postsWithGetx');
//     fetchPosts();
//   }

//   Future<void> fetchPosts() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       posts.assignAll(jsonData.map((item) => Post.fromJson(item)).toList());
//       for (var post in posts) {
//         if (postBox.containsKey(post.id)) {
//           post.liked = postBox.get(post.id)!.liked;
//         }
//         postBox.put(post.id, post);
//       }

//       update();
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }

//   void toggleLike(int postId) {
//     Post post = postBox.get(postId)!;

//     post.liked = !post.liked;
//     postBox.put(postId, post);
//     update();
//   }
// }

// // main.dart

// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(PostAdapter());
//   await Hive.openBox<Post>('postsWithGetx');

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const GetMaterialApp(
//       home: FavoritePageWithGetx(),
//     );
//   }
// }

// class FavoritePageWithGetx extends StatelessWidget {
//   const FavoritePageWithGetx({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorite Page with Getx'),
//       ),
//       body: GetX<PostsController>(
//         init: PostsController(),
//         builder: (controller) {
//           return ListView.builder(
//             itemCount: controller.posts.length,
//             itemBuilder: (context, index) {
//               final post = controller.posts[index];

//               return ListTile(
//                 title: Text(post.title),
//                 trailing: IconButton(
//                   icon: Icon(
//                     post.liked ? Icons.favorite : Icons.favorite_border,
//                     color: post.liked ? Colors.red : null,
//                   ),
//                   onPressed: () =>
//                       {controller.toggleLike(post.id), print(post.id)},
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // Hive Adapter for the Post model
// class PostAdapter extends TypeAdapter<Post> {
//   @override
//   final int typeId = 0;

//   @override
//   Post read(BinaryReader reader) {
//     return Post(
//       id: reader.read(),
//       title: reader.read(),
//       liked: reader.read(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Post obj) {
//     writer.write(obj.id);
//     writer.write(obj.title);
//     writer.write(obj.liked);
//   }
// }

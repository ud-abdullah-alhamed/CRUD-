// import 'dart:convert';
// import 'package:desktopapp/Favorites/model/post_model.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive_flutter/hive_flutter.dart';

// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(
//       PostAdapterWithGetx()); // Register Hive adapter for your model
//   await Hive.openBox<Post>('posts');

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: FavoritePage(),
//     );
//   }
// }

// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage> {
//   late Box<Post> postBox;

//   @override
//   void initState() {
//     super.initState();
//     postBox = Hive.box<Post>('posts');
//     fetchPosts();
//     print(postBox);
//   }

//   Future<void> fetchPosts() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       final List<Post> posts =
//           jsonData.map((item) => Post.fromJson(item)).toList();

//       for (var post in posts) {
//         if (postBox.containsKey(post.id)) {
//           post.liked = postBox.get(post.id)!.liked;
//         }
//         postBox.put(post.id, post);
//       }
//       print(posts);
//       setState(() {});
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }

//   void toggleLike(int postId) {
//     Post post = postBox.get(postId)!;
//     post.liked = !post.liked;
//     postBox.put(postId, post);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorite Page'),
//       ),
//       body: ValueListenableBuilder(
//         valueListenable: postBox.listenable(),
//         builder: (context, Box<Post> box, _) {
//           return ListView.builder(
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               Post post = box.getAt(index)!;
//               post.liked;
//               return ListTile(
//                 title: Text(post.title),
//                 trailing: IconButton(
//                   icon: Icon(
//                     post.liked ? Icons.favorite : Icons.favorite_border,
//                     color: post.liked ? Colors.red : null,
//                   ),
//                   onPressed: () => toggleLike(post.id),
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
// class PostAdapterWithGetx extends TypeAdapter<Post> {
//   @override
//   final int typeId = 3;

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

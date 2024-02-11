// import 'package:desktopapp/review/model/post.dart';
// import 'package:desktopapp/review/pages/post_details.dart';
// import 'package:flutter/material.dart';

// class PostListPage extends StatelessWidget {
//   final List<Post> postsList = [
//     Post(id: 1, title: 'Post 1', content: 'Details of Post 1'),
//     Post(id: 2, title: 'Post 2', content: 'Details of Post 2'),
//     // Add more posts as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Post List'),
//       ),
//       body: ListView.builder(
//         itemCount: postsList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(postsList[index].title),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PostDetailsPage(
//                     post: postsList[index],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

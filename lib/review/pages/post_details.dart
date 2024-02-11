// import 'package:desktopapp/review/model/post.dart';
// import 'package:flutter/material.dart';

// class PostDetailsPage extends StatefulWidget {
//   final Post post;

//   PostDetailsPage({required this.post});

//   @override
//   State<PostDetailsPage> createState() => _PostDetailsPageState();
// }

// class _PostDetailsPageState extends State<PostDetailsPage> {
//   late bool reviewed;

//   @override
//   void initState() {
//     super.initState();
//     StorageUtil.getReview(widget.post.id).then((value) {
//       setState(() {
//         reviewed = value;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Post Details'),
//       ),
//       body: Column(
//         children: [
//           Text(widget.post.title),
//           Text(widget.post.content),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 reviewed = true;
//               });
//               StorageUtil.saveReview(widget.post.id, true);
//             },
//             child: Text('Press me'),
//           ),
//           if (reviewed)
//             ElevatedButton(
//               onPressed: () {
//                 // Add your review logic here
//                 // This button will only be displayed if 'reviewed' is true
//               },
//               child: Text('Review'),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:desktopapp/review/model/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxSet<int> reviewedPosts = <int>{}.obs;

  void toggleReviewed(int postId) {
    if (reviewedPosts.contains(postId)) {
      reviewedPosts.remove(postId);
    } else {
      reviewedPosts.add(postId);
    }
    StorageUtil.saveReview(reviewedPosts.toList());
  }

  bool isPostReviewed(int postId) {
    return reviewedPosts.contains(postId);
  }

  void loadReviewedPosts() async {
    List<int>? storedIds = await StorageUtil.getReview();
    if (storedIds != null) {
      reviewedPosts.addAll(storedIds);
    }
  }
}

class PostListPage extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  final List<Post> posts = [
    Post(id: 1, title: 'Post 1', content: 'Details of Post 1'),
    Post(id: 2, title: 'Post 2', content: 'Details of Post 2'),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(posts[index].title),
            onTap: () {
              postController
                  .loadReviewedPosts(); // Load reviewed status before navigating
              Get.to(() => PostDetailsPage(post: posts[index]));
            },
          );
        },
      ),
    );
  }
}

class PostDetailsPage extends StatelessWidget {
  final Post post;

  PostDetailsPage({required this.post});

  final PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Column(
        children: [
          Text(post.title),
          Text(post.content),
          ElevatedButton(
            onPressed: () {
              postController.toggleReviewed(post.id);
            },
            child: Text('Press me'),
          ),
          Obx(() {
            if (postController.isPostReviewed(post.id)) {
              return ElevatedButton(
                onPressed: () {
                  // Add your review logic here
                },
                child: Text('Review'),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}

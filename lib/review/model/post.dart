import 'package:shared_preferences/shared_preferences.dart';

class Post {
  final int id;
  final String title;
  final String content;

  Post({required this.id, required this.title, required this.content});
}

class StorageUtil {
  static saveReview(List<int> postIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'reviewed_posts', postIds.map((id) => id.toString()).toList());
  }

  static Future<List<int>?> getReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedIds = prefs.getStringList('reviewed_posts');
    return storedIds?.map((id) => int.parse(id)).toList();
  }
}

import 'dart:async';
import 'package:flutter_application_5/src/model/post.dart';
import 'package:flutter_application_5/src/services/api_service.dart';

class PostBloc {
  final _postController = StreamController<List<Post>>();

  Stream<List<Post>> get posts => _postController.stream;

  final ApiService apiService = ApiService();

  PostBloc() {
    _fetchPosts();
  }


  void _fetchPosts() async {
    try {
      final response = await apiService.getRequest('/posts');
      final List<Post> posts = (response as List).map((postJson) => Post.fromJson(postJson)).toList();
      _postController.sink.add(posts);
    } catch (error) {
      _postController.sink.addError('Failed to load posts');
    }
  }

  void dispose() {
    _postController.close();
  }
}

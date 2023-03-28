import 'dart:ffi';

import 'package:flutter_application_5/src/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_5/src/model/post.dart';
import 'dart:convert';

class PostAPI {
  final ApiService apiService = ApiService();
  PostAPI();

  Future<List<Post>> getPosts() async {
    final response = await apiService.getRequest('/posts');
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((postJson) => Post.fromJson(postJson)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }

  // Other methods as needed
}

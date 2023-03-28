import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_5/src/config/app_config.dart';

class ApiService {
  // static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  // final String baseUrl;

  ApiService();

  Future<dynamic> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse(AppConfig.baseUrl + endpoint));
    // print(baseUrl + endpoint);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

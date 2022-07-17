import 'dart:convert';
import 'package:amazon_clone/util/global_variables.dart';
import 'package:http/http.dart' as http;

class HttpReq {
  static Future<http.Response> postData({
    required String endpoint,
    Map<String, dynamic>? reqBody,
    String token = '',
  }) async {
    return await http.post(
      Uri.parse('$baseUrl' + endpoint),
      body: json.encode(reqBody),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "auth_token": token,
      },
    );
  }

  static Future<http.Response> fetchData({
    required String endpoint,
    String token = '',
  }) async {
    return await http.get(
      Uri.parse('$baseUrl' + endpoint),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "auth_token": token,
      },
    );
  }






  static Future<http.Response> deleteData({
    required String endpoint,
    String token = '',
  }) async {
    return await http.delete(
      Uri.parse('$baseUrl' + endpoint),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "auth_token": token,
      },
    );
  }

}

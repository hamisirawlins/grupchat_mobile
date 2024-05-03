import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpUtility {
  static String baseUrl = dotenv.env['GATEWAY_URL'] ?? '';

  // HTTP GET request
  static Future<Map<String, dynamic>> get(String url, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$url'),
      headers: {'Authorization': token},
    );
    return _handleResponse(response);
  }

  // HTTP POST request
  static Future<Map<String, dynamic>> post(
      String url, dynamic body, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$url'),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response);
  }

  // HTTP PUT request
  static Future<Map<String, dynamic>> put(
      String url, dynamic body, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$url'),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response);
  }

  // HTTP DELETE request
  static Future<Map<String, dynamic>> delete(String url, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$url'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return _handleResponse(response);
  }

  // _handleResponse
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load: ${response.statusCode}');
    }
  }
}

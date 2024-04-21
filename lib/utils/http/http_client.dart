import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpUtility {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  //HTTP GET request
  static Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse('$baseUrl/$url'));
    return _handleResponse(response);
  }

  //HTTP POST request
  static Future<Map<String, dynamic>> post(String url, dynamic body) async {
    final response = await http.post(Uri.parse('$baseUrl/$url'),
        body: json.encode(body), headers: {'Content-Type': 'application/json'});
    return _handleResponse(response);
  }

  //HTTP PUT request
  static Future<Map<String, dynamic>> put(String url, dynamic body) async {
    final response = await http.put(Uri.parse('$baseUrl/$url'),
        body: json.encode(body), headers: {'Content-Type': 'application/json'});
    return _handleResponse(response);
  }

  //HTTP DELETE request
  static Future<Map<String, dynamic>> delete(String url) async {
    final response = await http.delete(Uri.parse('$baseUrl/$url'));
    return _handleResponse(response);
  }

  //_handleResponse
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load: ${response.statusCode}');
    }
  }
}

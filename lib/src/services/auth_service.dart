import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late String baseUrl;

  AuthService() {
    baseUrl = dotenv.get('BASE_API_URL',
        fallback: 'https://sandbox.api.lettutor.com');
  }

  Future<Map<String, dynamic>> registerByMail(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final tokens = jsonDecode(response.body)['tokens'];
      final user = jsonDecode(response.body)['user'];
      return {
        'success': true,
        'message': 'Login successful',
        'tokens': tokens,
        'user': user
      };
    } else {
      return {'success': false, 'message': 'Registration failed'};
    }
  }

  Future<Map<String, dynamic>> registerByPhone(
      String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/phone-register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'password': password}),
    );

    if (response.statusCode == 200) {
      final tokens = jsonDecode(response.body)['tokens'];
      final user = jsonDecode(response.body)['user'];
      return {
        'success': true,
        'message': 'Login successful',
        'tokens': tokens,
        'user': user
      };
    }
    if (jsonDecode(response.body)["internalCode"] == 36) {
      return {
        'success': true,
        'message': 'Login successful',
      };
    } else {
      return {'success': false, 'message': 'Registration failed'};
    }
  }

  Future<Map<String, dynamic>> loginByMail(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Assuming your API returns a token upon successful login
      final token = jsonDecode(response.body)['token'];
      final user = jsonDecode(response.body)['user'];
      return {
        'success': true,
        'message': 'Login successful',
        'token': token,
        'user': user
      };
    } else {
      return {'success': false, 'message': 'Login failed'};
    }
  }

  Future<Map<String, dynamic>> loginByMailAuth(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/google'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'access_token': token}),
    );

    if (response.statusCode == 200) {
      // Assuming your API returns a token upon successful login
      final tokens = jsonDecode(response.body)['tokens'];
      final user = jsonDecode(response.body)['user'];
      return {
        'success': true,
        'message': 'Login successful',
        'tokens': tokens,
        'user': user
      };
    } else {
      return {'success': false, 'message': 'Login failed'};
    }
  }
  Future<Map<String, dynamic>> loginByFbAuth(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/facebook'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'access_token': token}),
    );

    if (response.statusCode == 200) {
      // Assuming your API returns a token upon successful login
      final tokens = jsonDecode(response.body)['tokens'];
      final user = jsonDecode(response.body)['user'];
      return {
        'success': true,
        'message': 'Login successful',
        'tokens': tokens,
        'user': user
      };
    } else {
      return {'success': false, 'message': 'Login failed'};
    }
  }

  Future<Map<String, dynamic>> loginByPhone(
      String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/phone-login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Assuming your API returns a token upon successful login
      final token = jsonDecode(response.body)['token'];
      final user = jsonDecode(response.body)['user'];
      return {
        'success': true,
        'message': 'Login successful',
        'token': token,
        'user': user
      };
    } else {
      return {'success': false, 'message': 'Login failed'};
    }
  }

  Future<Map<String, dynamic>> sendOtpPhone(String phone) async {
    SharedPreferences prefers = await SharedPreferences.getInstance();
    final auth_token = prefers.getString('access_token');
    final response = await http.post(
      Uri.parse('$baseUrl/phone-auth-verify/create'),
      headers: {
        'Content-Type': 'application/json',
        'auth_token': auth_token.toString()
      },
      body: jsonEncode({'phone': phone}),
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Login successful',
      };
    } else {
      return {'success': false, 'message': 'Login failed'};
    }
  }
}

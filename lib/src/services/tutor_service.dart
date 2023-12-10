import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_20120598/src/services/util_service.dart';

class TutorService {
  late String baseUrl;

  TutorService() {
    baseUrl = dotenv.get('BASE_API_URL',
        fallback: 'https://sandbox.api.lettutor.com');
  }

  Future<Map<String, dynamic>> getTutors(int page, int perPage) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(
      Uri.parse('$baseUrl/tutor/more?perPage=$perPage&page=$page'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokens['access_token']}',
      },
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Register successful',
        'data': jsonDecode(response.body)
      };
    } else {
      return {'success': false, 'message': 'Cannot get tutors'};
    }
  }
}

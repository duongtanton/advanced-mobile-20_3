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

  Future<Map<String, dynamic>> getTutors(
      {page = 1,
      perPage = 10,
      search,
      nationality = const [],
      date,
      tutoringTimeAvailableStart,
      tutoringTimeAvailableEnd}) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    Map<String, dynamic> body = {
      'page': page,
      'perPage': perPage,
      'date': date,
      'search': search,
      'tutoringTimeAvailable': [
        tutoringTimeAvailableStart,
        tutoringTimeAvailableEnd
      ]
    };
    final response = await http.post(
      Uri.parse('$baseUrl/tutor/search'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokens['access_token']}',
      },
      body: jsonEncode(body),
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

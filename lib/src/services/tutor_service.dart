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
      nationality,
      specialties,
      date,
      tutoringTimeAvailableStart,
      tutoringTimeAvailableEnd}) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    if (null != nationality && "all" != nationality) {
      if ("onboarded" == nationality) {
        nationality = {'isNative': false, 'isVietNamese': false};
      } else {
        nationality = {nationality: true};
      }
    }
    Map<String, dynamic> body = {
      'page': page,
      'perPage': perPage,
      'search': search,
      'filters': {
        'date': date,
        'nationality': nationality ?? {},
        'specialties':
            "all" == specialties || null == specialties ? [] : [specialties],
        'tutoringTimeAvailable': [
          tutoringTimeAvailableStart,
          tutoringTimeAvailableEnd
        ]
      },
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

  Future<Map<String, dynamic>> getTutorById(String id) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(
      Uri.parse('$baseUrl/tutor/$id'),
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
      return {'success': false, 'message': 'Cannot get tutor'};
    }
  }

  Future<Map<String, dynamic>> getFeedback({
    tutorId,
    page = 1,
    perPage = 10,
  }) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(
      Uri.parse('$baseUrl/feedback/v2/$tutorId?page=$page&perPage=$perPage'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokens['access_token']}',
      },
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Register successful',
        'data': jsonDecode(response.body)?['data']
      };
    } else {
      return {'success': false, 'message': 'Cannot get tutor'};
    }
  }

  Future<Map<String, dynamic>> getTutorSchedules(
      String tutorId, int page) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(
      Uri.parse('$baseUrl/schedule?tutorId=$tutorId&page=$page'),
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Register successful',
        'data': jsonDecode(response.body)?['scheduleOfTutor']
      };
    } else {
      return {'success': false, 'message': 'Cannot get tutor'};
    }
  }
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_20120598/src/services/util_service.dart';

class CourseService {
  late String baseUrl;

  CourseService() {
    baseUrl = dotenv.get('BASE_API_URL',
        fallback: 'https://sandbox.api.lettutor.com');
  }

  Future<Map<String, dynamic>> getCourse(
      {currentPage = 1, perPage = 10, level, categoryId, orderBy, searchText}) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    var url = '$baseUrl/course?page=$currentPage&size=$perPage';
    if (level != null) {
      url += '&level[]=$level';
    }
    if (categoryId != null) {
      url += '&category_id[]=$categoryId';
    }
    if (orderBy != null) {
      url += '&order_by=$orderBy';
    }
    if (searchText != null) {
      url += '&q=$searchText';
    }
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Get courses successful',
        'data': jsonDecode(response.body)?['data']
      };
    } else {
      return {'success': false, 'message': 'Get courses failed'};
    }
  }

  Future<Map<String, dynamic>> getEbook({
    currentPage = 1,
    perPage = 10,
  }) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(
        Uri.parse('$baseUrl/e-book?page=$currentPage&size=$perPage'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokens['access_token']}'
        });

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Get ebooks successful',
        'data': jsonDecode(response.body)?['data']
      };
    } else {
      return {'success': false, 'message': 'Get ebooks failed'};
    }
  }

  Future<Map<String, dynamic>> getInteractiveEbook({
    currentPage = 1,
    perPage = 10,
  }) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(
        Uri.parse(
            '$baseUrl/interactive-e-book?page=$currentPage&size=$perPage'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokens['access_token']}'
        });
    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Get interactive ebooks successful',
        'data': jsonDecode(response.body)?['data']
      };
    } else {
      return {'success': false, 'message': 'Get interactive ebooks failed'};
    }
  }

  Future<Map<String, dynamic>> getById(String id) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(Uri.parse('$baseUrl/course/$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });
    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Get course successful',
        'data': jsonDecode(response.body)?['data']
      };
    } else {
      return {'success': false, 'message': 'Get course failed'};
    }
  }

  Future<Map<String, dynamic>> getContentCategory() async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response =
        await http.get(Uri.parse('$baseUrl/content-category'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });
    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Get content category successful',
        'data': jsonDecode(response.body)?['rows']
      };
    } else {
      return {'success': false, 'message': 'Get content category failed'};
    }
  }
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_20120598/src/services/util_service.dart';

class UserService {
  late String baseUrl;

  UserService() {
    baseUrl = dotenv.get('BASE_API_URL',
        fallback: 'https://sandbox.api.lettutor.com');
  }

  Future<Map<String, dynamic>> getCurrentInfo() async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(Uri.parse('$baseUrl/user/info'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Register successful',
        'data': jsonDecode(response.body)?['user']
      };
    } else {
      return {'success': false, 'message': 'Get current user failed'};
    }
  }

  Future<Map<String, dynamic>> getTotalMinutes() async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.get(Uri.parse('$baseUrl/call/total'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Update profile successful',
        'data': jsonDecode(response.body)
      };
    } else {
      return {'success': false, 'message': 'Update profile failed'};
    }
  }

  Future<Map<String, dynamic>> getAllRecipient() async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http
        .get(Uri.parse('$baseUrl/message/get-all-recipient'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Update profile successful',
        'data': jsonDecode(response.body)['messages']
      };
    } else {
      return {'success': false, 'message': 'Update profile failed'};
    }
  }

  Future<Map<String, dynamic>> getMessageById({
    id,
    currentPage = 1,
    perPage = 20,
  }) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    var url = '$baseUrl/message/get/$id';
    if (currentPage != null && perPage != null) {
      url +=
          '?page=$currentPage&perPage=$perPage&startTime=${DateTime.now().millisecondsSinceEpoch}';
    }
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Update profile successful',
        'data': jsonDecode(response.body)
      };
    } else {
      return {'success': false, 'message': 'Update profile failed'};
    }
  }

  Future<Map<String, dynamic>> updateProfile({name, phone}) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.put(Uri.parse('$baseUrl/user/info'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokens['access_token']}'
        },
        body: jsonEncode({'name': name, 'phone': phone}));

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Update profile successful',
        'data': jsonDecode(response.body)["user"]
      };
    } else {
      return {'success': false, 'message': 'Update profile failed'};
    }
  }


  Future<Map<String, dynamic>> updateAvatar(avatar) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/user/uploadAvatar'),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${tokens['access_token']}'
    });
    request.files.add(await http.MultipartFile.fromPath('avatar', avatar.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Update avatar successful',
        'data': jsonDecode(await response.stream.bytesToString())
      };
    } else {
      return {'success': false, 'message': 'Update avatar failed'};
    }
  }
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_20120598/src/services/util_service.dart';

class BookingService {
  late String baseUrl;

  BookingService() {
    baseUrl = dotenv.get('BASE_API_URL',
        fallback: 'https://sandbox.api.lettutor.com');
  }

  Future<Map<String, dynamic>> book(
      List<String> scheduleDetailIds, String note) async {
    final tokens = await UtilService.getTokens();
    if (tokens['access_token'] == null) {
      return {'success': false, 'message': 'Access token not found'};
    }
    final response = await http.post(Uri.parse('$baseUrl/booking'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokens['access_token']}'
        },
        body:
            jsonEncode({'scheduleDetailIds': scheduleDetailIds, 'note': note}));

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Register successful',
        'data': jsonDecode(response.body)?['data']
      };
    } else {
      return {'success': false, 'message': 'Toggle favorite failed'};
    }
  }
}

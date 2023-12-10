import 'package:shared_preferences/shared_preferences.dart';

class UtilService {
  static Future<Map<String, dynamic>> getTokens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'access_token': prefs.getString('access_token'),
      'refresh_token': prefs.getString('refresh_token')
    };
  }
}

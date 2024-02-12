import 'dart:convert';
import 'package:frontend/config/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> login(String userName, String password) async {
    try {
      final url = Uri.parse('${AppConfig.baseUrl}/auth/login');
      final response = await http.post(
        url,
        body: json.encode({'username': userName, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['token'];

        await saveToken(token);
        return token;
      } else {
        throw Exception('Error de inicio de sesión');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}

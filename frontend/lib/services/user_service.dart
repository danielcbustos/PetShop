import 'dart:convert';
import 'package:frontend/config/app_config.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<User> register(
    String username,
    String password,
    String firstName,
    String lastName,
    String email,
  ) async {
    try {
      // Construir el cuerpo de la solicitud de registro
      final Map<String, dynamic> requestData = {
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };

      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        User user = User.fromJson(responseData);
        return user;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}

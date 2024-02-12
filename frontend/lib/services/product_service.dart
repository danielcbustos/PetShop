import 'dart:convert';

import 'package:frontend/config/app_config.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:http/http.dart' as http;

final AuthService authService = AuthService();

class ProductService {
  Future<List> getProducts() async {
    try {
      final token = await authService.getToken();
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/product/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        List<Product> products =
            decodedData.map((json) => Product.fromJson(json)).toList();
        return products;
      } else {
        throw Exception(
            'Error al cargar los productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}

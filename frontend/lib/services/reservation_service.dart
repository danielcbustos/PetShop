import 'dart:convert';

import 'package:frontend/config/app_config.dart';
import 'package:frontend/models/reservation_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:http/http.dart' as http;

final AuthService authService = AuthService();

class ReservationService {
  Future<List> getReservation() async {
    try {
      final token = await authService.getToken();
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/reservation/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        List<Reservation> reservations =
            decodedData.map((json) => Reservation.fromJson(json)).toList();
        return reservations;
      } else {
        throw Exception(
            'Error al cargar los productos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> deleteReservation(int id) async {
    try {
      final token = await authService.getToken();
      final response = await http.delete(
        Uri.parse('${AppConfig.baseUrl}/reservation/cancel/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Error al cancelar la reserva');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<Reservation> createReservation(
      DateTime dateTime, String description) async {
    try {
      final token = await authService.getToken();
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/reservation/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'reservationDate': dateTime.toIso8601String(),
          'description': description,
        }),
      );
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Reservation reservation = Reservation.fromJson(responseData);
        return reservation;
      } else {
        throw Exception('${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}

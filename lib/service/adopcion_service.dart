import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Importa tus modelos existentes
import 'package:veterinaria/model/report.dart';
import 'package:veterinaria/model/request.dart';

class AdopcionesService {
  final String _baseUrl =
      'https://10.0.2.2:5260/api/Adopciones'; // Cambia al URL real

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // si tu API usa token
  }

  Map<String, String> _headers([String? token]) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  // ===================== PROCESAR ADOPCION =====================
  Future<String?> procesarAdopcion(AdopcionRequest request) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$_baseUrl/procesar-adopcion'),
      headers: _headers(token),
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'] ?? 'Adopción procesada exitosamente';
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data['error'] ?? 'Error procesando adopción');
    }
  }

  // ===================== OPORTUNIDADES =====================
  Future<List<OportunidadAdopcion>> getOportunidades() async {
    final token = await _getToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/oportunidades-match'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map(
            (json) =>
                OportunidadAdopcion.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw Exception('Error al obtener oportunidades de adopción');
    }
  }
}

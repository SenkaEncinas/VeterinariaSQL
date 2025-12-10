import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReportesService {
  final String _baseUrl = 'https://tu-api.com/api/Reportes';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Map<String, String> _headers([String? token]) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  Future<List<Map<String, dynamic>>> getEstadoCuentas() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/finanzas-rescatados'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Error al obtener estado de cuentas');
    }
  }

  Future<List<Map<String, dynamic>>> getAuditoriaAlertas() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/auditoria-alertas'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Error al obtener auditoría');
    }
  }

  Future<List<Map<String, dynamic>>> getSeguimientoVisitas() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/seguimiento-visitas'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Error al obtener seguimiento de visitas');
    }
  }
}

// lib/service/reportes_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veterinaria/model/report.dart'; // 👈 ajusta ruta si es distinta

class ReportesService {
  final String _baseUrl = 'http://localhost:5260  /api/Reportes';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  } 

  Map<String, String> _headers([String? token]) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  // =============== ESTADO CUENTAS RESCATADOS =================
  Future<List<EstadoCuentaRescatado>> getEstadoCuentas() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/finanzas-rescatados'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => EstadoCuentaRescatado.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Error al obtener estado de cuentas');
    }
  }

  // =============== AUDITORÍA ALERTAS =================
  Future<List<ReporteAuditoria>> getAuditoriaAlertas() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/auditoria-alertas'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => ReporteAuditoria.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Error al obtener auditoría');
    }
  }

  // =============== SEGUIMIENTO VISITAS =================
  Future<List<SeguimientoVisita>> getSeguimientoVisitas() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/seguimiento-visitas'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => SeguimientoVisita.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Error al obtener seguimiento de visitas');
    }
  }

  // =============== OPORTUNIDADES ADOPCIÓN (si tienes endpoint) =================
  Future<List<OportunidadAdopcion>> getOportunidadesAdopcion() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/oportunidades-adopcion'),
      headers: _headers(token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => OportunidadAdopcion.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Error al obtener oportunidades de adopción');
    }
  }
}

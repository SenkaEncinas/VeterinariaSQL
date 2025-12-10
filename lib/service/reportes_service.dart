import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veterinaria/model/report.dart';

class ReportesService {
  // OJO: quité el doble espacio, y dejé la URL limpia.
  // Si usas emulador Android, podrías necesitar: http://10.0.2.2:5260/api/Reportes
  final String _baseUrl = 'http://localhost:5260/api/Reportes';

  // ================== TOKEN & HEADERS ==================

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Map<String, String> _headers([String? token]) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // =============== ESTADO CUENTAS RESCATADOS =================
  // GET api/Reportes/finanzas-rescatados
  Future<List<EstadoCuentaRescatado>> getEstadoCuentas() async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/finanzas-rescatados');

    final response = await http.get(url, headers: _headers(token));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map(
            (e) => EstadoCuentaRescatado.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw Exception(
        'Error al obtener estado de cuentas (${response.statusCode})',
      );
    }
  }

  // =============== AUDITORÍA ALERTAS =================
  // GET api/Reportes/auditoria-alertas
  Future<List<ReporteAuditoria>> getAuditoriaAlertas() async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/auditoria-alertas');

    final response = await http.get(url, headers: _headers(token));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map(
            (e) => ReporteAuditoria.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw Exception(
        'Error al obtener auditoría (${response.statusCode})',
      );
    }
  }

  // =============== SEGUIMIENTO VISITAS =================
  // GET api/Reportes/seguimiento-visitas
  Future<List<SeguimientoVisita>> getSeguimientoVisitas() async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/seguimiento-visitas');

    final response = await http.get(url, headers: _headers(token));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map(
            (e) => SeguimientoVisita.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw Exception(
        'Error al obtener seguimiento de visitas (${response.statusCode})',
      );
    }
  }

  // =============== PAGOS / BONIFICACIONES VETERINARIOS =================
  // GET api/Reportes/pagos-bonificaciones
  //
  // IMPORTANTE:
  // Aquí asumo que tienes un modelo en report.dart, algo tipo:
  //
  // class BonoVeterinario {
  //   final String veterinario;
  //   final double monto;
  //   ...
  //   BonoVeterinario(...);
  //   factory BonoVeterinario.fromJson(Map<String, dynamic> json) => ...
  // }
  //
  // Cambia "BonoVeterinario" por el nombre real que uses.
  Future<List<BonoVeterinario>> getPagosBonificaciones() async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/pagos-bonificaciones');

    final response = await http.get(url, headers: _headers(token));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map(
            (e) => BonoVeterinario.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw Exception(
        'Error al obtener pagos de bonificaciones (${response.statusCode})',
      );
    }
  }

  // =============== OPORTUNIDADES ADOPCIÓN (solo si tienes endpoint) =================
  //
  // Si más adelante creas un endpoint:
  //   GET api/Reportes/oportunidades-adopcion
  // en tu backend, este método ya está listo para usar con tu modelo
  // OportunidadAdopcion que ya definiste.
  //
  // Si NO vas a usar este reporte, puedes borrar este método sin problemas.
  Future<List<OportunidadAdopcion>> getOportunidadesAdopcion() async {
    final token = await _getToken();
    final url = Uri.parse('$_baseUrl/oportunidades-adopcion');

    final response = await http.get(url, headers: _headers(token));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map(
            (e) => OportunidadAdopcion.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw Exception(
        'Error al obtener oportunidades de adopción (${response.statusCode})',
      );
    }
  }
}

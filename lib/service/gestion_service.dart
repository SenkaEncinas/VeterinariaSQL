import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Importa tus modelos existentes
import 'package:veterinaria/model/request.dart';

class GestionService {
  final String _baseUrl =
      'https://tu-api.com/api/Gestion'; // Cambia al URL real

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Map<String, String> _headers([String? token]) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) headers['Authorization'] = 'Bearer $token';
    return headers;
  }

  // ===================== MASCOTA CLIENTE =====================
  Future<String?> registrarMascotaCliente(MascotaClienteRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/mascota-cliente'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando mascota cliente');
    }
  }

  // ===================== MASCOTA RESCATADA =====================
  Future<String?> registrarRescatado(MascotaRescatadaRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/mascota-rescatada'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando mascota rescatada');
    }
  }

  // ===================== CONSULTA MEDICA =====================
  Future<String?> registrarConsulta(ConsultaMedicaRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/consulta-medica'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando consulta médica');
    }
  }

  // ===================== POSTULANTE =====================
  Future<String?> registrarPostulante(PostulanteRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/postulante'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando postulante');
    }
  }

  // ===================== APORTE MECENAS =====================
  Future<String?> registrarAporte(AporteRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/aporte-mecenas'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando aporte');
    }
  }

  // ===================== CONSUMO REFUGIO =====================
  Future<String?> registrarConsumo(ConsumoRefugioRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/consumo-refugio'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando consumo');
    }
  }

  // ===================== VACUNACION =====================
  Future<String?> registrarVacuna(VacunaRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/vacunacion'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando vacunación');
    }
  }

  // ===================== CLIENTE FAMILIA =====================
  Future<String?> registrarFamilia(ClienteFamiliaRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/cliente-familia'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error registrando familia');
    }
  }

  // ===================== INTEGRANTE FAMILIA =====================
  Future<String?> agregarIntegrante(IntegranteRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/integrante-familia'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error agregando integrante a la familia');
    }
  }

  // ===================== ACTUALIZAR PESO =====================
  Future<String?> actualizarPeso(PesoRequest req) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/actualizar-peso'),
      headers: _headers(token),
      body: jsonEncode(req.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['mensaje'];
    } else {
      throw Exception('Error actualizando peso');
    }
  }
}

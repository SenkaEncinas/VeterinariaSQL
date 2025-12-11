import 'package:flutter/material.dart';
import 'package:veterinaria/service/reportes_service.dart';
import 'package:veterinaria/model/report.dart'; // donde está SeguimientoVisita

class SeguimientoVisitasScreen extends StatefulWidget {
  const SeguimientoVisitasScreen({super.key});

  @override
  State<SeguimientoVisitasScreen> createState() =>
      _SeguimientoVisitasScreenState();
}

class _SeguimientoVisitasScreenState extends State<SeguimientoVisitasScreen> {
  final _service = ReportesService();
  bool loading = false;

  List<SeguimientoVisita> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    try {
      final data = await _service.getSeguimientoVisitas();
      setState(() => items = data);
    } catch (e) {
      _showMessage(e.toString());
    }
    setState(() => loading = false);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget _buildList() {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "No hay datos para mostrar.",
          textAlign: TextAlign.center,
        ),
      );
    }

    // TODO texto plano, sin colores ni chips ni tarjetas estilizadas
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((visita) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            // Cada registro como un bloque de texto
            'ID Adopción: ${visita.idAdopcion}\n'
            'Mascota: ${visita.mascota}\n'
            'Familia adoptante: ${visita.familiaAdoptante}\n'
            'Fecha visita: ${visita.fechaVisita}\n'
            'Quien visitó: ${visita.quienVisito}\n'
            'Resultado: ${visita.resultado}\n'
            'Estado visita: ${visita.estadoVisita}\n',
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fondo normal
      appBar: AppBar(
        title: const Text("Seguimiento de Visitas"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildList(),
            ),
    );
  }
}

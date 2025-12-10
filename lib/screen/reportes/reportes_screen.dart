import 'package:flutter/material.dart';
import 'package:veterinaria/service/reportes_service.dart';

class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});

  @override
  State<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  final _service = ReportesService();
  bool loading = false;

  List<Map<String, dynamic>> estadoCuentas = [];
  List<Map<String, dynamic>> auditoriaAlertas = [];
  List<Map<String, dynamic>> seguimientoVisitas = [];

  Future<void> _getEstadoCuentas() async {
    setState(() => loading = true);
    try {
      final data = await _service.getEstadoCuentas();
      setState(() => estadoCuentas = data);
    } catch (e) {
      _showMessage(e.toString());
    }
    setState(() => loading = false);
  }

  Future<void> _getAuditoriaAlertas() async {
    setState(() => loading = true);
    try {
      final data = await _service.getAuditoriaAlertas();
      setState(() => auditoriaAlertas = data);
    } catch (e) {
      _showMessage(e.toString());
    }
    setState(() => loading = false);
  }

  Future<void> _getSeguimientoVisitas() async {
    setState(() => loading = true);
    try {
      final data = await _service.getSeguimientoVisitas();
      setState(() => seguimientoVisitas = data);
    } catch (e) {
      _showMessage(e.toString());
    }
    setState(() => loading = false);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget _buildList(String title, List<Map<String, dynamic>> items) {
    if (items.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...items.map(
          (e) => Card(
            child: ListTile(
              title: Text(e.keys.join(", ")),
              subtitle: Text(e.values.join(", ")),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reportes"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _getEstadoCuentas,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text("Estado de Cuentas Rescatados"),
                  ),
                  const SizedBox(height: 10),
                  _buildList("Estado de Cuentas", estadoCuentas),
                  ElevatedButton(
                    onPressed: _getAuditoriaAlertas,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text("Auditoría Alertas"),
                  ),
                  const SizedBox(height: 10),
                  _buildList("Auditoría Alertas", auditoriaAlertas),
                  ElevatedButton(
                    onPressed: _getSeguimientoVisitas,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text("Seguimiento Visitas"),
                  ),
                  const SizedBox(height: 10),
                  _buildList("Seguimiento Visitas", seguimientoVisitas),
                ],
              ),
            ),
    );
  }
}

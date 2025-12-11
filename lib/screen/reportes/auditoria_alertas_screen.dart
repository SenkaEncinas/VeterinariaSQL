import 'package:flutter/material.dart';
import 'package:veterinaria/service/reportes_service.dart';
import 'package:veterinaria/model/report.dart'; // Debe contener ReporteAuditoria

class AuditoriaAlertasScreen extends StatefulWidget {
  const AuditoriaAlertasScreen({super.key});

  @override
  State<AuditoriaAlertasScreen> createState() => _AuditoriaAlertasScreenState();
}

class _AuditoriaAlertasScreenState extends State<AuditoriaAlertasScreen> {
  final _service = ReportesService();
  bool loading = false;

  // Lista tipada
  List<ReporteAuditoria> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);

    try {
      // Debe devolver List<ReporteAuditoria>
      final data = await _service.getAuditoriaAlertas();
      setState(() => items = data);
    } catch (e) {
      _showMessage("Error al obtener auditoría de alertas: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF007D8F),
      ),
    );
  }

  Widget _buildList() {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            "No hay datos para mostrar.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    // Solo tarjetas con los strings tal cual
    return Column(
      children: items.map((reporte) {
        return Card(
          elevation: 4,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mascota
                Text(
                  "Mascota: ${reporte.mascota}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Gasto total (string)
                Text(
                  "Gasto total: ${reporte.gastoTotal}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),

                // Nivel de alerta (string)
                Text(
                  "Nivel de alerta: ${reporte.nivelAlerta}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Auditoría de Alertas"),
        centerTitle: true,
        backgroundColor: const Color(0xFF007D8F),
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF007D8F)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7289DA), Color(0xFF007D8F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Auditoría de Alertas",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Monitorea eventos críticos y alertas del sistema.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildList(),
                ],
              ),
            ),
    );
  }
}

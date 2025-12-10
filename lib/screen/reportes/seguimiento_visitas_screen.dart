import 'package:flutter/material.dart';
import 'package:veterinaria/service/reportes_service.dart';
import 'package:veterinaria/model/report.dart'; // 👈 ajusta la ruta si es diferente

class SeguimientoVisitasScreen extends StatefulWidget {
  const SeguimientoVisitasScreen({super.key});

  @override
  State<SeguimientoVisitasScreen> createState() =>
      _SeguimientoVisitasScreenState();
}

class _SeguimientoVisitasScreenState extends State<SeguimientoVisitasScreen> {
  final _service = ReportesService();
  bool loading = false;

  // AHORA TIPADO
  List<SeguimientoVisita> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    try {
      // 👇 Este método debe devolver List<SeguimientoVisita>
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

  String _formatFecha(DateTime fecha) {
    // Formato simple dd/MM/yyyy – cambia si quieres algo más pro
    final d = fecha.day.toString().padLeft(2, '0');
    final m = fecha.month.toString().padLeft(2, '0');
    final y = fecha.year.toString();
    return '$d/$m/$y';
  }

  Color _colorEstado(String estado) {
    switch (estado.toLowerCase()) {
      case 'completada':
      case 'completado':
        return Colors.green;
      case 'pendiente':
        return Colors.orangeAccent;
      case 'cancelada':
      case 'cancelado':
        return Colors.redAccent;
      default:
        return const Color(0xFF007D8F);
    }
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

    return Column(
      children: items.map((visita) {
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
                // Mascota y familia
                Row(
                  children: [
                    const Icon(
                      Icons.pets,
                      size: 20,
                      color: Color(0xFF007D8F),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${visita.mascota} - ${visita.familiaAdoptante}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // ID adopción + fecha
                Text(
                  "ID Adopción: ${visita.idAdopcion}",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "Fecha visita: ${_formatFecha(visita.fechaVisita)}",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),

                // Quien visitó
                Text(
                  "Quien visitó: ${visita.quienVisito}",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),

                // Resultado
                const Text(
                  "Resultado:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  visita.resultado,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),

                // Estado visita
                Row(
                  children: [
                    const Text(
                      "Estado visita: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Chip(
                      label: Text(
                        visita.estadoVisita,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: _colorEstado(visita.estadoVisita),
                    ),
                  ],
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
        title: const Text("Seguimiento de Visitas"),
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
                          Icons.track_changes,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Seguimiento de Visitas",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Consulta visitas, seguimientos y controles.",
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

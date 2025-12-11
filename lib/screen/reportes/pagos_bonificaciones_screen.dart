import 'package:flutter/material.dart';
import 'package:veterinaria/service/reportes_service.dart';
import 'package:veterinaria/model/report.dart'; // donde está BonoVeterinario

class PagosBonificacionesScreen extends StatefulWidget {
  const PagosBonificacionesScreen({super.key});

  @override
  State<PagosBonificacionesScreen> createState() =>
      _PagosBonificacionesScreenState();
}

class _PagosBonificacionesScreenState extends State<PagosBonificacionesScreen> {
  final ReportesService _service = ReportesService();
  late Future<List<BonoVeterinario>> _futureBonos;

  @override
  void initState() {
    super.initState();
    _futureBonos = _service.getPagosBonificaciones();
  }

  String _formatearMonto(double monto) {
    // Simple formateo tipo moneda, puedes cambiarlo según tu locale
    return '\$${monto.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text('Pagos y Bonificaciones'),
        centerTitle: true,
        backgroundColor: const Color(0xFF007D8F),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header superior tipo resumen
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7289DA), Color(0xFF007D8F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.payments,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Bonificaciones a Veterinarios',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Consulta los montos de bonos calculados.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Contenido dinámico
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<BonoVeterinario>>(
                future: _futureBonos,
                builder: (context, snapshot) {
                  // Cargando
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error al cargar bonificaciones:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  // Sin datos
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay bonificaciones registradas.',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  final bonos = snapshot.data!;

                  // Lista de tarjetas por veterinario/bono
                  return ListView.builder(
                    itemCount: bonos.length,
                    itemBuilder: (context, index) {
                      final bono = bonos[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF7289DA), Color(0xFF007D8F)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Nombre del veterinario
                                  Text(
                                    bono.veterinarioCompleto.isNotEmpty
                                        ? bono.veterinarioCompleto
                                        : 'Veterinario sin nombre',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                  // Atenciones bonificables
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.healing,
                                        color: Colors.white70,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Atenciones bonificables: ${bono.atencionesBonificables}',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  // Monto del bono
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Monto del bono estimado:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        _formatearMonto(
                                            bono.totalBonoEstimado),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

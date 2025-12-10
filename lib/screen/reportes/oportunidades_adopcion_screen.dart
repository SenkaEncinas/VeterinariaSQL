import 'package:flutter/material.dart';
import 'package:veterinaria/service/reportes_service.dart';
import 'package:veterinaria/model/report.dart'; // donde está OportunidadAdopcion

class OportunidadesAdopcionScreen extends StatefulWidget {
  const OportunidadesAdopcionScreen({super.key});

  @override
  State<OportunidadesAdopcionScreen> createState() =>
      _OportunidadesAdopcionScreenState();
}

class _OportunidadesAdopcionScreenState
    extends State<OportunidadesAdopcionScreen> {
  final ReportesService _service = ReportesService();
  late Future<List<OportunidadAdopcion>> _futureOportunidades;

  @override
  void initState() {
    super.initState();
    _futureOportunidades = _service.getOportunidadesAdopcion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Oportunidades de Adopción"),
        centerTitle: true,
        backgroundColor: const Color(0xFF007D8F),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<OportunidadAdopcion>>(
          future: _futureOportunidades,
          builder: (context, snapshot) {
            // Cargando
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error al cargar oportunidades:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              );
            }

            // Sin datos
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No hay oportunidades de adopción disponibles.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            final oportunidades = snapshot.data!;

            return ListView.builder(
              itemCount: oportunidades.length,
              itemBuilder: (context, index) {
                final oportunidad = oportunidades[index];

                // Campos de tu modelo
                final interesado = oportunidad.interesado;
                final loQueBusca = oportunidad.loQueBusca;
                final contacto = oportunidad.contacto;
                final mascotaDisponible = oportunidad.mascotaDisponible;
                final especie = oportunidad.especie;
                final detallesMascota = oportunidad.detallesMascota;

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
                            // Mascota disponible (o texto por defecto)
                            Text(
                              mascotaDisponible.isNotEmpty
                                  ? mascotaDisponible
                                  : 'Mascota disponible',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Especie como etiqueta pequeña
                            if (especie.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  especie,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 10),

                            // Interesado
                            Text(
                              "Interesado: ${interesado.isNotEmpty ? interesado : 'Sin nombre'}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Lo que busca
                            Text(
                              "Lo que busca: ${loQueBusca.isNotEmpty ? loQueBusca : 'No especificado'}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Detalles de la mascota
                            if (detallesMascota.isNotEmpty)
                              Text(
                                "Detalles de la mascota: $detallesMascota",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            if (detallesMascota.isNotEmpty)
                              const SizedBox(height: 8),

                            // Contacto
                            Row(
                              children: [
                                const Icon(
                                  Icons.contact_phone,
                                  color: Colors.white70,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    contacto.isNotEmpty
                                        ? contacto
                                        : 'Sin contacto',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
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
    );
  }
}

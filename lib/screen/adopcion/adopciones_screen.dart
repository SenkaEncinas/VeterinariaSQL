import 'package:flutter/material.dart';
import 'package:veterinaria/model/report.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/adopcion_service.dart';

class AdopcionesScreen extends StatefulWidget {
  const AdopcionesScreen({super.key});

  @override
  State<AdopcionesScreen> createState() => _AdopcionesScreenState();
}

class _AdopcionesScreenState extends State<AdopcionesScreen> {
  final _service = AdopcionesService();

  final idMascotaCtrl = TextEditingController();
  final idPostulanteCtrl = TextEditingController();
  final pagoCtrl = TextEditingController();

  List<OportunidadAdopcion> oportunidades = [];
  bool loading = false;

  Future<void> _procesarAdopcion() async {
    setState(() => loading = true);

    final req = AdopcionRequest(
      idMascota: int.tryParse(idMascotaCtrl.text) ?? 0,
      idPostulante: int.tryParse(idPostulanteCtrl.text) ?? 0,
      pago: double.tryParse(pagoCtrl.text) ?? 0,
    );

    try {
      final resp = await _service.procesarAdopcion(req);
      _showMessage(resp ?? "Adopción procesada exitosamente");
    } catch (e) {
      _showMessage(e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  /// 🔹 GET: obtiene las oportunidades de adopción desde el backend
  Future<void> _getOportunidades() async {
    setState(() => loading = true);
    try {
      final data = await _service.getOportunidades();
      setState(() => oportunidades = data);
    } catch (e) {
      _showMessage("Error al obtener oportunidades");
    } finally {
      setState(() => loading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: const Color(0xFF007D8F)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Gestión de Adopciones"),
        centerTitle: true,
        backgroundColor: const Color(0xFF007D8F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Vuelve al HomeScreen
          },
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF007D8F)),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================
                  // HEADER VETERINARIA
                  // ==========================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF7289DA), Color(0xFF007D8F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Gestión de Adopciones",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Administra adopciones y encuentra la pareja ideal para cada mascota.",
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.pets, size: 60, color: Colors.white70),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==========================
                  // FORM PROCESAR ADOPCIÓN
                  // ==========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Procesar Adopción",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            _styledTextField(
                              "ID Mascota",
                              idMascotaCtrl,
                              TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            _styledTextField(
                              "ID Postulante",
                              idPostulanteCtrl,
                              TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            _styledTextField(
                              "Pago",
                              pagoCtrl,
                              TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _procesarAdopcion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007D8F),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Procesar Adopción",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==========================
                  // OPORTUNIDADES DE MATCH
                  // ==========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Oportunidades de Match",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: _getOportunidades,
                      icon: const Icon(Icons.search),
                      label: const Text("Ver Oportunidades"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF99C6ED),
                        foregroundColor: const Color(0xFF23272A),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==========================
                  // LISTA DE OPORTUNIDADES
                  // ==========================
                  if (oportunidades.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "No hay oportunidades cargadas. Pulsa \"Ver Oportunidades\".",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: oportunidades.map((o) {
                          return SizedBox(
                            width: size.width / (size.width > 600 ? 2.2 : 1),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Título principal
                                    Text(
                                      "${o.interesado} busca ${o.loQueBusca}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xFF007D8F),
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Detalle de la mascota
                                    Text(
                                      "Mascota: ${o.mascotaDisponible}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Especie: ${o.especie} | Raza: ${o.raza}",
                                    ),
                                    Text(
                                      "Sexo: ${o.sexo} | Peso actual: ${o.pesoActual.toStringAsFixed(1)} kg",
                                    ),
                                    const SizedBox(height: 6),

                                    // Información de la casa del interesado
                                    if (o.suCasa.isNotEmpty)
                                      Text(
                                        "Su casa: ${o.suCasa}",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),

                                    const SizedBox(height: 6),

                                    // Detalles de la mascota
                                    if (o.detallesMascota.isNotEmpty)
                                      Text(
                                        "Detalles: ${o.detallesMascota}",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),

                                    const SizedBox(height: 8),

                                    // Contacto
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 18,
                                          color: Color(0xFF007D8F),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            o.contacto,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  Widget _styledTextField(
    String label,
    TextEditingController ctrl,
    TextInputType type,
  ) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF7289DA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF007D8F), width: 2),
        ),
      ),
    );
  }
}

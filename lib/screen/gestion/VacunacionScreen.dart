import 'package:flutter/material.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/gestion_service.dart';

class VacunacionScreen extends StatefulWidget {
  const VacunacionScreen({super.key});

  @override
  State<VacunacionScreen> createState() => _VacunacionScreenState();
}

class _VacunacionScreenState extends State<VacunacionScreen> {
  final idMascotaCtrl = TextEditingController();
  final idVacunaCtrl = TextEditingController();
  final mascotaCtrl = TextEditingController();
  final vacunaCtrl = TextEditingController();
  final fechaCtrl = TextEditingController();
  final veterinarioCtrl = TextEditingController();
  final loteCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _gestionService = GestionService();

  bool loading = false;

  Future<void> _registrarVacuna() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final request = VacunaRequest(
        idMascota: int.parse(idMascotaCtrl.text.trim()),
        idVacuna: int.parse(idVacunaCtrl.text.trim()),
        lote: loteCtrl.text.trim(),
        veterinario: veterinarioCtrl.text.trim(),
      );

      final mensaje = await _gestionService.registrarVacuna(request);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje ?? "Vacunación registrada exitosamente"),
          backgroundColor: const Color(0xFF007D8F),
        ),
      );

      // Limpiar campos
      idMascotaCtrl.clear();
      idVacunaCtrl.clear();
      mascotaCtrl.clear();
      vacunaCtrl.clear();
      fechaCtrl.clear();
      veterinarioCtrl.clear();
      loteCtrl.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  void dispose() {
    idMascotaCtrl.dispose();
    idVacunaCtrl.dispose();
    mascotaCtrl.dispose();
    vacunaCtrl.dispose();
    fechaCtrl.dispose();
    veterinarioCtrl.dispose();
    loteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Registrar Vacunación"),
        backgroundColor: const Color(0xFF007D8F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF007D8F)),
            )
          : SingleChildScrollView (
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ==========================
                  // HEADER CON ICONO
                  // ==========================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
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
                          Icons.medical_services,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Formulario de Vacunación",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Registra las vacunas aplicadas a las mascotas de manera segura.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==========================
                  // FORMULARIO
                  // ==========================
                  Card(
                    elevation: 8,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTextField(
                              "ID Mascota",
                              idMascotaCtrl,
                              icon: Icons.pets,
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese el ID de la mascota';
                                }
                                if (int.tryParse(v) == null) {
                                  return 'Debe ser un número entero';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "ID Vacuna",
                              idVacunaCtrl,
                              icon: Icons.tag,
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese el ID de la vacuna';
                                }
                                if (int.tryParse(v) == null) {
                                  return 'Debe ser un número entero';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Mascota (nombre, solo referencia visual)",
                              mascotaCtrl,
                              icon: Icons.pets,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Vacuna (nombre, solo referencia visual)",
                              vacunaCtrl,
                              icon: Icons.medical_services,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Fecha de Vacunación (opcional)",
                              fechaCtrl,
                              keyboardType: TextInputType.datetime,
                              icon: Icons.date_range,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Lote",
                              loteCtrl,
                              icon: Icons.confirmation_number,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el lote'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Veterinario",
                              veterinarioCtrl,
                              icon: Icons.person,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el veterinario'
                                  : null,
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton.icon(
                              onPressed: _registrarVacuna,
                              icon: const Icon(Icons.check),
                              label: const Text("Registrar Vacuna"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007D8F),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFF007D8F),
                              ),
                              label: const Text(
                                "Volver",
                                style: TextStyle(
                                  color: Color(0xFF007D8F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF007D8F),
                                  width: 2,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        prefixIcon:
            icon != null ? Icon(icon, color: const Color(0xFF007D8F)) : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF007D8F), width: 2),
        ),
      ),
    );
  }
}

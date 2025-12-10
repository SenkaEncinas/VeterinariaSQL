import 'package:flutter/material.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/gestion_service.dart';

class ConsultaMedicaScreen extends StatefulWidget {
  const ConsultaMedicaScreen({super.key});

  @override
  State<ConsultaMedicaScreen> createState() => _ConsultaMedicaScreenState();
}

class _ConsultaMedicaScreenState extends State<ConsultaMedicaScreen> {
  // Controllers SOLO para los campos del modelo
  final idMascotaCtrl = TextEditingController();
  final idVeterinarioCtrl = TextEditingController();
  final diagnosticoCtrl = TextEditingController();
  final tratamientoCtrl = TextEditingController();
  final temperaturaCtrl = TextEditingController();
  final costoCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _gestionService = GestionService();

  bool loading = false;
  bool esBonificable = false;

  Future<void> _registrarConsulta() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final request = ConsultaMedicaRequest(
        idMascota: int.parse(idMascotaCtrl.text.trim()),
        idVeterinario: int.parse(idVeterinarioCtrl.text.trim()),
        diagnostico: diagnosticoCtrl.text.trim(),
        tratamiento: tratamientoCtrl.text.trim(),
        temperatura: double.parse(temperaturaCtrl.text.trim()),
        costo: double.parse(costoCtrl.text.trim()),
        esBonificable: esBonificable,
      );

      final mensaje = await _gestionService.registrarConsulta(request);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(mensaje ?? 'Consulta médica registrada exitosamente'),
          backgroundColor: const Color(0xFF007D8F),
        ),
      );

      // Limpiar campos
      idMascotaCtrl.clear();
      idVeterinarioCtrl.clear();
      diagnosticoCtrl.clear();
      tratamientoCtrl.clear();
      temperaturaCtrl.clear();
      costoCtrl.clear();
      setState(() {
        esBonificable = false;
      });
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
    idVeterinarioCtrl.dispose();
    diagnosticoCtrl.dispose();
    tratamientoCtrl.dispose();
    temperaturaCtrl.dispose();
    costoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Registrar Consulta Médica"),
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
          : SingleChildScrollView(
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
                          "Formulario de Consulta Médica",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Registra la consulta médica de tus mascotas de forma rápida y segura.",
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
                              "ID Veterinario",
                              idVeterinarioCtrl,
                              icon: Icons.person,
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese el ID del veterinario';
                                }
                                if (int.tryParse(v) == null) {
                                  return 'Debe ser un número entero';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Diagnóstico",
                              diagnosticoCtrl,
                              icon: Icons.medical_information,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el diagnóstico'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Tratamiento",
                              tratamientoCtrl,
                              icon: Icons.healing,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el tratamiento'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Temperatura (°C)",
                              temperaturaCtrl,
                              icon: Icons.thermostat,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese la temperatura';
                                }
                                if (double.tryParse(v) == null) {
                                  return 'Debe ser un número válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Costo de la Consulta",
                              costoCtrl,
                              icon: Icons.payments,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese el costo';
                                }
                                if (double.tryParse(v) == null) {
                                  return 'Debe ser un número válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            SwitchListTile(
                              title: const Text(
                                "Consulta bonificable",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: esBonificable,
                              activeColor: const Color(0xFF007D8F),
                              onChanged: (val) {
                                setState(() {
                                  esBonificable = val;
                                });
                              },
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton.icon(
                              onPressed: _registrarConsulta,
                              icon: const Icon(Icons.check),
                              label: const Text("Registrar Consulta"),
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

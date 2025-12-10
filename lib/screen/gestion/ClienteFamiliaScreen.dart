// lib/screens/cliente_familia_screen.dart

import 'package:flutter/material.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/gestion_service.dart';

class ClienteFamiliaScreen extends StatefulWidget {
  const ClienteFamiliaScreen({super.key});

  @override
  State<ClienteFamiliaScreen> createState() => _ClienteFamiliaScreenState();
}

class _ClienteFamiliaScreenState extends State<ClienteFamiliaScreen> {
  // Campos de la CABEZA de familia (coincide con el modelo)
  final nombreCabezaCtrl = TextEditingController();
  final apellidoCabezaCtrl = TextEditingController();
  final dniCabezaCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final cuentaBancariaCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _gestionService = GestionService();

  bool loading = false;

  Future<void> _registrarClienteFamilia() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final request = ClienteFamiliaRequest(
        apellidoCabeza: apellidoCabezaCtrl.text.trim(),
        cuentaBancaria: cuentaBancariaCtrl.text.trim(),
        direccion: direccionCtrl.text.trim(),
        telefono: telefonoCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        dniCabeza: dniCabezaCtrl.text.trim(),
        nombreCabeza: nombreCabezaCtrl.text.trim(),
      );

      final mensaje = await _gestionService.registrarFamilia(request);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje ?? 'Cliente de familia registrado exitosamente'),
          backgroundColor: const Color(0xFF007D8F),
        ),
      );

      // Limpiar campos
      nombreCabezaCtrl.clear();
      apellidoCabezaCtrl.clear();
      dniCabezaCtrl.clear();
      telefonoCtrl.clear();
      emailCtrl.clear();
      cuentaBancariaCtrl.clear();
      direccionCtrl.clear();
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
    nombreCabezaCtrl.dispose();
    apellidoCabezaCtrl.dispose();
    dniCabezaCtrl.dispose();
    telefonoCtrl.dispose();
    emailCtrl.dispose();
    cuentaBancariaCtrl.dispose();
    direccionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Registrar Cliente de Familia"),
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
                          Icons.family_restroom,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Formulario de Cliente de Familia",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Registra los clientes familiares de manera rápida y segura.",
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
                              "Nombre cabeza de familia",
                              nombreCabezaCtrl,
                              icon: Icons.person,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el nombre'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Apellido cabeza de familia",
                              apellidoCabezaCtrl,
                              icon: Icons.person_outline,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el apellido'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "DNI cabeza de familia",
                              dniCabezaCtrl,
                              icon: Icons.badge,
                              keyboardType: TextInputType.number,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el DNI'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Teléfono contacto principal",
                              telefonoCtrl,
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el teléfono'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Email contacto principal",
                              emailCtrl,
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese el email';
                                }
                                if (!v.contains('@')) {
                                  return 'Email no válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Cuenta Bancaria",
                              cuentaBancariaCtrl,
                              icon: Icons.account_balance,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese la cuenta bancaria'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Dirección de la familia",
                              direccionCtrl,
                              icon: Icons.location_city,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese la dirección'
                                  : null,
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton.icon(
                              onPressed: _registrarClienteFamilia,
                              icon: const Icon(Icons.check),
                              label: const Text("Registrar Cliente"),
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

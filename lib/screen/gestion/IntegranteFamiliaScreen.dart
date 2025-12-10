import 'package:flutter/material.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/gestion_service.dart';

class IntegranteFamiliaScreen extends StatefulWidget {
  const IntegranteFamiliaScreen({super.key});

  @override
  State<IntegranteFamiliaScreen> createState() =>
      _IntegranteFamiliaScreenState();
}

class _IntegranteFamiliaScreenState extends State<IntegranteFamiliaScreen> {
  final idClienteCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final dniCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  final parentescoCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _gestionService = GestionService();

  bool loading = false;

  Future<void> _registrarIntegrante() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final request = IntegranteRequest(
        idCliente: int.parse(idClienteCtrl.text.trim()),
        nombreCompleto:
            '${nombreCtrl.text.trim()} ${apellidoCtrl.text.trim()}',
        dni: dniCtrl.text.trim(),
        rol: parentescoCtrl.text.trim(),
      );

      final mensaje = await _gestionService.agregarIntegrante(request);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              mensaje ?? "Integrante de familia registrado exitosamente"),
          backgroundColor: const Color(0xFF007D8F),
        ),
      );

      // Limpiar campos
      idClienteCtrl.clear();
      nombreCtrl.clear();
      apellidoCtrl.clear();
      dniCtrl.clear();
      edadCtrl.clear();
      parentescoCtrl.clear();
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
    idClienteCtrl.dispose();
    nombreCtrl.dispose();
    apellidoCtrl.dispose();
    dniCtrl.dispose();
    edadCtrl.dispose();
    parentescoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Registrar Integrante de Familia"),
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
                        Icon(Icons.group, size: 60, color: Colors.white),
                        SizedBox(height: 10),
                        Text(
                          "Formulario de Integrante de Familia",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Agrega integrantes de la familia de forma rápida y segura.",
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
                              "ID Cliente Familia",
                              idClienteCtrl,
                              icon: Icons.family_restroom,
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese el ID del cliente familia';
                                }
                                if (int.tryParse(v) == null) {
                                  return 'Debe ser un número entero';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Nombre",
                              nombreCtrl,
                              icon: Icons.person,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el nombre'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Apellido",
                              apellidoCtrl,
                              icon: Icons.person_outline,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el apellido'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "DNI",
                              dniCtrl,
                              keyboardType: TextInputType.number,
                              icon: Icons.badge,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el DNI'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Edad",
                              edadCtrl,
                              keyboardType: TextInputType.number,
                              icon: Icons.cake,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Parentesco",
                              parentescoCtrl,
                              icon: Icons.family_restroom,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el parentesco'
                                  : null,
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton.icon(
                              onPressed: _registrarIntegrante,
                              icon: const Icon(Icons.check),
                              label: const Text("Registrar Integrante"),
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

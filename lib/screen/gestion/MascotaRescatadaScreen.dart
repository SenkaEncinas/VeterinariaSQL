import 'package:flutter/material.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/gestion_service.dart';

class MascotaRescatadaScreen extends StatefulWidget {
  const MascotaRescatadaScreen({super.key});

  @override
  State<MascotaRescatadaScreen> createState() =>
      _MascotaRescatadaScreenState();
}

class _MascotaRescatadaScreenState extends State<MascotaRescatadaScreen> {
  final nombreCtrl = TextEditingController();
  final razaCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  final especieCtrl = TextEditingController();
  final lugarCtrl = TextEditingController();
  final fechaCtrl = TextEditingController();
  final pesoCtrl = TextEditingController();
  final observacionesCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _gestionService = GestionService();

  bool loading = false;
  String? sexoSeleccionado; // M / H

  Future<void> _registrarMascotaRescatada() async {
    if (!_formKey.currentState!.validate()) return;

    if (sexoSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seleccione el sexo de la mascota'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (double.tryParse(pesoCtrl.text.trim()) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Peso inválido. Debe ser un número'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final request = MascotaRescatadaRequest(
        alias: nombreCtrl.text.trim(),
        especie: especieCtrl.text.trim(),
        raza: razaCtrl.text.trim(),
        sexo: sexoSeleccionado!,
        lugarRescate: lugarCtrl.text.trim(),
        peso: double.parse(pesoCtrl.text.trim()),
        observaciones:
            'Edad aprox: ${edadCtrl.text.trim()} | Fecha rescate: ${fechaCtrl.text.trim()} | Obs: ${observacionesCtrl.text.trim()}',
      );

      final mensaje = await _gestionService.registrarRescatado(request);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(mensaje ?? "Mascota rescatada registrada exitosamente"),
          backgroundColor: const Color(0xFF007D8F),
        ),
      );

      // Limpiar campos
      nombreCtrl.clear();
      razaCtrl.clear();
      edadCtrl.clear();
      especieCtrl.clear();
      lugarCtrl.clear();
      fechaCtrl.clear();
      pesoCtrl.clear();
      observacionesCtrl.clear();
      setState(() {
        sexoSeleccionado = null;
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
    nombreCtrl.dispose();
    razaCtrl.dispose();
    edadCtrl.dispose();
    especieCtrl.dispose();
    lugarCtrl.dispose();
    fechaCtrl.dispose();
    pesoCtrl.dispose();
    observacionesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Registrar Mascota Rescatada"),
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
                        Icon(Icons.pets, size: 60, color: Colors.white),
                        SizedBox(height: 10),
                        Text(
                          "Formulario de Mascota Rescatada",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Registra los datos de las mascotas rescatadas de manera segura.",
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
                              "Nombre Mascota",
                              nombreCtrl,
                              icon: Icons.pets,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el nombre de la mascota'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Raza",
                              razaCtrl,
                              icon: Icons.tag,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese la raza'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Edad aproximada",
                              edadCtrl,
                              keyboardType: TextInputType.number,
                              icon: Icons.cake,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Especie",
                              especieCtrl,
                              icon: Icons.nature,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese la especie'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Lugar del Rescate",
                              lugarCtrl,
                              icon: Icons.location_on,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'Ingrese el lugar del rescate'
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Fecha de Rescate (opcional)",
                              fechaCtrl,
                              keyboardType: TextInputType.datetime,
                              icon: Icons.date_range,
                            ),
                            const SizedBox(height: 15),
                            _buildTextField(
                              "Peso aproximado (kg)",
                              pesoCtrl,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              icon: Icons.monitor_weight,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Ingrese el peso aproximado';
                                }
                                if (double.tryParse(v) == null) {
                                  return 'Debe ser un número válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            DropdownButtonFormField<String>(
                              value: sexoSeleccionado,
                              decoration: InputDecoration(
                                labelText: "Sexo",
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.wc,
                                  color: Color(0xFF007D8F),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF007D8F),
                                    width: 2,
                                  ),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'M',
                                  child: Text('Macho'),
                                ),
                                DropdownMenuItem(
                                  value: 'H',
                                  child: Text('Hembra'),
                                ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  sexoSeleccionado = val;
                                });
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: observacionesCtrl,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: "Observaciones adicionales (opcional)",
                                filled: true,
                                fillColor: Colors.white,
                                alignLabelWithHint: true,
                                prefixIcon: const Icon(
                                  Icons.note_alt,
                                  color: Color(0xFF007D8F),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF007D8F),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton.icon(
                              onPressed: _registrarMascotaRescatada,
                              icon: const Icon(Icons.check),
                              label: const Text("Registrar Mascota"),
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

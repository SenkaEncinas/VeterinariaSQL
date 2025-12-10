import 'package:flutter/material.dart';

class ActualizarPesoScreen extends StatefulWidget {
  const ActualizarPesoScreen({super.key});

  @override
  State<ActualizarPesoScreen> createState() => _ActualizarPesoScreenState();
}

class _ActualizarPesoScreenState extends State<ActualizarPesoScreen> {
  final mascotaCtrl = TextEditingController();
  final pesoCtrl = TextEditingController();

  bool loading = false;

  void _actualizarPeso() async {
    setState(() => loading = true);

    await Future.delayed(const Duration(seconds: 1)); // Simula llamada a API

    setState(() => loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Peso de la mascota actualizado exitosamente"),
        backgroundColor: Color(0xFF007D8F),
      ),
    );

    // Limpiar campos
    mascotaCtrl.clear();
    pesoCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Actualizar Peso Mascota"),
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
                          Icons.monitor_weight,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Actualizar Peso Mascota",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Actualiza el peso de tus mascotas de manera rápida y precisa.",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildTextField(
                            "Nombre Mascota",
                            mascotaCtrl,
                            icon: Icons.pets,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            "Nuevo Peso (kg)",
                            pesoCtrl,
                            keyboardType: TextInputType.number,
                            icon: Icons.scale,
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton.icon(
                            onPressed: _actualizarPeso,
                            icon: const Icon(Icons.check),
                            label: const Text("Actualizar Peso"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007D8F),
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
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
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: icon != null
            ? Icon(icon, color: const Color(0xFF007D8F))
            : null,
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

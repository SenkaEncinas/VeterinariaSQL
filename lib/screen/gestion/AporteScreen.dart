import 'package:flutter/material.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/gestion_service.dart';

class AporteScreen extends StatefulWidget {
  const AporteScreen({super.key});

  @override
  State<AporteScreen> createState() => _AporteScreenState();
}

class _AporteScreenState extends State<AporteScreen> {
  final idMecenasCtrl = TextEditingController();
  final idMascotaCtrl = TextEditingController();
  final montoCtrl = TextEditingController();
  final metodoCtrl = TextEditingController();
  final comprobanteCtrl = TextEditingController();

  final GestionService _service = GestionService();

  bool loading = false;

  Future<void> _registrar() async {
    if (idMecenasCtrl.text.isEmpty ||
        montoCtrl.text.isEmpty ||
        metodoCtrl.text.isEmpty ||
        comprobanteCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Completa los campos obligatorios"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final req = AporteRequest(
        idMecenas: int.parse(idMecenasCtrl.text),
        idMascota: idMascotaCtrl.text.isEmpty
            ? null
            : int.tryParse(idMascotaCtrl.text),
        monto: double.parse(montoCtrl.text),
        metodoPago: metodoCtrl.text,
        comprobante: comprobanteCtrl.text,
      );

      final mensaje = await _service.registrarAporte(req);

      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje ?? "Aporte registrado"),
          backgroundColor: const Color(0xFF007D8F),
        ),
      );

      idMecenasCtrl.clear();
      idMascotaCtrl.clear();
      montoCtrl.clear();
      metodoCtrl.clear();
      comprobanteCtrl.clear();
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Registrar Aporte"),
        backgroundColor: const Color(0xFF007D8F),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF007D8F)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Header
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
                      children: const [
                        Icon(
                          Icons.volunteer_activism,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Registrar Aporte de Mecenas",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ingresa los datos del aporte realizado.",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // FORM
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          _campo(
                            "ID del Mecenas (obligatorio)",
                            idMecenasCtrl,
                            Icons.person,
                            tipo: TextInputType.number,
                          ),
                          const SizedBox(height: 15),

                          _campo(
                            "ID de Mascota (opcional)",
                            idMascotaCtrl,
                            Icons.pets,
                            tipo: TextInputType.number,
                          ),
                          const SizedBox(height: 15),

                          _campo(
                            "Monto",
                            montoCtrl,
                            Icons.monetization_on,
                            tipo: TextInputType.number,
                          ),
                          const SizedBox(height: 15),

                          _campo("Método de Pago", metodoCtrl, Icons.payment),
                          const SizedBox(height: 15),

                          _campo(
                            "Comprobante (URL / código)",
                            comprobanteCtrl,
                            Icons.receipt_long,
                          ),
                          const SizedBox(height: 25),

                          ElevatedButton.icon(
                            onPressed: _registrar,
                            icon: const Icon(Icons.check),
                            label: const Text("Registrar Aporte"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007D8F),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
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

  Widget _campo(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType tipo = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: const Color(0xFF007D8F)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF007D8F), width: 2),
        ),
      ),
    );
  }
}

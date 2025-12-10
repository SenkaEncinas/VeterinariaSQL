import 'package:flutter/material.dart';
import 'package:veterinaria/model/request.dart';
import 'package:veterinaria/service/gestion_service.dart';

class ActualizarPesoScreen extends StatefulWidget {
  const ActualizarPesoScreen({super.key});

  @override
  State<ActualizarPesoScreen> createState() => _ActualizarPesoScreenState();
}

class _ActualizarPesoScreenState extends State<ActualizarPesoScreen> {
  final idMascotaCtrl = TextEditingController();
  final pesoCtrl = TextEditingController();
  String? estadoSeleccionado;

  bool loading = false;

  final List<String> estadosNutricionales = [
    "Bajo Peso",
    "Normal",
    "Sobrepeso",
    "Obeso",
  ];

  @override
  void dispose() {
    idMascotaCtrl.dispose();
    pesoCtrl.dispose();
    super.dispose();
  }

  Future<void> _actualizarPeso() async {
    // Validaciones básicas
    if (idMascotaCtrl.text.trim().isEmpty ||
        pesoCtrl.text.trim().isEmpty ||
        estadoSeleccionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Completa todos los campos"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final int? idMascota = int.tryParse(idMascotaCtrl.text.trim());
    final double? nuevoPeso = double.tryParse(pesoCtrl.text.trim());

    if (idMascota == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ID de mascota inválido"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (nuevoPeso == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Peso inválido"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    final request = PesoRequest(
      idMascota: idMascota,
      nuevoPeso: nuevoPeso,
      estadoNutricional: estadoSeleccionado!,
    );

    try {
      // Llamada real al service (ajusta import/ruta si tu service está en otra parte)
      final resultado = await GestionService().actualizarPeso(request);

      // Si tu servicio devuelve null o mensaje, lo manejamos aquí:
      final mensaje = resultado ?? "Peso actualizado correctamente";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: const Color(0xFF007D8F),
        ),
      );

      // Limpiar campos
      setState(() {
        idMascotaCtrl.clear();
        pesoCtrl.clear();
        estadoSeleccionado = null;
      });
    } catch (e) {
      // Manejo de errores
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error actualizando peso: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
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
                  _header(),
                  const SizedBox(height: 25),
                  _formulario(),
                ],
              ),
            ),
    );
  }

  Widget _header() {
    return Container(
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
          Icon(Icons.monitor_weight, size: 60, color: Colors.white),
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
            "Registra peso y estado nutricional",
            style: TextStyle(fontSize: 14, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _formulario() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _textField(
              label: "ID Mascota",
              controller: idMascotaCtrl,
              icon: Icons.tag,
              type: TextInputType.number,
            ),
            const SizedBox(height: 15),
            _textField(
              label: "Nuevo Peso (kg)",
              controller: pesoCtrl,
              icon: Icons.scale,
              type: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 15),
            _dropdownEstado(),
            const SizedBox(height: 25),
            _botonActualizar(),
            const SizedBox(height: 15),
            _botonVolver(),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
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

  Widget _dropdownEstado() {
    return DropdownButtonFormField<String>(
      value: estadoSeleccionado,
      decoration: InputDecoration(
        labelText: "Estado Nutricional",
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.fastfood, color: Color(0xFF007D8F)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      items: estadosNutricionales.map((e) {
        return DropdownMenuItem(value: e, child: Text(e));
      }).toList(),
      onChanged: (value) {
        setState(() => estadoSeleccionado = value);
      },
    );
  }

  Widget _botonActualizar() {
    return ElevatedButton.icon(
      onPressed: loading ? null : _actualizarPeso,
      icon: const Icon(Icons.check),
      label: const Text("Actualizar Peso"),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007D8F),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _botonVolver() {
    return OutlinedButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back, color: Color(0xFF007D8F)),
      label: const Text(
        "Volver",
        style: TextStyle(color: Color(0xFF007D8F), fontWeight: FontWeight.bold),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF007D8F), width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

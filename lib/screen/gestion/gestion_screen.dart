import 'package:flutter/material.dart';
import 'MascotaClienteScreen.dart';
// Aquí importas los otros screens cuando los crees
import 'MascotaRescatadaScreen.dart';
import 'ConsultaMedicaScreen.dart';
import 'PostulanteScreen.dart';
import 'AporteScreen.dart';
import 'ConsumoRefugioScreen.dart';
import 'VacunacionScreen.dart';
import 'ClienteFamiliaScreen.dart';
import 'IntegranteFamiliaScreen.dart';
import 'ActualizarPesoScreen.dart';

class GestionScreen extends StatelessWidget {
  const GestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      _GestionOption(
        title: "Registrar Mascota Cliente",
        icon: Icons.pets,
        page: const MascotaClienteScreen(),
      ),
      _GestionOption(
        title: "Registrar Mascota Rescatada",
        icon: Icons.pets_outlined,
        page: const MascotaRescatadaScreen(),
      ),
      _GestionOption(
        title: "Registrar Consulta Médica",
        icon: Icons.medical_services,
        page: const ConsultaMedicaScreen(),
      ),
      _GestionOption(
        title: "Registrar Postulante",
        icon: Icons.person_add,
        page: const PostulanteScreen(),
      ),
      _GestionOption(
        title: "Registrar Aporte Mecenas",
        icon: Icons.volunteer_activism,
        page: const AporteScreen(),
      ),
      _GestionOption(
        title: "Registrar Consumo Refugio",
        icon: Icons.local_drink,
        page: const ConsumoRefugioScreen(),
      ),
      _GestionOption(
        title: "Registrar Vacunación",
        icon: Icons.vaccines,
        page: const VacunacionScreen(),
      ),
      _GestionOption(
        title: "Registrar Familia",
        icon: Icons.family_restroom,
        page: const ClienteFamiliaScreen(),
      ),
      _GestionOption(
        title: "Agregar Integrante de Familia",
        icon: Icons.group_add,
        page: const IntegranteFamiliaScreen(),
      ),
      _GestionOption(
        title: "Actualizar Peso Mascota",
        icon: Icons.monitor_weight,
        page: const ActualizarPesoScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Gestión Administrativa"),
        centerTitle: true,
        backgroundColor: const Color(0xFF007D8F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Volver al Home
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: options.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 3.5,
          ),
          itemBuilder: (context, index) {
            final option = options[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => option.page),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: Colors.black26,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7289DA), Color(0xFF007D8F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(option.icon, color: Colors.white, size: 28),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            option.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GestionOption {
  final String title;
  final IconData icon;
  final Widget page;
  _GestionOption({required this.title, required this.icon, required this.page});
}

import 'package:flutter/material.dart';
import 'package:veterinaria/screen/adopcion/adopciones_screen.dart';
import 'package:veterinaria/screen/gestion/gestion_screen.dart';
import 'package:veterinaria/screen/reportes/reportes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // blanco
      appBar: AppBar(
        title: const Text(
          '🐾 Cesarin y sus amigos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xFF7289DA), // azul principal
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Hero / Banner
          Container(
            width: double.infinity,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7289DA), Color(0xFF99C6ED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Bienvenido, Usuario',
                style: TextStyle(
                  color: const Color(0xFFFFFFFF),
                  fontSize: isTablet ? 30 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                crossAxisCount: isTablet ? 2 : 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 3,
                children: [
                  _veterinaryCard(context, 'Adopciones', Icons.pets, [
                    Color(0xFF007D8F),
                    Color(0xFF7289DA),
                  ], const AdopcionesScreen()),
                  _veterinaryCard(context, 'Gestión', Icons.medical_services, [
                    Color(0xFF99C6ED),
                    Color(0xFF007D8F),
                  ], const GestionScreen()),
                  _veterinaryCard(context, 'Reportes', Icons.bar_chart, [
                    Color(0xFF7289DA),
                    Color(0xFF007D8F),
                  ], const ReportesScreen()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _veterinaryCard(
    BuildContext context,
    String title,
    IconData icon,
    List<Color> colors,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            leading: Icon(icon, size: 50, color: const Color(0xFFFFFFFF)),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

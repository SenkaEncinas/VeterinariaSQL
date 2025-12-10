import 'package:flutter/material.dart';
import 'package:veterinaria/service/reportes_service.dart';
import 'package:veterinaria/model/report.dart'; // 👈 ajusta ruta si es diferente

class EstadoCuentasScreen extends StatefulWidget {
  const EstadoCuentasScreen({super.key});

  @override
  State<EstadoCuentasScreen> createState() => _EstadoCuentasScreenState();
}

class _EstadoCuentasScreenState extends State<EstadoCuentasScreen> {
  final _service = ReportesService();
  bool loading = false;

  // AHORA LISTA TIPADA
  List<EstadoCuentaRescatado> items = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    try {
      // 👇 Este método debe devolver List<EstadoCuentaRescatado>
      final data = await _service.getEstadoCuentas();
      setState(() => items = data);
    } catch (e) {
      _showMessage(e.toString());
    }
    setState(() => loading = false);
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Color _colorSaldo(double saldo) {
    if (saldo > 0) return Colors.redAccent;
    if (saldo < 0) return Colors.green;
    return const Color(0xFF007D8F);
  }

  Widget _buildList() {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text(
          "No hay datos para mostrar.",
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: items.map((estado) {
        return Card(
          elevation: 4,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Alias / ID
                Row(
                  children: [
                    const Icon(
                      Icons.pets,
                      size: 20,
                      color: Color(0xFF007D8F),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${estado.alias} (ID: ${estado.idMascota})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Estado adopción
                Row(
                  children: [
                    const Text(
                      "Estado adopción: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      estado.estadoAdopcion,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Gastos
                Text(
                  "Gastos médicos: \$${estado.totalGastosMedicos.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "Gastos refugio: \$${estado.totalGastosRefugio.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "Total donaciones: \$${estado.totalDonaciones.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),

                // Saldo pendiente
                Row(
                  children: [
                    const Text(
                      "Saldo pendiente: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${estado.saldoPendientePorCubrir.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _colorSaldo(estado.saldoPendientePorCubrir),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F2),
      appBar: AppBar(
        title: const Text("Estado de Cuentas"),
        centerTitle: true,
        backgroundColor: const Color(0xFF007D8F),
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF007D8F)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
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
                          Icons.account_balance_wallet,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Estado de Cuentas de Rescatados",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Revisa el detalle de aportes, gastos y saldos.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildList(),
                ],
              ),
            ),
    );
  }
}

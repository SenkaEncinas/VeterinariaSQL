// models_reportes.dart

/// Modelo para VW_OPORTUNIDADES_ADOPCION
class OportunidadAdopcion {
  final String interesado;        // Interesado
  final String loQueBusca;        // Lo_Que_Busca
  final String suCasa;            // Su_Casa
  final String contacto;          // Contacto
  final String mascotaDisponible; // Mascota_Disponible
  final String especie;           // especie
  final String raza;              // raza
  final String sexo;              // sexo
  final double pesoActual;        // peso_actual (DECIMAL en SQL)
  final String detallesMascota;   // Detalles_Mascota

  OportunidadAdopcion({
    required this.interesado,
    required this.loQueBusca,
    required this.suCasa,
    required this.contacto,
    required this.mascotaDisponible,
    required this.especie,
    required this.raza,
    required this.sexo,
    required this.pesoActual,
    required this.detallesMascota,
  });

  factory OportunidadAdopcion.fromJson(Map<String, dynamic> json) {
    return OportunidadAdopcion(
      interesado: json['Interesado'] ?? '',
      loQueBusca: json['Lo_Que_Busca'] ?? '',
      suCasa: json['Su_Casa'] ?? '',
      contacto: json['Contacto'] ?? '',
      mascotaDisponible: json['Mascota_Disponible'] ?? '',
      especie: json['especie'] ?? '',
      raza: json['raza'] ?? '',
      sexo: json['sexo'] ?? '',
      pesoActual: (json['peso_actual'] as num?)?.toDouble() ?? 0.0,
      detallesMascota: json['Detalles_Mascota'] ?? '',
    );
  }
}

/// Modelo para VW_ESTADO_CUENTA_RESCATADOS
class EstadoCuentaRescatado {
  final int idMascota;                  // id_mascota
  final String alias;                   // alias
  final String estadoAdopcion;          // estado_adopcion
  final double totalGastosMedicos;      // Total_Gastos_Medicos
  final double totalGastosRefugio;      // Total_Gastos_Refugio
  final double totalDonaciones;         // Total_Donaciones
  final double saldoPendientePorCubrir; // Saldo_Pendiente_Por_Cubrir

  EstadoCuentaRescatado({
    required this.idMascota,
    required this.alias,
    required this.estadoAdopcion,
    required this.totalGastosMedicos,
    required this.totalGastosRefugio,
    required this.totalDonaciones,
    required this.saldoPendientePorCubrir,
  });

  factory EstadoCuentaRescatado.fromJson(Map<String, dynamic> json) {
    return EstadoCuentaRescatado(
      idMascota: (json['id_mascota'] ?? 0) as int,
      alias: json['alias'] ?? '',
      estadoAdopcion: json['estado_adopcion'] ?? '',
      totalGastosMedicos:
          (json['Total_Gastos_Medicos'] as num?)?.toDouble() ?? 0.0,
      totalGastosRefugio:
          (json['Total_Gastos_Refugio'] as num?)?.toDouble() ?? 0.0,
      totalDonaciones:
          (json['Total_Donaciones'] as num?)?.toDouble() ?? 0.0,
      saldoPendientePorCubrir:
          (json['Saldo_Pendiente_Por_Cubrir'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Modelo para VW_SEGUIMIENTO_VISITAS
class SeguimientoVisita {
  final int idAdopcion;           // id_adopcion
  final String familiaAdoptante;  // Familia_Adoptante
  final String mascota;           // Mascota
  final DateTime fechaVisita;     // fecha_visita
  final String quienVisito;       // Quien_Visito
  final String resultado;         // Resultado
  final String estadoVisita;      // Estado_Visita

  SeguimientoVisita({
    required this.idAdopcion,
    required this.familiaAdoptante,
    required this.mascota,
    required this.fechaVisita,
    required this.quienVisito,
    required this.resultado,
    required this.estadoVisita,
  });

  factory SeguimientoVisita.fromJson(Map<String, dynamic> json) {
    return SeguimientoVisita(
      idAdopcion: (json['id_adopcion'] ?? 0) as int,
      familiaAdoptante: json['Familia_Adoptante'] ?? '',
      mascota: json['Mascota'] ?? '',
      fechaVisita:
          DateTime.tryParse(json['fecha_visita']?.toString() ?? '') ??
              DateTime(2000),
      quienVisito: json['Quien_Visito'] ?? '',
      resultado: json['Resultado'] ?? '',
      estadoVisita: json['Estado_Visita'] ?? '',
    );
  }
}

/// Modelo para VW_BONOS_VETERINARIO
class BonoVeterinario {
  final String nombre;                 // nombre
  final String apellido;               // apellido
  final int atencionesBonificables;    // atenciones_bonificables
  final double totalBonoEstimado;      // total_bono_estimado

  BonoVeterinario({
    required this.nombre,
    required this.apellido,
    required this.atencionesBonificables,
    required this.totalBonoEstimado,
  });

  factory BonoVeterinario.fromJson(Map<String, dynamic> json) {
    return BonoVeterinario(
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      atencionesBonificables:
          (json['atenciones_bonificables'] ?? 0) as int,
      totalBonoEstimado:
          (json['total_bono_estimado'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Útil para mostrar en la UI
  String get veterinarioCompleto => '$nombre $apellido';
}

/// Modelo para reporte del cursor (ReporteAuditoria)
class ReporteAuditoria {
  final String mascota;     // Mascota
  final double gastoTotal;  // Gasto_Total
  final String nivelAlerta; // Nivel_Alerta

  ReporteAuditoria({
    required this.mascota,
    required this.gastoTotal,
    required this.nivelAlerta,
  });

  factory ReporteAuditoria.fromJson(Map<String, dynamic> json) {
    return ReporteAuditoria(
      mascota: json['Mascota'] ?? '',
      gastoTotal: (json['Gasto_Total'] as num?)?.toDouble() ?? 0.0,
      nivelAlerta: json['Nivel_Alerta'] ?? '',
    );
  }
}

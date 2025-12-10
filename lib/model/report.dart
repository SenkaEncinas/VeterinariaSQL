// OportunidadAdopcion
class OportunidadAdopcion {
  final String interesado;
  final String loQueBusca;
  final String contacto;
  final String mascotaDisponible;
  final String especie;
  final String detallesMascota;

  OportunidadAdopcion({
    required this.interesado,
    required this.loQueBusca,
    required this.contacto,
    required this.mascotaDisponible,
    required this.especie,
    required this.detallesMascota,
  });

  factory OportunidadAdopcion.fromJson(Map<String, dynamic> json) {
    return OportunidadAdopcion(
      interesado: json['Interesado'] ?? '',
      loQueBusca: json['Lo_Que_Busca'] ?? '',
      contacto: json['Contacto'] ?? '',
      mascotaDisponible: json['Mascota_Disponible'] ?? '',
      especie: json['Especie'] ?? '',
      detallesMascota: json['Detalles_Mascota'] ?? '',
    );
  }
}

// EstadoCuentaRescatado
class EstadoCuentaRescatado {
  final int idMascota;
  final String alias;
  final String estadoAdopcion;
  final double totalGastosMedicos;
  final double totalGastosRefugio;
  final double totalDonaciones;
  final double saldoPendientePorCubrir;

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
      idMascota: json['Id_Mascota'] ?? 0,
      alias: json['Alias'] ?? '',
      estadoAdopcion: json['Estado_Adopcion'] ?? '',
      totalGastosMedicos: (json['Total_Gastos_Medicos'] ?? 0).toDouble(),
      totalGastosRefugio: (json['Total_Gastos_Refugio'] ?? 0).toDouble(),
      totalDonaciones: (json['Total_Donaciones'] ?? 0).toDouble(),
      saldoPendientePorCubrir: (json['Saldo_Pendiente_Por_Cubrir'] ?? 0)
          .toDouble(),
    );
  }
}

// ReporteAuditoria
class ReporteAuditoria {
  final String mascota;
  final double gastoTotal;
  final String nivelAlerta;

  ReporteAuditoria({
    required this.mascota,
    required this.gastoTotal,
    required this.nivelAlerta,
  });

  factory ReporteAuditoria.fromJson(Map<String, dynamic> json) {
    return ReporteAuditoria(
      mascota: json['Mascota'] ?? '',
      gastoTotal: (json['Gasto_Total'] ?? 0).toDouble(),
      nivelAlerta: json['Nivel_Alerta'] ?? '',
    );
  }
}

// SeguimientoVisita
class SeguimientoVisita {
  final int idAdopcion;
  final String familiaAdoptante;
  final String mascota;
  final DateTime fechaVisita;
  final String quienVisito;
  final String resultado;
  final String estadoVisita;

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
      idAdopcion: json['Id_Adopcion'] ?? 0,
      familiaAdoptante: json['Familia_Adoptante'] ?? '',
      mascota: json['Mascota'] ?? '',
      fechaVisita:
          DateTime.tryParse(json['Fecha_Visita'] ?? '') ?? DateTime(2000),
      quienVisito: json['Quien_Visito'] ?? '',
      resultado: json['Resultado'] ?? '',
      estadoVisita: json['Estado_Visita'] ?? '',
    );
  }
}

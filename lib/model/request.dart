// AdopcionRequest
class AdopcionRequest {
  final int idMascota;
  final int idPostulante;
  final double pago;

  AdopcionRequest({
    required this.idMascota,
    required this.idPostulante,
    required this.pago,
  });

  Map<String, dynamic> toJson() => {
    'IdMascota': idMascota,
    'IdPostulante': idPostulante,
    'Pago': pago,
  };
}

// MascotaClienteRequest
class MascotaClienteRequest {
  final int idCliente;
  final String alias;
  final String especie;
  final String raza;
  final String sexo;
  final DateTime fechaNacimiento;
  final double peso;
  final String color;

  MascotaClienteRequest({
    required this.idCliente,
    required this.alias,
    required this.especie,
    required this.raza,
    required this.sexo,
    required this.fechaNacimiento,
    required this.peso,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
    'IdCliente': idCliente,
    'Alias': alias,
    'Especie': especie,
    'Raza': raza,
    'Sexo': sexo,
    'FechaNacimiento': fechaNacimiento.toIso8601String(),
    'Peso': peso,
    'Color': color,
  };
}

// MascotaRescatadaRequest
class MascotaRescatadaRequest {
  final String alias;
  final String especie;
  final String raza;
  final String sexo;
  final String lugarRescate;
  final double peso;
  final String observaciones;

  MascotaRescatadaRequest({
    required this.alias,
    required this.especie,
    required this.raza,
    required this.sexo,
    required this.lugarRescate,
    required this.peso,
    required this.observaciones,
  });

  Map<String, dynamic> toJson() => {
    'Alias': alias,
    'Especie': especie,
    'Raza': raza,
    'Sexo': sexo,
    'LugarRescate': lugarRescate,
    'Peso': peso,
    'Observaciones': observaciones,
  };
}

// ConsultaMedicaRequest
class ConsultaMedicaRequest {
  final int idMascota;
  final int idVeterinario;
  final String diagnostico;
  final String tratamiento;
  final double temperatura;
  final double costo;
  final bool esBonificable;

  ConsultaMedicaRequest({
    required this.idMascota,
    required this.idVeterinario,
    required this.diagnostico,
    required this.tratamiento,
    required this.temperatura,
    required this.costo,
    required this.esBonificable,
  });

  Map<String, dynamic> toJson() => {
    'IdMascota': idMascota,
    'IdVeterinario': idVeterinario,
    'Diagnostico': diagnostico,
    'Tratamiento': tratamiento,
    'Temperatura': temperatura,
    'Costo': costo,
    'EsBonificable': esBonificable,
  };
}

// PostulanteRequest
class PostulanteRequest {
  final String nombre;
  final String dni;
  final String telefono;
  final String email;
  final String condiciones;
  final String intereses;

  PostulanteRequest({
    required this.nombre,
    required this.dni,
    required this.telefono,
    required this.email,
    required this.condiciones,
    required this.intereses,
  });

  Map<String, dynamic> toJson() => {
    'Nombre': nombre,
    'Dni': dni,
    'Telefono': telefono,
    'Email': email,
    'Condiciones': condiciones,
    'Intereses': intereses,
  };
}

// AporteRequest
class AporteRequest {
  final int idMecenas;
  final int? idMascota;
  final double monto;
  final String metodoPago;
  final String comprobante;

  AporteRequest({
    required this.idMecenas,
    this.idMascota,
    required this.monto,
    required this.metodoPago,
    required this.comprobante,
  });

  Map<String, dynamic> toJson() => {
    'IdMecenas': idMecenas,
    'IdMascota': idMascota,
    'Monto': monto,
    'MetodoPago': metodoPago,
    'Comprobante': comprobante,
  };
}

// ConsumoRefugioRequest
class ConsumoRefugioRequest {
  final int idMascota;
  final int idServicio;
  final int cantidad;
  final String observaciones;

  ConsumoRefugioRequest({
    required this.idMascota,
    required this.idServicio,
    required this.cantidad,
    required this.observaciones,
  });

  Map<String, dynamic> toJson() => {
    'IdMascota': idMascota,
    'IdServicio': idServicio,
    'Cantidad': cantidad,
    'Observaciones': observaciones,
  };
}

// VacunaRequest
class VacunaRequest {
  final int idMascota;
  final int idVacuna;
  final String lote;
  final String veterinario;

  VacunaRequest({
    required this.idMascota,
    required this.idVacuna,
    required this.lote,
    required this.veterinario,
  });

  Map<String, dynamic> toJson() => {
    'IdMascota': idMascota,
    'IdVacuna': idVacuna,
    'Lote': lote,
    'Veterinario': veterinario,
  };
}

// ClienteFamiliaRequest
class ClienteFamiliaRequest {
  final String apellidoCabeza;
  final String cuentaBancaria;
  final String direccion;
  final String telefono;
  final String email;
  final String dniCabeza;
  final String nombreCabeza;

  ClienteFamiliaRequest({
    required this.apellidoCabeza,
    required this.cuentaBancaria,
    required this.direccion,
    required this.telefono,
    required this.email,
    required this.dniCabeza,
    required this.nombreCabeza,
  });

  Map<String, dynamic> toJson() => {
    'ApellidoCabeza': apellidoCabeza,
    'CuentaBancaria': cuentaBancaria,
    'Direccion': direccion,
    'Telefono': telefono,
    'Email': email,
    'DniCabeza': dniCabeza,
    'NombreCabeza': nombreCabeza,
  };
}

// IntegranteRequest
class IntegranteRequest {
  final int idCliente;
  final String nombreCompleto;
  final String dni;
  final String rol;

  IntegranteRequest({
    required this.idCliente,
    required this.nombreCompleto,
    required this.dni,
    required this.rol,
  });

  Map<String, dynamic> toJson() => {
    'IdCliente': idCliente,
    'NombreCompleto': nombreCompleto,
    'Dni': dni,
    'Rol': rol,
  };
}

// PesoRequest
class PesoRequest {
  final int idMascota;
  final double nuevoPeso;
  final String estadoNutricional;

  PesoRequest({
    required this.idMascota,
    required this.nuevoPeso,
    required this.estadoNutricional,
  });

  Map<String, dynamic> toJson() => {
    'IdMascota': idMascota,
    'NuevoPeso': nuevoPeso,
    'EstadoNutricional': estadoNutricional,
  };
}

class Event {
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final DateTime hora;
  final bool estado;

  Event({
    this.titulo, this.descripcion, this.fecha, this.hora, this.estado=true
  });
}

class Tarefa {
  String tipo;
  String titulo;
  String periodo;
  double peso;
  double? nota;
  String? timestamp;

  Tarefa(
      {required this.tipo,
      required this.titulo,
      required this.periodo,
      required this.peso,
      this.nota,
      this.timestamp});

  // Converter JSON para o modelo
  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      tipo: json['tipo'],
      titulo: json['titulo'],
      periodo: json['periodo'],
      peso: json['peso'].toDouble(),
      nota: json['nota'],
      timestamp: json['timestamp'],
    );
  }

  // Converter o modelo para JSON
  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'titulo': titulo,
      'periodo': periodo,
      'peso': peso,
      'nota': nota,
      'timestamp': timestamp,
    };
  }
}

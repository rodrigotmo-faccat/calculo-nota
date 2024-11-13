import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa {
  String id;
  String tipo;
  String titulo;
  String periodo;
  double peso;
  double? nota;
  Timestamp? timestamp;

  Tarefa(
      {required this.id,
      required this.tipo,
      required this.titulo,
      required this.periodo,
      required this.peso,
      this.nota,
      this.timestamp});

  // Converter JSON para o modelo
  factory Tarefa.fromJson(Map<String, dynamic> json, String id) {
    return Tarefa(
      id: id,
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
      'id': id,
      'tipo': tipo,
      'titulo': titulo,
      'periodo': periodo,
      'peso': peso,
      'nota': nota,
      'timestamp': timestamp,
    };
  }
}

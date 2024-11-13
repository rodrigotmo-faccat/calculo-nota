import 'dart:convert';
import 'package:calc_nota/model/tarefa_model.dart';
import 'package:calc_nota/view/tarefa_view.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TarefaPresenter {
  final TarefaView view;
  final CollectionReference tarefasRef =
      FirebaseFirestore.instance.collection('tarefas');

  TarefaPresenter(this.view);

  // Calcular a nota final
  double calcularNotaFinal(List<Tarefa> tarefas) {
    return 0;
  }

  Future<void> fetchTarefasFirebase() async {
    try {
      QuerySnapshot snapshot =
          await tarefasRef.orderBy('timestamp', descending: true).get();

      List<Tarefa> tarefas = snapshot.docs.map((doc) {
        return Tarefa.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      view.displayTarefas(tarefas);
    } catch (e) {
      // Captura exceções e exibe a mensagem de erro.
      view.showError('Erro ao buscar dados: $e');
    }
  }

  Future<void> addTarefaFirebase(Tarefa tarefa) async {
    try {
      print("Salvando tarefa no Firestore: ${tarefa.toJson()}");
      await tarefasRef.add(tarefa.toJson());

      fetchTarefasFirebase();
    } catch (e) {
      // Captura exceções e exibe a mensagem de erro.
      view.showError('Erro ao adicionar tarefa: $e');
    }
  }

  Future<void> updateTarefa(String id, Tarefa tarefa) async {
    try {
      await tarefasRef.doc(id).update(tarefa.toJson());
    } catch (e) {
      view.showError('Erro ao atualizar tarefa: $e');
    }
  }

  Future<void> deleteTarefaFirebase(String id) async {
    try {
      await tarefasRef.doc(id).delete();

      fetchTarefasFirebase();
    } catch (e) {
      // Captura exceções e exibe a mensagem de erro.
      view.showError('Erro ao deletar tarefa: $e');
    }
  }
}

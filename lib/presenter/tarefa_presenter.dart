import 'dart:convert';
import 'package:aula11_calc/dao/tarefa_dao.dart';
import 'package:aula11_calc/model/tarefa_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../view/tarefa_view.dart';

class TarefaPresenter {
  //final TarefaDao db;
  final TarefaView view;

  TarefaPresenter(this.view);

  final String apiUrl =
      'https://back-tarefas-bfhjb9chgee4g4at.canadacentral-01.azurewebsites.net/tarefas';

  // Carregar JSON trasnformando em uma lista de tarefas
  Future<List<Tarefa>> carregarTarefas() async {
    final jsonString = await rootBundle.loadString('assets/notas.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => Tarefa.fromJson(item)).toList();
  }

  // Calcular a nota final
  double calcularNotaFinal(List<Tarefa> tarefas) {
    return 0;
  }

  // Salvar notas no banco
  /* Future<void> salvarTarefas(List<Tarefa> tarefas) async {
    for (var tarefa in tarefas) {
      tarefa.timestamp = DateTime.now().toIso8601String();
      await db.inserirTarefa(tarefa);
    }
  }

  Future<List<Tarefa>> buscarTarefaPorTitulo(String titulo) async {
    final tarefas = await db.listarTarefas();
    return tarefas
        .where((tarefa) =>
            tarefa.titulo.toLowerCase().contains(titulo.toLowerCase()))
        .toList();
  } */

  Future<void> fetchTarefas() async {
    try {
      // Faz a requisição HTTP do tipo GET para a API.
      final response = await http.get(Uri.parse(apiUrl));

      // Verifica se a resposta tem status code 200 (sucesso).
      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta JSON.
        List<dynamic> data = jsonDecode(response.body);

        // Mapeia os dados para uma lista de objetos Aluno.
        List<Tarefa> alunos =
            data.map((json) => Tarefa.fromJson(json)).toList();

        // Exibe a lista de alunos na view chamando o método displayAlunos.
        view.displayTarefas(alunos);
      } else {
        // Em caso de erro, exibe a mensagem de erro com o status code.
        view.showError('Erro ao buscar dados: ${response.statusCode}');
      }
    } catch (e) {
      // Captura exceções e exibe a mensagem de erro.
      view.showError('Erro: $e');
    }
  }

  Future<void> addTarefa(Tarefa tarefa) async {
    try {
      // Faz a requisição HTTP do tipo POST para enviar um novo aluno.
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(tarefa.toJson()),
      );

      // Verifica se a resposta tem status code 201 (Criado com sucesso).
      if (response.statusCode == 201) {
        fetchTarefas();
      } else {
        // Em caso de erro, exibe a mensagem com o status code.
        view.showError('Erro ao adicionar tarefa: ${response.statusCode}');
      }
    } catch (e) {
      // Captura exceções e exibe a mensagem de erro.
      view.showError('Erro: $e');
    }
  }

  Future<void> deleteTarefa(int position) async {
    try {
      // Faz a requisição HTTP do tipo GET para a API.
      String apiUrlPlusPosition = apiUrl + "/" + position.toString();
      final response = await http.delete(Uri.parse(apiUrlPlusPosition));

      // Verifica se a resposta tem status code 200 (sucesso).
      if (response.statusCode == 200) {
        fetchTarefas();
      } else {
        // Em caso de erro, exibe a mensagem de erro com o status code.
        view.showError('Erro ao buscar dados: ${response.statusCode}');
      }
    } catch (e) {
      // Captura exceções e exibe a mensagem de erro.
      view.showError('Erro: $e');
    }
  }
}

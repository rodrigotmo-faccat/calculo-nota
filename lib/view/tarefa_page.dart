import 'package:flutter/material.dart';
import '../model/tarefa_model.dart';
import '../presenter/tarefa_presenter.dart';
import 'tarefa_form_page.dart';
import 'tarefa_view.dart';

class TarefaPage extends StatefulWidget {
  @override
  _TarefaPageState createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> implements TarefaView {
  late TarefaPresenter presenter;

  List<Tarefa> tarefas = [];

  // Mensagem de erro que pode ser exibida na página
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    presenter = TarefaPresenter(this);
    presenter.fetchTarefas();
  }

  @override
  void displayTarefas(List<Tarefa> tarefas) {
    setState(() {
      this.tarefas = tarefas;
      errorMessage = '';
    });
  }

  // Método que exibe uma mensagem de erro se a requisição falhar
  @override
  void showError(String error) {
    setState(() {
      errorMessage = error; // Atualiza a mensagem de erro a ser exibida
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.white, // Cor de fundo branco no estilo Instagram
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            color: Colors.black, // Texto preto para contraste
            fontWeight: FontWeight.bold, // Título em negrito
            fontSize: 22, // Tamanho da fonte maior
          ),
        ),
        actions: [
          // Botão para adicionar uma nova tarefa
          IconButton(
            icon: const Icon(Icons.add,
                color: Colors.black), // Ícone preto no estilo minimalista
            onPressed: () async {
              // Abre a tela de cadastro
              bool? tarefaAdicionada = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TarefaFormPage(presenter: presenter),
                ),
              );

              if (tarefaAdicionada == true) {
                presenter.fetchTarefas();
              }
            },
          ),
        ],
      ),

      backgroundColor: Colors.white, // Fundo branco para uma estética clean
      body: errorMessage.isEmpty
          ? ListView.builder(
              itemCount: tarefas.length, // Número de itens na lista
              itemBuilder: (context, index) {
                return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 3, // Elevação para dar profundidade aos cards
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Bordas arredondadas no estilo moderno
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding:
                              EdgeInsets.all(16), // Espaçamento interno no card
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              tarefas[index].periodo,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            tarefas[index].titulo,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Peso: ${tarefas[index].peso}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await presenter.deleteTarefa(index);

                            presenter.fetchTarefas();
                          },
                        ),
                      ],
                    ));
              },
            )
          : Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
    );
  }
}

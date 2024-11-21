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
  double notaTarefa = 0;

  List<Tarefa> tarefas = [];

  // Mensagem de erro que pode ser exibida na página
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    presenter = TarefaPresenter(this);
    presenter.fetchTarefasFirebase();
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
        /* actions: [
          
        ], */
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? tarefaAdicionada = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TarefaFormPage(presenter: presenter),
            ),
          );

          if (tarefaAdicionada == true) {
            presenter.fetchTarefasFirebase();
          }
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: errorMessage.isEmpty
          ? ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(15),
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
                                'Tipo: ${tarefas[index].tipo}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.save,
                                        color: Colors.black),
                                    onPressed: () async {
                                      await presenter.updateTarefa(
                                          tarefas[index].id, notaTarefa);
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await presenter.deleteTarefaFirebase(
                                            tarefas[index].id);

                                        presenter.fetchTarefasFirebase();
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red))
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: Text(
                                'Peso: ${tarefas[index].peso}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                'Nota: ${tarefas[index].nota}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: TextField(
                                  decoration:
                                      const InputDecoration(labelText: 'Nota'),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    notaTarefa = double.tryParse(value)!;
                                  },
                                ),
                              ),
                            )
                          ],
                        )
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

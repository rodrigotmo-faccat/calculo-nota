import 'package:aula11_calc/model/tarefa_model.dart';
import 'package:aula11_calc/presenter/tarefa_presenter.dart';
import 'package:flutter/material.dart';

class BuscarView extends StatefulWidget {
  final TarefaPresenter presenter;

  BuscarView({required this.presenter});

  @override
  _BuscarViewState createState() => _BuscarViewState();
}

class _BuscarViewState extends State<BuscarView> {
  List<Tarefa> _tarefasEncontradas = [];

  @override
  void initState() {
    super.initState();
  }

  void _buscarTarefa(String titulo) async {
    final tarefas = await widget.presenter.buscarTarefaPorTitulo(titulo);
    setState(() {
      _tarefasEncontradas = tarefas;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold é a estrutura básica de layout em Flutter, que fornece o esqueleto de uma tela com suporte para barra de aplicativo, corpo, botão de ação flutuante, etc.
    return Scaffold(
      appBar: AppBar(
        // AppBar cria uma barra no topo da tela com o título "Notas dos Trabalhos"
        title: Text('Buscar tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _buscarTarefa,
              decoration: InputDecoration(labelText: 'Título da tarefa'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefasEncontradas.length,
                itemBuilder: (context, index) {
                  final tarefa = _tarefasEncontradas[index];
                  return ListTile(
                    title: Text(tarefa.titulo),
                    subtitle: Text('Nota: ${tarefa.nota}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

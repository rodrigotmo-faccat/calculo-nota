import 'package:aula11_calc/dao/tarefa_dao.dart';
import 'package:aula11_calc/presenter/tarefa_presenter.dart';
import 'package:aula11_calc/view/tarefa_view.dart';
import 'package:flutter/material.dart';
import 'package:aula11_calc/view/buscar_view.dart';

import 'view/tarefa_page.dart';

/* void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tarefaDao = TarefaDao.instance;

  final tarefaPresenter = TarefaPresenter(tarefaDao);

  runApp(MyApp(tarefaPresenter: tarefaPresenter));
} */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final TarefaPresenter tarefaPresenter;

  // Construtor que recebe o presenter de tarefas
  //MyApp({required this.tarefaPresenter});

  @override
  Widget build(BuildContext context) {
    // Define a estrutura do app com MaterialApp e a view inicial
    return MaterialApp(
      title: 'Calculadora de Notas', // Define o título do app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define o tema principal como azul
      ),
      // Define a tela inicial como TarefaView, passando o presenter
      home: TarefaPage(),
      /* routes: {
        '/buscar': (context) => BuscarView(presenter: tarefaPresenter),
      }, */
    );
  }
}

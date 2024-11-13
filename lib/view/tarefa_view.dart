import 'package:calc_nota/model/tarefa_model.dart';

abstract class TarefaView {
  void displayTarefas(List<Tarefa> tarefas);
  void showError(String error);
}

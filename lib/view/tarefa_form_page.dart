import 'package:flutter/material.dart';
import '../model/tarefa_model.dart';
import '../presenter/tarefa_presenter.dart'; // Importa o pacote de UI do Flutter.

class TarefaFormPage extends StatefulWidget {
  final TarefaPresenter
      presenter; // O presenter que gerencia a lógica do formulário.

  // Construtor da página de formulário. Recebe o presenter como argumento.
  TarefaFormPage({required this.presenter});

  @override
  _TarefaFormPageState createState() =>
      _TarefaFormPageState(); // Cria o estado da página.
}

class _TarefaFormPageState extends State<TarefaFormPage> {
  final _formKey = GlobalKey<
      FormState>(); // Chave global para identificar o formulário e validar os campos.
  final _tipoController = TextEditingController();
  final _tituloController = TextEditingController();
  //final _tituloResumidoController = TextEditingController();
  final _pesoController = TextEditingController();
  final _periodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fundo branco no estilo Instagram.
        title: const Text(
          'Cadastrar Tarefa', // Título do AppBar.
          style: TextStyle(
            color: Colors.black, // Texto preto.
            fontWeight: FontWeight.bold, // Negrito no estilo clean.
          ),
        ),
        iconTheme: const IconThemeData(
            color: Colors.black), // Ícone da seta de voltar em preto.
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Define o espaçamento interno.
        child: Form(
          key: _formKey, // Define a chave do formulário para validar.
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinha os elementos à esquerda.
            children: [
              TextFormField(
                controller: _tipoController, // Conecta o controlador ao campo.
                decoration: const InputDecoration(
                  labelText: 'Tipo', // Texto de rótulo.
                  labelStyle: TextStyle(
                    color: Colors.black, // Texto preto.
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Borda inferior cinza.
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.blueAccent), // Borda inferior azul ao focar.
                  ),
                ),
                validator: (value) {
                  // Validação do campo.
                  if (value == null || value.isEmpty) {
                    return 'Informe o tipo da tarefa'; // Mensagem de erro se o campo estiver vazio.
                  }
                  return null; // Sem erro.
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller:
                    _tituloController, // Conecta o controlador ao campo.
                decoration: const InputDecoration(
                  labelText: 'Título', // Texto de rótulo.
                  labelStyle: TextStyle(
                    color: Colors.black, // Texto preto.
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Borda inferior cinza.
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.blueAccent), // Borda inferior azul ao focar.
                  ),
                ),
                validator: (value) {
                  // Validação do campo.
                  if (value == null || value.isEmpty) {
                    return 'Informe o título da tarefa'; // Mensagem de erro se o campo estiver vazio.
                  }
                  return null; // Sem erro.
                },
              ),
              SizedBox(height: 20),
              /* TextFormField(
                controller:
                    _tituloResumidoController, // Conecta o controlador ao campo.
                decoration: const InputDecoration(
                  labelText: 'Título resumido', // Texto de rótulo.
                  labelStyle: TextStyle(
                    color: Colors.black, // Texto preto.
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Borda inferior cinza.
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.blueAccent), // Borda inferior azul ao focar.
                  ),
                ),
                validator: (value) {
                  // Validação do campo.
                  if (value == null || value.isEmpty) {
                    return 'Informe o título resumido da tarefa'; // Mensagem de erro se o campo estiver vazio.
                  }
                  return null; // Sem erro.
                },
              ),
              SizedBox(height: 20), */

              TextFormField(
                controller: _pesoController, // Conecta o controlador ao campo.
                decoration: const InputDecoration(
                  labelText: 'Peso', // Texto de rótulo.
                  labelStyle: TextStyle(
                    color: Colors.black, // Texto preto.
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Borda inferior cinza.
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.blueAccent), // Borda inferior azul ao focar.
                  ),
                ),
                keyboardType:
                    TextInputType.number, // Tipo de entrada: numérica.
                validator: (value) {
                  // Validação do campo.
                  if (value == null || value.isEmpty) {
                    return 'Informe o peso da tarefa'; // Mensagem de erro se o campo estiver vazio.
                  }
                  return null; // Sem erro.
                },
              ),
              SizedBox(height: 20), // Espaçamento vertical.

              // Campo de texto para a turma do aluno.
              TextFormField(
                controller:
                    _periodoController, // Conecta o controlador ao campo.
                decoration: const InputDecoration(
                  labelText: 'Período', // Texto de rótulo.
                  labelStyle: TextStyle(
                    color: Colors.black, // Texto preto.
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Borda inferior cinza.
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.blueAccent), // Borda inferior azul ao focar.
                  ),
                ),
                validator: (value) {
                  // Validação do campo.
                  if (value == null || value.isEmpty) {
                    return 'Informe o período da tarefa'; // Mensagem de erro se o campo estiver vazio.
                  }
                  return null; // Sem erro.
                },
              ),
              SizedBox(height: 30), // Espaçamento maior antes do botão.

              // Botão para salvar o aluno.
              SizedBox(
                width: double.infinity, // Botão com largura máxima.
                child: ElevatedButton(
                  onPressed: () {
                    // Valida o formulário quando o botão é pressionado.
                    if (_formKey.currentState!.validate()) {
                      // Se todos os campos são válidos, cria uma nova instância de Aluno.
                      Tarefa tarefa = Tarefa(
                        tipo: _tipoController.text,
                        titulo: _tituloController.text,
                        //tituloResumido: _tituloResumidoController.text,
                        peso: double.parse(_pesoController.text),
                        periodo: _periodoController.text,
                      );
                      // Chama o método addAluno do presenter para adicionar o aluno.
                      widget.presenter.addTarefa(tarefa).then((_) {
                        // Após adicionar o aluno, fecha a página e retorna true.
                        Navigator.pop(context, true);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .primaryColor, // Cor do botão igual ao tema.
                    padding: const EdgeInsets.symmetric(
                        vertical: 16), // Espaçamento interno vertical.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Borda arredondada no botão.
                    ),
                  ),
                  child: const Text(
                    'Salvar', // Texto do botão.
                    style: TextStyle(
                      color: Colors.white, // Texto branco.
                      fontSize: 18, // Tamanho maior para o texto.
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

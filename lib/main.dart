import 'package:calc_nota/firebase_options.dart';
import 'package:calc_nota/view/tarefa_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Notas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TarefaPage(),
    );
  }
}

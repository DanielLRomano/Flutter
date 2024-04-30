import 'package:exemplo_json2/View/lista_livros_view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalogo de Livros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LivrosPage(),
    );
  }
}

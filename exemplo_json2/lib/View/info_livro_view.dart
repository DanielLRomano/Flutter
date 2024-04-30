import 'package:flutter/material.dart';

class LivroInfoPage extends StatelessWidget {
  const LivroInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livro Information'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Titulo do Livro"),
            Text("Autor do Livro"),
            Text("Sinopse do Livro"),
            Text("Categoria do Livro"),
            Text("ISBN do Livro"),
          ],
        ),
      ),
    );
  }
}

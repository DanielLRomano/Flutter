// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // Importa o pacote Flutter para utilizar os widgets do Material Design
import 'package:sa3_listatarefas/Model/Usuario.dart'; // Importa o modelo de Usuário
import '../Controller/BancoDados.dart'; // Importa o controlador do banco de dados

class PaginaCadastro extends StatefulWidget {
  @override
  _PaginaCadastroState createState() => _PaginaCadastroState(); // Cria e retorna o estado da página de cadastro
}

class _PaginaCadastroState extends State<PaginaCadastro> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  TextEditingController _nomeController = TextEditingController(); // Controlador para o campo de nome
  TextEditingController _emailController = TextEditingController(); // Controlador para o campo de e-mail
  TextEditingController _senhaController = TextEditingController(); // Controlador para o campo de senha

  void cadastrarUsuario(BuildContext context) async {
    String name = _nomeController.text; // Obtém o nome digitado
    String email = _emailController.text; // Obtém o e-mail digitado
    String password = _senhaController.text; // Obtém a senha digitada

    Usuario usuario = Usuario(nome: name, email: email, senha: password, id: null); // Cria um novo objeto de Usuário

    BancoDadosCrud bancoDados = BancoDadosCrud(); // Instancia o controlador do banco de dados
    try {
      bancoDados.create(usuario); // Chama o método para criar o usuário no banco de dados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')), // Exibe um snackbar informando o sucesso do cadastro
      );
      Navigator.pop(context); // Retorna para a tela de login após o cadastro
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')), // Exibe um snackbar em caso de erro no cadastro
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Página de Cadastro")), // Barra de aplicativo com título 'Página de Cadastro'
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Associa a chave global ao formulário
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Cadastro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome'), // Configuração do campo de nome
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Por favor, insira seu nome'; // Validação para o campo de nome vazio
                    }
                    if (!RegExp(r'^[a-zA-ZÀ-ú-\s]+$').hasMatch(value!)) {
                      return 'Nome inválido'; // Validação para o formato do nome
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'E-mail'), // Configuração do campo de e-mail
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Por favor, insira seu e-mail'; // Validação para o campo de e-mail vazio
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!)) {
                      return 'E-mail inválido'; // Validação para o formato do e-mail
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: 'Senha'), // Configuração do campo de senha
                  obscureText: true,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Por favor, insira sua senha'; // Validação para o campo de senha vazio
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cadastrarUsuario(context); // Chama a função para cadastrar o usuário ao pressionar o botão
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart'; // Importa o pacote Flutter para utilizar os widgets do Material Design
import 'package:flutter/services.dart'; // Importa o pacote Flutter para acessar serviços do sistema
import '../Controller/BancoDados.dart'; // Importa o arquivo que contém a classe para operações no banco de dados
import '../Model/Usuario.dart'; // Importa o arquivo que contém a definição da classe de modelo Usuario
import 'CadastroPageView.dart'; // Importa a página de cadastro
import 'HomePageView.dart'; // Importa a página inicial do usuário após o login

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key); // Construtor da classe PaginaLogin

  @override
  State<PaginaLogin> createState() => _PaginaLoginState(); // Cria e retorna o estado da página de login
}

class _PaginaLoginState extends State<PaginaLogin> {
  final _formKey = GlobalKey<FormState>(); // Chave global para identificar o formulário
  TextEditingController _emailController = TextEditingController(); // Controlador do campo de e-mail
  TextEditingController _senhaController = TextEditingController(); // Controlador do campo de senha
  bool _loading = false; // Variável para controlar o estado de carregamento

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Retorna um Scaffold que contém a estrutura da página
      appBar: AppBar(
        title: Text("Tela de Login"), // Título da barra de aplicativo
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form( // Widget Form para encapsular o formulário
          key: _formKey, // Associa a chave global ao formulário
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (value) { // Validação do campo de e-mail
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    } else if (!isValidEmail(value)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                  ], // Impede a entrada de números no campo de e-mail
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true, // Oculta o texto digitado no campo de senha
                  validator: (value) { // Validação do campo de senha
                    if (value?.trim().isEmpty ?? true) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _loading
                    ? CircularProgressIndicator() // Exibe um indicador de progresso se estiver carregando
                    : ElevatedButton(
                        onPressed: _login, // Chama a função de login ao pressionar o botão
                        child: Text('Acessar'),
                      ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push( // Navega para a página de cadastro ao pressionar o botão
                      context,
                      MaterialPageRoute(builder: (context) => PaginaCadastro()),
                    );
                  },
                  child: Text('Não tem uma conta? Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) { // Valida o formulário antes de proceder com o login
      String email = _emailController.text;
      String senha = _senhaController.text;

      setState(() {
        _loading = true; // Define o estado de carregamento como verdadeiro
      });

      BancoDadosCrud bancoDados = BancoDadosCrud(); // Instancia a classe para operações no banco de dados
      try {
        Usuario? usuario = await bancoDados.getUsuario(email, senha); // Busca o usuário no banco de dados
        if (usuario != null) {
          Navigator.push( // Navega para a página inicial após o login bem-sucedido
            context,
            MaterialPageRoute(
              builder: (context) => PaginaHome(email: usuario.email),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar( // Exibe uma mensagem de erro se o login falhar
            content: Text('Email ou senha incorretos'),
          ));
        }
      } catch (e) {
        print('Erro durante o login: $e'); // Exibe o erro no console em caso de falha durante o login
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro durante o login. Tente novamente mais tarde.'),
        ));
      } finally {
        setState(() {
          _loading = false; // Define o estado de carregamento de volta para falso após o login
        });
      }
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email); // Valida o formato do e-mail
  }
}

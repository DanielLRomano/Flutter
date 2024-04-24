import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA3 - Correção",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: LoginPage(),
    );
  }
}
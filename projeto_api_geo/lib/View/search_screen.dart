import 'package:flutter/material.dart';
import 'package:projeto_api_geo/Controller/weather_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final WeatherController _controller = WeatherController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pesquisa por cidade'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Digite a cidade'),
                  controller: _cityController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Insira a cidade';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _findCity(_cityController.text);
                    }
                  },
                  child: const Text("Pesquisar"),
                )
              ]),
            ),
          ),
        ));
  }

  Future<void> _findCity(String city) async {
    if(await _controller.findCity(city)){
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cidade encontrada!"),
          duration: const Duration(seconds: 1),
        ),
      );
      Navigator.pushNamed(context, "/details");
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cidade não encontrada!"),
          duration: const Duration(seconds: 1),
        ),
      );
    }

  }
}

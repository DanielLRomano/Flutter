// Importa o pacote de widgets do Flutter, que contém os widgets para construir interfaces de usuário.
import 'package:flutter/material.dart';

// Importa o serviço WeatherService, que é responsável por obter os dados de previsão do tempo da API.
import 'service.dart';

// Classe StatefulWidget que representa o widget de previsão do tempo.
class WeatherScreen extends StatefulWidget {
  // Sobrescreve o método createState para criar e retornar uma instância do estado do widget.
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

// Classe que representa o estado do widget de previsão do tempo.
class _WeatherScreenState extends State<WeatherScreen> {
  // Instância do serviço WeatherService para obter os dados de previsão do tempo.
  final WeatherService _weatherService = WeatherService(
    apiKey:
        'b9ebe666087f299f5e2aad3a03d093b6', // Chave de API para acesso à API de previsão do tempo.
    baseUrl:
        'https://api.openweathermap.org/data/2.5', // URL base da API de previsão do tempo.
  );

  // Mapa que armazenará os dados de previsão do tempo.
  late Map<String, dynamic> _weatherData;

  // Controlador para o campo de texto da cidade.
  TextEditingController _cityController = TextEditingController();

  // Método chamado quando o estado é inicializado.
  @override
  void initState() {
    super.initState();
    _weatherData = new Map<String, dynamic>();
  }

  // Método assíncrono para buscar os dados de previsão do tempo para uma cidade específica.
  Future<void> _fetchWeatherData(String city) async {
    try {
      // Obtém os dados de previsão do tempo para a cidade especificada.
      final weatherData = await _weatherService.getWeather(city);
      // Atualiza o estado do widget com os novos dados de previsão do tempo.
      setState(() {
        _weatherData = weatherData;
      });
    } catch (e) {
      // Em caso de erro ao buscar os dados de previsão do tempo, exibe uma mensagem de erro no console.
      print('Error fetching weather data: $e');
    }
  }

  // Método responsável por construir a interface de usuário do widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo Weather-API'),
        // Título da barra de aplicativos.
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Digite o nome da cidade',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Chama a função para buscar os dados de previsão do tempo com o nome da cidade inserido pelo usuário.
                _fetchWeatherData(_cityController.text);
              },
              child: Text('Buscar Previsão'),
            ),
            SizedBox(height: 20),
            if (_weatherData.isNotEmpty) ...[
              Text('City: ${_weatherData['name']}'), // Exibe o nome da cidade.
              Text('Temperature: ${_weatherData['main']['temp'] - 273} °C'), // Exibe a temperatura em graus Celsius.
              Text('Description: ${_weatherData['weather'][0]['description']}'), // Exibe a descrição do clima.
            ],
          ],
        ),
      ),
    );
  }
}

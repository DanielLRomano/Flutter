import 'package:projeto_api_geo/Model/weather_model.dart';
import 'package:projeto_api_geo/Service/weather_service_api.dart';

class WeatherController {
  //atributos
  final WeatherService _service = WeatherService();
  final List<Weather> _weatherList = [];

  //getters
  List<Weather> get weatherList => _weatherList;

  //Métodos que buscar a partir da cidade
  Future<void> getWeather(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      weatherList.add(weather);
    } catch (e) {
      print(e);
    }
  }

  //Método que buscar a partir da latitude e longitude
  Future<void> getWeatherByLocation(double lat, double lon) async {
    try {
      Weather weather =
          Weather.fromJson(await _service.getWeatherByLocation(lat, lon));
      weatherList.add(weather);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> findCity(String city) async {
    try {
      Weather weather = Weather.fromJson(await _service.getWeather(city));
      weatherList.add(weather);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

import 'package:app_carros/Model.dart';

class CarroController {
  //Atributos
  List<Carro> _carrosLista = [
    ("Fiat Uno",1992,"caminho da imagem")
  ];

  //Métodos
  List<Carro> get listarCarros => _carrosLista;

  //Outros métodos
  void adicionarCarro(String modelo, int ano, String imagemUrl) {
    Carro carro = Carro(modelo, ano, imagemUrl);
    _carrosLista.add(carro);
  }
}

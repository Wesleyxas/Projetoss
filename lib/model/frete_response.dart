import 'package:correios_frete_app/model/service_map.dart';

class FreteResponse {
  final String _servico;
  final double _valor;
  final int _prazo;

  FreteResponse({
    required String servico,
    required double valor,
    required int prazo,
  })
      : _servico = servico,
        _valor = valor,
        _prazo = prazo;

  String get servico => _servico;

  double get valor => _valor;

  int get prazo => _prazo;

  factory FreteResponse.fromJson(Map<String, dynamic> json){
    return FreteResponse(
      servico: ServiceMap.mapCodigoService(json['Codigo']),
      valor: double.parse(json['Valor'].replaceAll(',', '.')),
      prazo: int.parse(json['PrazoEntrega']),

    );
  }
}

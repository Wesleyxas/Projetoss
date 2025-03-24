import 'package:correios_frete_app/model/frete_response.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

class FreteController {
  Future<List<FreteResponse>> calcularFrete(String cepOrigem,
      String cepDestino,
      String peso,
      String comprimento,
      String largura,
      String altura,) async {
    final baseUrl = 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx';
    final servicos = ['04014', '04510'];

    List<FreteResponse> resultados = [];

    for (var servico in servicos) {
      final url = Uri.parse('$baseUrl?'
          'nCdServico=$servico&'
          'sCepOrigem=$cepOrigem&'
          'sCepDestino=$cepDestino&'
          'nVlPeso=$peso&'
          'nCdFormato=1&'
          'nVlComprimento=$comprimento&'
          'nVlLargura=$largura&'
          'nVlAltura=$altura&'
          'StrRetorno=json&'
          'sCdMaoPropria=n&'
          'nVlValorDeclarado=0&'
          'sCdAvisoRecebimento=n');

      final response = await https.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final servicoData = jsonResponse['Servicos'][0];

        final frete = FreteResponse.fromJson(servicoData);
        resultados.add(frete);
      } else {
        throw Exception('Falha ao calcular o frete para $servico');
      }
    }

    return resultados;
  }
}

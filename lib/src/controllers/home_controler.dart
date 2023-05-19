import 'package:deposito/src/services/busca_descricao.dart';

class HomeControler {
  Future<String> mostrarDescicao(String ean) async {
    var response = await BuscaDesc.getDesc(ean);
    return response['descricao'];
  }
}

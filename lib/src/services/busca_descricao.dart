import 'package:http/http.dart' as http;

class BuscaDesc {
  static Future<Map> getDesc(ean) async {
    var text = <dynamic, dynamic>{};
    var url = Uri.parse(
      'https://cosmos.bluesoft.com.br/produtos/${ean.toString()}',
    );
    var response = await http.get(url);
    // cria a lista com a respostas separada por "<"
    var list = response.body.split('<');
    //retorn com a descricao
    String? desc;
    for (var t in list) {
      if (t.contains('product_description')) {
        var separacao = t.split('>');
        desc = separacao[1];
        break;
      }
    }
    text['descricao'] = desc.toString();
    return text;
  }
}

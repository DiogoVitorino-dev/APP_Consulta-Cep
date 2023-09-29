import 'package:consulta_cep/models/DatabaseCepModel.dart';
import 'package:consulta_cep/services/api/cep/CustomDioCep.dart';

class CepRepository {
  Future<CepModel> get(String cep) async {
    var dio = CustomDioCep().getInstance;

    cep.replaceAll(RegExp(r"[^0-9]"), "");

    var url = '/$cep/json';


    var response = await dio.get(url);

    var data = CepModel.fromEndpointJson(response.data);
    return data;
  }
}

import 'package:consulta_cep/models/DatabaseCepModel.dart';
import 'package:consulta_cep/repository/database/InterfaceDatabaseRepository.dart';
import 'package:consulta_cep/services/api/database/CustomDioDatabase.dart';

class DatabaseRepository implements InterfaceDatabaseRepository {
  @override
  Future<List<CepModel>> get({String? cep}) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/ceps";

    if (cep != null && cep.isNotEmpty) url += '?where={"cep":"$cep"}';

    var response = await dio.get(url);

    var data = DatabaseCepModel.fromJson(response.data);
    return data.results;
  }

  @override
  Future<void> create(CepModel cep) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/ceps";

    await dio.post(url, data: cep.toEndpointJson());
  }

  @override
  Future<void> update(CepModel cep) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/ceps/${cep.objectId}";

    await dio.put(url, data: cep.toEndpointJson());
  }

  @override
  Future<void> delete(String id) async {
    var dio = CustomDioDatabase().getInstance;
    var url = "/ceps/$id";

    await dio.delete(url);
  }
}

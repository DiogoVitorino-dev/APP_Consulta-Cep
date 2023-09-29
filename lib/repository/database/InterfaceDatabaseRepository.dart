
import 'package:consulta_cep/models/DatabaseCepModel.dart';

abstract class InterfaceDatabaseRepository {
  Future<List<CepModel>> get({String? cep});

  Future<void> create(CepModel cep);

  Future<void> update(CepModel cep);

  Future<void> delete(String id);
}

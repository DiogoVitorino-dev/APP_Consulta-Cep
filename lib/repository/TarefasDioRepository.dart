import 'package:bootcamp_flutter/models/TarefasResponseModel.dart';
import 'package:bootcamp_flutter/repository/TarefaRepositoryInterface.dart';
import 'package:bootcamp_flutter/services/api/CustomDioTarefas.dart';

class TarefasDioRepository implements TarefaRepositoryInterface {
  @override
  Future<List<TarefaModel>> get({bool? naoConcluido}) async {
    var dio = CustomDioTarefas().getInstance;
    var url = "/Tarefas";

    if (naoConcluido == true) url += '?where={"concluido":false}';

    var response = await dio.get(url);

    var data = TarefasResponseModel.fromJson(response.data);
    return data.results;
  }

  @override
  Future<void> create(TarefaModel tarefa) async {
    var dio = CustomDioTarefas().getInstance;
    var url = "/Tarefas";

    await dio.post(url, data: tarefa.toCreateJson());
  }

  @override
  Future<void> update(TarefaModel tarefa) async {
    var dio = CustomDioTarefas().getInstance;
    var url = "/Tarefas/${tarefa.objectId}";
    print(url);

    await dio.put(url, data: tarefa.toCreateJson());
  }

  @override
  Future<void> delete(String id) async {
    var dio = CustomDioTarefas().getInstance;
    var url = "/Tarefas/$id";

    await dio.delete(url);
  }
}

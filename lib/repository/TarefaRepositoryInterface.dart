import 'package:bootcamp_flutter/models/TarefasResponseModel.dart';

abstract class TarefaRepositoryInterface {
  Future<List<TarefaModel>> get({bool? naoConcluido});

  Future<void> create(TarefaModel tarefa);

  Future<void> update(TarefaModel tarefa);

  Future<void> delete(String id);
}

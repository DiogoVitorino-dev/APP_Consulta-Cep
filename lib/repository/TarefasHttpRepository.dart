import 'dart:convert';

import 'package:bootcamp_flutter/models/TarefasResponseModel.dart';
import 'package:bootcamp_flutter/repository/TarefaRepositoryInterface.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TarefasDioRepository implements TarefaRepositoryInterface {
  Map<String, String> _headers = {};

  TarefasDioRepository() {
    var appId = dotenv.get("APPLICATIONID");
    var apiKey = dotenv.get("APIKEY");
    
    if (appId.isEmpty || apiKey.isEmpty) {
      throw "MISSING APPLICATIONID OR APIKEY VALUE(S) AT ENVIRONMENT VARIABLES";
    }

    _headers = {
      "X-Parse-Application-Id": appId,
      "X-Parse-REST-API-Key": apiKey,
      "Content-Type": "application/json"
    };
  }

  @override
  Future<List<TarefaModel>> get({bool? naoConcluido}) async {
    var url = "/Tarefas";

    if (naoConcluido == true) url += '?where={"concluido":false}';

    var response = await http.get(Uri.parse(url), headers: _headers);

    var data =
        TarefasResponseModel.fromJson(json.decoder.convert(response.body));
    return data.results;
  }

  @override
  Future<void> create(TarefaModel tarefa) async {
    var url = "/Tarefas";

    await http.post(Uri.parse(url), body: tarefa.toCreateJson(), headers: _headers);
  }

  @override
  Future<void> update(TarefaModel tarefa) async {
    var url = "/Tarefas/${tarefa.objectId}";

    await http.put(Uri.parse(url), body: tarefa.toCreateJson(), headers: _headers);
  }

  @override
  Future<void> delete(String id) async {
    var url = "/Tarefas/$id";

    await http.delete(Uri.parse(url), headers: _headers);
  }
}

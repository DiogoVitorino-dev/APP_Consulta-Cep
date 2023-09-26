class TarefasResponseModel {
  List<TarefaModel> results = [];

  TarefasResponseModel(this.results);

  TarefasResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <TarefaModel>[];
      json['results'].forEach((v) {
        results.add(TarefaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();

    return data;
  }
}

class TarefaModel {
  String objectId = "";
  String descricao = "";
  bool concluido = false;
  String createdAt = "";
  String updatedAt = "";

  TarefaModel(this.objectId, this.descricao, this.concluido, this.createdAt,
      this.updatedAt);

  TarefaModel.create(
    this.descricao,
    this.concluido,
  );

  TarefaModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}

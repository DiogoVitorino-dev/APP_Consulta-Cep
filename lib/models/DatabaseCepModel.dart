class DatabaseCepModel {
  List<CepModel> results = [];

  DatabaseCepModel(this.results);

  DatabaseCepModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(CepModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};    
    data['results'] = results.map((v) => v.toJson()).toList();
    
    return data;
  }
}

class CepModel {
  String objectId = "";
  late String cep;
  late String logradouro;
  late String complemento;
  late String bairro;
  late String localidade;
  late String uf;
  late String ibge;
  late String gia;
  late String ddd;
  late String siafi;
  String createdAt = "";
  String updatedAt = "";

  CepModel(
      this.objectId,
      this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi,
      this.createdAt,
      this.updatedAt);

  CepModel.create(
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
  );

  CepModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  
  CepModel.fromEndpointJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
  
  Map<String, dynamic> toEndpointJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }
}

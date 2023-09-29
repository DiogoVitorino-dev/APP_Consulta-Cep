import 'package:consulta_cep/models/DatabaseCepModel.dart';
import 'package:consulta_cep/repository/database/DatabaseRepository.dart';
import 'package:consulta_cep/shared/widgets/inputCep.dart';
import 'package:flutter/material.dart';

class CepDetailPage extends StatefulWidget {
  final CepModel cep;

  const CepDetailPage({super.key, required this.cep});

  @override
  State<CepDetailPage> createState() => _CepDetailPageState();
}

class _CepDetailPageState extends State<CepDetailPage> {
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController localidadeController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController ibgeController = TextEditingController();
  TextEditingController giaController = TextEditingController();
  TextEditingController dddController = TextEditingController();
  TextEditingController siafiController = TextEditingController();

  DatabaseRepository repository = DatabaseRepository();
  bool loading = false;

  Future<void> updateItem() async {
    setState(() {
      loading = true;
    });

    await repository.update(widget.cep);

    setState(() {
      loading = !loading;
    });
  }

  void close() async => Navigator.pop(context);

  void onPressSave() async {
    if (validateFields()) {
      await updateItem();
      close();
    }
  }

  bool validateFields() {
    if (cepController.text.isEmpty ||
        logradouroController.text.isEmpty ||
        complementoController.text.isEmpty ||
        bairroController.text.isEmpty ||
        localidadeController.text.isEmpty ||
        ufController.text.isEmpty ||
        ibgeController.text.isEmpty ||
        giaController.text.isEmpty ||
        dddController.text.isEmpty ||
        siafiController.text.isEmpty) {
      showSnackMessage("Há campo(s) vazio(s)!");
      return false;
    }
    setFields();
    return true;
  }

  void showSnackMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ScaffoldMessenger(
            child: SnackBar(
                content: Text(message), duration: const Duration(seconds: 1)));
      },
    );
  }

  @override
  void initState() {
    initFields();
    super.initState();
  }

  void initFields() {
    setState(() {
      cepController.text = widget.cep.cep;
      logradouroController.text = widget.cep.logradouro;
      complementoController.text = widget.cep.complemento;
      bairroController.text = widget.cep.bairro;
      localidadeController.text = widget.cep.localidade;
      ufController.text = widget.cep.uf;
      ibgeController.text = widget.cep.ibge;
      giaController.text = widget.cep.gia;
      dddController.text = widget.cep.ddd;
      siafiController.text = widget.cep.siafi;
    });
  }

  void setFields() {
    setState(() {
      widget.cep.cep = cepController.text;
      widget.cep.logradouro = logradouroController.text;
      widget.cep.complemento = complementoController.text;
      widget.cep.bairro = bairroController.text;
      widget.cep.localidade = localidadeController.text;
      widget.cep.uf = ufController.text;
      widget.cep.ibge = ibgeController.text;
      widget.cep.gia = giaController.text;
      widget.cep.ddd = dddController.text;
      widget.cep.siafi = siafiController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputCep(
                    width: 420,
                    label: "Cep",
                    placeholder: "01001-000",
                    maxLength: 9,
                    inputType: TextInputType.number,
                    controller: cepController),
                Row(
                  children: [
                    InputCep(
                        width: 200,
                        label: "Logradouro",
                        inputType: TextInputType.streetAddress,
                        controller: logradouroController),
                    InputCep(
                        width: 200,
                        label: "Complemento",
                        inputType: TextInputType.streetAddress,
                        controller: complementoController),
                  ],
                ),
                Row(
                  children: [
                    InputCep(
                        width: 200,
                        label: "Bairro",
                        inputType: TextInputType.streetAddress,
                        controller: bairroController),
                    InputCep(
                        width: 200,
                        inputType: TextInputType.streetAddress,
                        label: "Localidade",
                        controller: localidadeController),
                  ],
                ),
                Row(
                  children: [
                    InputCep(
                        width: 200,
                        maxLength: 2,
                        label: "Uf",
                        controller: ufController),
                    InputCep(
                        width: 200,
                        inputType: TextInputType.number,
                        label: "Ibge",
                        controller: ibgeController),
                  ],
                ),
                Row(
                  children: [
                    InputCep(
                        inputType: TextInputType.number,
                        label: "Gia",
                        width: 60,
                        controller: giaController),
                    InputCep(
                        inputType: TextInputType.number,
                        label: "Ddd",
                        width: 60,
                        controller: dddController),
                    InputCep(
                        inputType: TextInputType.number,
                        label: "Siafi",
                        width: 60,
                        controller: siafiController),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                              minimumSize:
                                  const MaterialStatePropertyAll(Size(200, 40)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red[400])),
                          onPressed: close,
                          child: const Text("Cancelar",
                              style: TextStyle(color: Colors.white))),
                      TextButton(
                          style: ButtonStyle(
                              minimumSize:
                                  const MaterialStatePropertyAll(Size(200, 40)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.teal[400])),
                          onPressed: onPressSave,
                          child: Row(
                            children: [
                              Visibility(
                                  visible: loading,
                                  child:  const Center(
                                      child: SizedBox(
                                          width: 15,
                                          height: 15,
                                          child:
                                               CircularProgressIndicator(
                                                  color: Colors.white)))),
                              const Text(" Salvar ",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

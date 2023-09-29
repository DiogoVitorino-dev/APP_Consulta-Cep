import 'package:consulta_cep/models/DatabaseCepModel.dart';
import 'package:consulta_cep/pages/cepDetailPage.dart';
import 'package:consulta_cep/repository/cep/CepRepository.dart';
import 'package:consulta_cep/repository/database/DatabaseRepository.dart';
import 'package:consulta_cep/shared/widgets/cepItem.dart';
import 'package:flutter/material.dart';

class CepPage extends StatefulWidget with WidgetsBindingObserver {
  const CepPage({super.key});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  TextEditingController cepController = TextEditingController();
  List<CepModel> list = [];
  DatabaseRepository repositoryDatabase = DatabaseRepository();
  CepRepository repositoryCep = CepRepository();
  bool loading = false;

  Future<void> getList() async {
    setState(() {
      loading = true;
    });

    list = await repositoryDatabase.get();

    setState(() {
      loading = false;
    });
  }

  Future<void> createIfNotExists(String cep) async {
    setState(() {
      loading = true;
    });

    if (cep.isEmpty) {
      await getList();
    }

    if (cep.length == 8) {
      var consult = await repositoryDatabase.get(cep: cep);

      if (consult.isEmpty) {
        var fetchCep = await repositoryCep.get(cep);
        await createItem(fetchCep);
        await getList();
      }
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> createItem(CepModel cep) async {
    await repositoryDatabase.create(cep);
    await getList();
  }

  void updateItem(CepModel cep) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CepDetailPage(cep: cep),
        ));
  }

  Future<void> deleteItem(CepModel cep) async {
    await repositoryDatabase.delete(cep.objectId);
    await getList();
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultar Cep"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,              
              children: [
                Expanded(
                  child: TextField(
                    controller: cepController,
                    maxLength: 8,
                    onSubmitted: (value) {
                      createIfNotExists(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "01001000"),
                  ),
                ),
                const SizedBox(width: 20,),
                IconButton(
                    onPressed: () async {
                      await getList();
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        var item = list[index];
                        return Dismissible(
                          key: Key(item.objectId),
                          onDismissed: (direction) async {
                            await deleteItem(item);
                          },
                          child: CepItem(
                            cep: item,
                            onPress: () {
                              updateItem(item);
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

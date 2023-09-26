import 'package:bootcamp_flutter/models/TarefasResponseModel.dart';
import 'package:bootcamp_flutter/repository/TarefasDioRepository.dart';
import 'package:bootcamp_flutter/shared/widgets/tarefaDialog.dart';
import 'package:bootcamp_flutter/shared/widgets/tarefaItem.dart';
import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  List<TarefaModel> list = [];
  TarefasDioRepository repository = TarefasDioRepository();
  bool apenasConcluido = false;
  bool loading = false;

  @override
  void initState() {
    getList();
    super.initState();
  }

  Future<void> getList() async {
    setState(() {
      loading = true;
    });

    list = await repository.get(naoConcluido: apenasConcluido);

    setState(() {
      loading = false;
    });
  }

  Future<void> createItem() async {
    showDialog(
      context: context,
      builder: (context) {
        return TarefaDialog(
            onPressOk: (tarefa) async {
              await repository.create(tarefa);
              await getList();
            },
            label: "Adicionar Tarefa");
      },
    );
  }

  Future<void> updateItem(TarefaModel tarefa) async {
    await repository.update(tarefa);
    await getList();
  }

  Future<void> updateItemDialog(TarefaModel tarefa) async {
    showDialog(
      context: context,
      builder: (context) {
        return TarefaDialog(
            tarefa: tarefa,
            onPressOk: (tarefa) async {
              await updateItem(tarefa);
            },
            label: "Atualizar Tarefa");
      },
    );
  }

  Future<void> deleteItem(TarefaModel tarefa) async {
    await repository.delete(tarefa.objectId);
    await getList();
  }

  Future<void> onChangedList(bool value) async {
    setState(() {
      apenasConcluido = value;
    });
    await getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createItem, child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Apenas não concluídos"),
                Switch(value: apenasConcluido, onChanged: onChangedList)
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
                          key: Key(item.descricao),
                          onDismissed: (direction) async {
                            await deleteItem(item);
                          },
                          child: TarefaItem(
                            tarefa: item,
                            onPress: () {
                              updateItemDialog(item);
                            },
                            onChangedSwitch: (value) async {
                              item.concluido = value;
                              await updateItem(item);
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

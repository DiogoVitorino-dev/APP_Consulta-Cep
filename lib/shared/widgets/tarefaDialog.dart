import 'package:flutter/material.dart';
import 'package:bootcamp_flutter/models/TarefasResponseModel.dart';

class TarefaDialog extends StatefulWidget {
  final TarefaModel? tarefa;
  final String label;
  final Function(TarefaModel tarefa) onPressOk;

  const TarefaDialog(
      {super.key, this.tarefa, required this.onPressOk, required this.label});

  @override
  State<TarefaDialog> createState() => _TarefaDialogState();
}

class _TarefaDialogState extends State<TarefaDialog> {
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    initFields();
    super.initState();
  }

  void initFields() {
    descController.text = widget.tarefa?.descricao ?? "";
  }

  void close() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.label),
      content: TextField(controller: descController),
      actions: [
        TextButton(
            onPressed: () async {
              var tarefa = widget.tarefa;
              if (tarefa != null) {
                tarefa.descricao = descController.text;
                await widget.onPressOk(tarefa);
              }
              await widget
                  .onPressOk(TarefaModel.create(descController.text, false));
              close();
            },
            child: const Text("Salvar")),
        TextButton(onPressed: () => close(), child: const Text("Cancelar"))
      ],
    );
  }
}

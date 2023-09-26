import 'package:bootcamp_flutter/models/TarefasResponseModel.dart';
import 'package:flutter/material.dart';

class TarefaItem extends StatefulWidget {
  final TarefaModel tarefa;
  final Function() onPress;
  final Function(bool value) onChangedSwitch;
  const TarefaItem(
      {super.key,
      required this.tarefa,
      required this.onPress,
      required this.onChangedSwitch});

  @override
  State<TarefaItem> createState() => _TarefaItemState();
}

class _TarefaItemState extends State<TarefaItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            Text(widget.tarefa.descricao),
            Switch(
                value: widget.tarefa.concluido,
                onChanged: widget.onChangedSwitch)
          ],
        ),
      ),
    );
  }
}

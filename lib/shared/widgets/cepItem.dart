import 'package:consulta_cep/models/DatabaseCepModel.dart';
import 'package:flutter/material.dart';

class CepItem extends StatefulWidget {
  final CepModel cep;
  final Function() onPress;

  const CepItem({
    super.key,
    required this.cep,
    required this.onPress,
  });

  @override
  State<CepItem> createState() => _CepItemState();
}

class _CepItemState extends State<CepItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cep: ${widget.cep.cep}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 5,
            ),
            Text("${widget.cep.localidade} - ${widget.cep.logradouro} - ${widget.cep.complemento}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}

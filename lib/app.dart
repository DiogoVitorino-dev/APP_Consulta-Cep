import 'package:consulta_cep/pages/cepPage.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CepPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

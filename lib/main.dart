import 'package:arcade/pages/cardapio_page.dart';
import 'package:arcade/pages/comanda_detalhes_page.dart';
import 'package:arcade/pages/comandas_page.dart';
import 'package:arcade/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const MyHomePage(),
        "comandas": (context) => const Comandas(),
        "comandas/{id}": (context) => const ComandaDetalhes(),
        "cardapio": (context) => const Cardapio(),
      },
    );
  }
}

import 'package:arcade/pages/cardapio/cardapio.dart';
import 'package:arcade/pages/comandas/comanda_abrir.dart';
import 'package:arcade/pages/comandas/comandas_home.dart';
import 'package:arcade/pages/home_page.dart';
import 'package:arcade/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const MyHomePage(),
        "menu_comandas": (context) => const ComandasHome(),
        //"menu_comandas/comandas/ver": (context) => const Comandas(),
        "menu_comandas/comandas/abrir": (context) => const ComandaAbrir(),
        //"menu_comandas/comandas/fechar": (context) => const ComandaFechar(),
        //"menu_comandas/comandas/excluir": (context) => const ComandaExcluir(),
        //"comandas/{id}": (context) => const ComandaDetalhes(),
        "cardapio": (context) => const Cardapio(),
        //"pedidos/novo_pedido": (context) => const PedidoInserir()
      },
    );
  }
}

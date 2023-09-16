import 'package:arcade/pages/comandas/comanda_excluir.dart';
import 'package:arcade/pages/comandas/comanda_todas.dart';
import 'package:arcade/pages/home_page.dart';
import 'package:arcade/providers/provider.dart';
import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/reusable_main_buttons.dart';
import 'comanda_abrir.dart';

class ComandasHome extends StatefulWidget {
  const ComandasHome({super.key});

  @override
  State<ComandasHome> createState() => _ComandasHomeState();
}

class _ComandasHomeState extends State<ComandasHome> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final comandas = provider.comandas;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(
        title: 'Menu Comandas',
        backDestination: MyHomePage(),
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ReusableMainButtons(
                title: 'Ver Comandas', destination: Comandas()),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ReusableMainButtons(
                title: 'Abrir Comanda', destination: ComandaAbrir()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ReusableMainButtons(
                title: 'Excluir Comanda',
                destination: ComandaExcluir(comandas: comandas)),
          ),
        ],
      ),
    );
  }
}

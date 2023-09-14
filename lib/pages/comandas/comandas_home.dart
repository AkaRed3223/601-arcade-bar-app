import 'package:arcade/pages/comandas/comanda_excluir.dart';
import 'package:arcade/pages/comandas/comanda_todas.dart';
import 'package:arcade/providers/provider.dart';
import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widgets/home_page_main_buttons.dart';

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
      appBar: const CustomAppBar(title: 'Menu Comandas'),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Comandas()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(50.0),
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Ver Comandas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Abrir Comanda'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComandaExcluir(comandas: comandas)),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(50.0),
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Excluir Comanda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

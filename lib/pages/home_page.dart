import 'package:arcade/pages/cardapio/cardapio.dart';
import 'package:arcade/pages/comandas/comandas_home.dart';
import 'package:flutter/material.dart';

import '../widgets/reusable_main_buttons.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('601 Arcade Bar - Home Page'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ReusableMainButtons(title: 'Comandas', destination: ComandasHome()),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ReusableMainButtons(title: 'Cardápio', destination: Cardapio()),
          ),
        ],
      ),
    );
  }
}

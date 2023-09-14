import 'package:flutter/material.dart';

import '../widgets/home_page_main_buttons.dart';

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
            child: HomeButton(title: 'Comandas'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Cardápio'),
          ),
        ],
      ),
    );
  }
}

import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/home_page_main_buttons.dart';

class ComandasHome extends StatelessWidget {
  const ComandasHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Menu Comandas'),
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Ver Comandas'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Abrir Comanda'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Excluir Comanda'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: HomeButton(title: 'Fechar Comanda'),
          ),
        ],
      ),
    );
  }
}


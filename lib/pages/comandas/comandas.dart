import 'package:arcade/entities/comanda.dart';
import 'package:flutter/material.dart';

import '../../widgets/comanda_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';

class Comandas extends StatelessWidget {
  const Comandas({super.key});

  @override
  Widget build(BuildContext context) {
    List<Comanda> comandas = [];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Todas as Comandas'),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0
          ),
          itemCount: comandas.length,
          itemBuilder: (BuildContext context, int index) {
            return ComandaWidget(guestTab: comandas[index]);
          }),
    );
  }
}

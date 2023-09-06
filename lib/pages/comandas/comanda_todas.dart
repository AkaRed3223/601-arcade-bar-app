import 'package:arcade/entities/comanda.dart';
import 'package:arcade/entities/produto.dart';
import 'package:flutter/material.dart';

import '../../entities/categoria.dart';
import '../../widgets/comanda_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';

class Comandas extends StatelessWidget {
  final List<Comanda> comandas;
  final List<Produto> cardapio;
  final List<Categoria> categorias;

  const Comandas({super.key, required this.comandas, required this.cardapio, required this.categorias});

  @override
  Widget build(BuildContext context) {
    _sortComandasByIsOpen(comandas);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Todas as Comandas'),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 16.0, crossAxisSpacing: 16.0),
          itemCount: comandas.length,
          itemBuilder: (BuildContext context, int index) {
            return ComandaWidget(comanda: comandas[index], cardapio: cardapio, categorias: categorias);
          }),
    );
  }

  void _sortComandasByIsOpen(List<Comanda> comandas) {
    comandas.sort((a, b) {
      if (a.isOpen && !b.isOpen) {
        return -1; // a comes before b
      } else if (!a.isOpen && b.isOpen) {
        return 1; // b comes before a
      } else {
        return a.externalId.compareTo(b.externalId);
      }
    });
  }
}

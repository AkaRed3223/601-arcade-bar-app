import 'package:arcade/entities/comanda.dart';
import 'package:arcade/pages/comandas/comandas_home.dart';
import 'package:arcade/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/comanda_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';

class Comandas extends StatefulWidget {
  const Comandas({super.key});

  @override
  State<Comandas> createState() => _ComandasState();
}

class _ComandasState extends State<Comandas> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    final comandas = provider.comandas;

    _sortComandasByIsOpen(comandas);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(
        title: 'Todas as Comandas',
        backDestination: ComandasHome(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final provider = Provider.of<AppProvider>(context, listen: false);
          await provider.loadComandas();
          await provider.loadProdutos();
          setState(() {});
        },
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
            ),
            itemCount: comandas.length,
            itemBuilder: (BuildContext context, int index) {
              return ComandaWidget(comanda: comandas[index]);
            }),
      ),
    );
  }

  void _sortComandasByIsOpen(List<Comanda> comandas) {
    comandas.sort((a, b) {
      if (a.isOpen && !b.isOpen) {
        return -1;
      } else if (!a.isOpen && b.isOpen) {
        return 1;
      } else {
        return a.externalId.compareTo(b.externalId);
      }
    });
  }
}

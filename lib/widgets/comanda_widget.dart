import 'package:arcade/entities/produto.dart';
import 'package:arcade/pages/comandas/comanda_detalhes.dart';
import 'package:flutter/material.dart';

import '../entities/comanda.dart';

class ComandaWidget extends StatelessWidget {
  final Comanda comanda;
  final List<Produto> cardapio;

  const ComandaWidget({super.key, required this.comanda, required this.cardapio});

  @override
  Widget build(BuildContext context) {
    Container comandaWidget = Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(comanda.name,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text("${comanda.externalId}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Total: ${comanda.totalFormatado}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: Colors.white)),],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComandaDetalhes(comanda: comanda, cardapio: cardapio,),
          ),
        );
      },
      child: comandaWidget,
    );
  }
}

import 'package:arcade/entities/produto.dart';
import 'package:arcade/pages/comandas/comanda_detalhes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../entities/categoria.dart';
import '../entities/comanda.dart';

class ComandaWidget extends StatelessWidget {
  final Comanda comanda;
  final List<Produto> cardapio;
  final List<Categoria> categorias;

  const ComandaWidget(
      {super.key,
      required this.comanda,
      required this.cardapio,
      required this.categorias});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = comanda.isOpen ? Colors.transparent : Colors.green;
    Color borderColor = comanda.isOpen ? Colors.white : Colors.black;
    Color fontColor = comanda.isOpen ? Colors.white : Colors.black;

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(25.0),
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(comanda.name,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: fontColor,
                    fontWeight: FontWeight.bold)),
            Text("${comanda.externalId}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.18,
                    color: fontColor,
                    fontWeight: FontWeight.bold)),
            Text(
                comanda.isOpen
                    ? "Total: ${comanda.totalFormatado}"
                    : "Pago: ${comanda.totalFormatado}",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: fontColor,
                )),
          ],
        ),
      ),
      onTap: () {
        HapticFeedback.heavyImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComandaDetalhes(
              comanda: comanda,
              cardapio: cardapio,
              categoria: categorias,
            ),
          ),
        );
      },
    );
  }
}

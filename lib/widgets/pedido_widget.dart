import 'package:arcade/entities/produto.dart';
import 'package:flutter/material.dart';

class PedidoWidget extends StatelessWidget {
  final Produto produto;

  const PedidoWidget({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    Container comandaWidget = Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              produto.name,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(produto.precoFormatado,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );

    return comandaWidget;
  }
}

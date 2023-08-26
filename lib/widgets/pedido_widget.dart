import 'package:arcade/entities/produto_dto.dart';
import 'package:flutter/material.dart';

class PedidoWidget extends StatelessWidget {
  const PedidoWidget({super.key, required this.produto});

  final Produto produto;

  @override
  Widget build(BuildContext context) {

    Container comandaWidget = Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(produto.nome,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text('R\$ ${produto.preco.toStringAsFixed(2)}',
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

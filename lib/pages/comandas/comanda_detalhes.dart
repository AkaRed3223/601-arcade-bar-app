import 'package:arcade/entities/produto.dart';
import 'package:arcade/pages/pedidos/pedido_inserir.dart';
import 'package:arcade/widgets/pedido_widget.dart';
import 'package:flutter/material.dart';

import '../../entities/categoria.dart';
import '../../entities/comanda.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/comanda_total_widget.dart';

class ComandaDetalhes extends StatelessWidget {
  final Comanda comanda;
  final List<Produto> cardapio;
  final List<Categoria> categoria;

  const ComandaDetalhes({super.key, required this.comanda, required this.cardapio, required this.categoria});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Detalhes da Comanda'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PedidoInserir(cardapio: cardapio, comanda: comanda, categorias: categoria,)
            ),
          );
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comanda.products.length,
              itemBuilder: (context, index) {
                return PedidoWidget(produto: comanda.products[index]);
              },
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: TotalComandaWidget(comanda: comanda),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:arcade/entities/produto.dart';
import 'package:arcade/pages/comandas/comanda_fechar.dart';
import 'package:arcade/pages/pedidos/pedido_inserir.dart';
import 'package:arcade/pages/pedidos/pedido_remover.dart';
import 'package:arcade/widgets/pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entities/categoria.dart';
import '../../entities/comanda.dart';
import '../../widgets/comanda_total_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/floating_action_button.dart';

class ComandaDetalhes extends StatelessWidget {
  final Comanda comanda;
  final List<Produto> cardapio;
  final List<Categoria> categoria;

  const ComandaDetalhes(
      {super.key,
      required this.comanda,
      required this.cardapio,
      required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Detalhes da Comanda'),
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
          const SizedBox(width: 5),
          Visibility(
            visible: comanda.isOpen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableFAB(
                    tag: 'remove pedido',
                    text: 'Pedido',
                    builder: (context) => PedidoRemover(comanda: comanda),
                    iconData: Icons.remove),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: FloatingActionButton.extended(
                    heroTag: 'fechar comanda',
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComandaFechar(comanda: comanda)
                        ),
                      );
                    },
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.monetization_on),
                    label: const Text('FECHAR'),
                  ),
                ),
                const SizedBox(width: 5),
                ReusableFAB(
                    tag: 'add pedido',
                    text: 'Pedido',
                    builder: (context) => PedidoInserir(
                        cardapio: cardapio,
                        comanda: comanda,
                        categorias: categoria),
                    iconData: Icons.add),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

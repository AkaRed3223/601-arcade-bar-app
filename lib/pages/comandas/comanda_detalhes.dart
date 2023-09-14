import 'package:arcade/pages/comandas/comanda_fechar.dart';
import 'package:arcade/pages/pedidos/pedido_inserir.dart';
import 'package:arcade/pages/pedidos/pedido_remover.dart';
import 'package:arcade/widgets/pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entities/comanda.dart';
import '../../widgets/comanda_total_widget.dart';
import '../../widgets/floating_action_button.dart';
import 'comanda_todas.dart';

class ComandaDetalhes extends StatelessWidget {
  final Comanda comanda;

  const ComandaDetalhes({super.key, required this.comanda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Detalhes da Comanda'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Comandas(),
              ),
            );
          },
        ),
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
                            builder: (context) =>
                                ComandaFechar(comanda: comanda)),
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
                    builder: (context) => PedidoInserir(comanda: comanda),
                    iconData: Icons.add),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

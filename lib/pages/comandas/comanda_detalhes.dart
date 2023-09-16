import 'package:arcade/pages/comandas/comanda_fechar.dart';
import 'package:arcade/pages/pedidos/pedido_inserir.dart';
import 'package:arcade/pages/pedidos/pedido_remover.dart';
import 'package:arcade/widgets/pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entities/comanda.dart';
import '../../widgets/comanda_total_widget.dart';
import '../../widgets/reusable_floating_action_buttons.dart';
import 'comanda_todas.dart';

class ComandaDetalhes extends StatefulWidget {
  final Comanda comanda;

  const ComandaDetalhes({super.key, required this.comanda});

  @override
  State<ComandaDetalhes> createState() => _ComandaDetalhesState();
}

class _ComandaDetalhesState extends State<ComandaDetalhes> {
  set comanda(comanda) {}

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
              itemCount: widget.comanda.products.length,
              itemBuilder: (context, index) {
                return PedidoWidget(produto: widget.comanda.products[index]);
              },
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: TotalComandaWidget(comanda: widget.comanda),
            ),
          ),
          const SizedBox(width: 5),
          Visibility(
            visible: widget.comanda.isOpen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*ReusableFAB(
                    tag: 'remove pedido',
                    text: 'Pedido',
                    builder: (context) => PedidoRemover(comanda: comanda),
                    iconData: Icons.remove),*/
                Expanded(
                    flex: 1,
                    child: FloatingActionButton.extended(
                      heroTag: 'remove pedido',
                      onPressed: () async {
                        HapticFeedback.heavyImpact();
                        final newComanda = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PedidoRemover(comanda: widget.comanda)),
                        );
                        setState(() {
                          comanda = newComanda;
                        });
                      },
                      backgroundColor: Colors.grey[800],
                      icon: const Icon(Icons.remove),
                      label: const Text('Pedido'),
                    )),
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
                                ComandaFechar(comanda: widget.comanda)),
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
                    builder: (context) =>
                        PedidoInserir(comanda: widget.comanda),
                    iconData: Icons.add),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

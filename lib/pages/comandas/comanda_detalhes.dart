import 'package:arcade/pages/comandas/comanda_fechar.dart';
import 'package:arcade/pages/pedidos/pedido_inserir.dart';
import 'package:arcade/pages/pedidos/pedido_remover.dart';
import 'package:arcade/widgets/pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../entities/comanda.dart';
import '../../providers/provider.dart';
import '../../widgets/comanda_total_widget.dart';

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
    final provider = Provider.of<AppProvider>(context, listen: false);
    final currentComanda = provider.getCurrentComanda();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          '${currentComanda.name} - ${currentComanda.phone}',
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop(provider.comandas);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentComanda.products.length,
              itemBuilder: (context, index) {
                return PedidoWidget(produto: currentComanda.products[index]);
              },
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: TotalComandaWidget(comanda: currentComanda),
            ),
          ),
          const SizedBox(width: 5),
          Visibility(
            visible: currentComanda.isOpen && !currentComanda.isDeleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: FloatingActionButton.extended(
                      heroTag: 'remove pedido',
                      onPressed: () async {
                        HapticFeedback.heavyImpact();
                        final newComanda = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PedidoRemover(comanda: currentComanda)),
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
                    onPressed: () async {
                      HapticFeedback.heavyImpact();

                      final newComanda = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ComandaFechar(comanda: currentComanda)),
                      );
                      setState(() {
                        comanda = newComanda;
                      });
                    },
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.monetization_on),
                    label: const Text('FECHAR'),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: FloatingActionButton.extended(
                    heroTag: 'add pedido',
                    onPressed: () async {
                      HapticFeedback.heavyImpact();
                      final newComanda = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                PedidoInserir(comanda: currentComanda)),
                      );
                      setState(() {
                        comanda = newComanda;
                      });
                    },
                    backgroundColor: Colors.grey[800],
                    icon: const Icon(Icons.add),
                    label: const Text('Pedido'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

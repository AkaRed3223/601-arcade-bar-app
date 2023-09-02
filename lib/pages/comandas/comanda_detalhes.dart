import 'package:arcade/widgets/pedido_widget.dart';
import 'package:flutter/material.dart';

import '../../entities/comanda.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/comanda_total_widget.dart';

class ComandaDetalhes extends StatefulWidget {
  final Comanda comanda;

  const ComandaDetalhes({super.key, required this.comanda});

  @override
  State<ComandaDetalhes> createState() => _ComandaDetalhesState();
}

class _ComandaDetalhesState extends State<ComandaDetalhes> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Detalhes da Comanda'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'pedidos/novo_pedido');
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.add),
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
        ],
      ),
    );
  }
}

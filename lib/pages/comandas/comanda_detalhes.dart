import 'package:arcade/widgets/pedido_widget.dart';
import 'package:flutter/material.dart';

import '../../entities/comanda.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/total_comanda_widget.dart';

class ComandaDetalhes extends StatelessWidget {
  const ComandaDetalhes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Comanda comanda = Comanda(id: 26, name: 'César', products: [], externalId: 120);

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

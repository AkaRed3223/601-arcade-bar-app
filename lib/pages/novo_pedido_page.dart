import 'package:flutter/material.dart';

import '../widgets/custom_app_bar_widget.dart';

class NovoPedido extends StatelessWidget {
  const NovoPedido({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Novo Pedido'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Implementar aqui o salvamento do pedido na comanda atual
          //Navigator.pushNamed(context, 'caminho de volta');
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.done),
      ),
    );
  }
}

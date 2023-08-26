import 'package:flutter/material.dart';

import '../../entities/produto_dto.dart';
import '../../widgets/custom_app_bar_widget.dart';

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  @override
  Widget build(BuildContext context) {
    List<Produto> products = [
      Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
      Produto(nome: "X-Egg", url: 'assets/image2.png', preco: 26.90),
      Produto(nome: "X-Bacon", url: 'assets/image3.png', preco: 28.90),
      Produto(nome: "X-Pagan", url: 'assets/image4.png', preco: 34.90),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Cardápio'),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.asset(products[index].url),
              title: Text(
                products[index].nome,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
              subtitle: Text(
                  'R\$ ${products[index].preco.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  )
              ),
            );
          }),
    );
  }
}

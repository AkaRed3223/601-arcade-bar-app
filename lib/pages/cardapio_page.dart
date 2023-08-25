import 'package:flutter/material.dart';

import '../entities/product.dart';
import '../widgets/custom_app_bar_widget.dart';

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = [
      Product(name: "X-Burger", imageUrl: 'assets/image1.png', price: 24.90),
      Product(name: "X-Egg", imageUrl: 'assets/image2.png', price: 26.90),
      Product(name: "X-Bacon", imageUrl: 'assets/image3.png', price: 28.90),
      Product(name: "X-Pagan", imageUrl: 'assets/image4.png', price: 34.90),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Cardápio'),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.asset(products[index].imageUrl),
              title: Text(
                products[index].name,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                  'R\$ ${products[index].price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  )
              ),
            );
          }),
    );
  }
}

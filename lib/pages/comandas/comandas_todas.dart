import 'package:arcade/entities/comanda.dart';
import 'package:flutter/material.dart';

import '../../entities/product.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/comanda_widget.dart';

class Comandas extends StatelessWidget {
  const Comandas({super.key});

  @override
  Widget build(BuildContext context) {
    List<Comanda> comandas = [
      Comanda(id: 26, nome: 'César', produtos: [
        Product(name: "X-Burger", url: 'assets/image1.png', price: 24.90, category: "Lanches"),
        Product(name: "Original", url: '', price: 12.90, category: "Bebidas"),
        Product(name: "Coca", url: '', price: 8.90, category: "Bebidas"),
      ]),
      Comanda(id: 26, nome: 'Mi', produtos: [
        Product(name: "X-Burger", url: 'assets/image1.png', price: 24.90, category: "Lanches"),
        Product(name: "Original", url: '', price: 12.90, category: "Bebidas"),
        Product(name: "Coca", url: '', price: 8.90, category: "Bebidas"),
      ]),
      Comanda(id: 26, nome: 'Elias', produtos: [
        Product(name: "X-Burger", url: 'assets/image1.png', price: 24.90, category: "Lanches"),
        Product(name: "Original", url: '', price: 12.90, category: "Bebidas"),
        Product(name: "Coca", url: '', price: 8.90, category: "Bebidas"),
      ]),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Todas as Comandas'),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0
          ),
          itemCount: comandas.length,
          itemBuilder: (BuildContext context, int index) {
            return ComandaWidget(guestTab: comandas[index]);
          }),
    );
  }
}

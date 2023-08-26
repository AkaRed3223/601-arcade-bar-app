import 'package:arcade/entities/comanda_dto.dart';
import 'package:flutter/material.dart';

import '../../entities/produto_dto.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/comanda_widget.dart';

class Comandas extends StatelessWidget {
  const Comandas({super.key});

  @override
  Widget build(BuildContext context) {
    List<Comanda> tabs = [
      Comanda(id: 26, nome: 'César', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 12.90),
        Produto(nome: "Coca", url: '', preco: 8.90),
      ]),
      Comanda(id: 27, nome: 'Gabs', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 11.90)
      ]),
      Comanda(id: 28, nome: 'Elias', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
      ]),
      Comanda(id: 29, nome: 'Saulo', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
      ]),
      Comanda(id: 30, nome: 'Lucas', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
      ]),
      Comanda(id: 31, nome: 'Léo', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
      ]),
      Comanda(id: 32, nome: 'Pagan', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
      ]),
      Comanda(id: 33, nome: 'Takatu', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
      ]),
      Comanda(id: 34, nome: 'Ichinose', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
      ]),
      Comanda(id: 35, nome: 'Ueda', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90),
        Produto(nome: "Original", url: '', preco: 10.90)
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
          itemCount: tabs.length,
          itemBuilder: (BuildContext context, int index) {
            return ComandaWidget(guestTab: tabs[index]);
          }),
    );
  }
}

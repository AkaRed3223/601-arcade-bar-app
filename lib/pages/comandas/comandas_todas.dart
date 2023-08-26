import 'package:arcade/entities/comanda_dto.dart';
import 'package:flutter/material.dart';

import '../../entities/categories_enum.dart';
import '../../entities/produto_dto.dart';
import '../../widgets/custom_app_bar_widget.dart';
import '../../widgets/comanda_widget.dart';

class Comandas extends StatelessWidget {
  const Comandas({super.key});

  @override
  Widget build(BuildContext context) {
    List<Comanda> comandas = [
      Comanda(id: 26, nome: 'César', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90, categoria: Categorias.lanches),
        Produto(nome: "Original", url: '', preco: 12.90, categoria: Categorias.bebidas),
        Produto(nome: "Coca", url: '', preco: 8.90, categoria: Categorias.bebidas),
      ]),
      Comanda(id: 26, nome: 'Mi', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90, categoria: Categorias.lanches),
        Produto(nome: "Original", url: '', preco: 12.90, categoria: Categorias.bebidas),
        Produto(nome: "Coca", url: '', preco: 8.90, categoria: Categorias.bebidas),
      ]),
      Comanda(id: 26, nome: 'Elias', produtos: [
        Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90, categoria: Categorias.lanches),
        Produto(nome: "Original", url: '', preco: 12.90, categoria: Categorias.bebidas),
        Produto(nome: "Coca", url: '', preco: 8.90, categoria: Categorias.bebidas),
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

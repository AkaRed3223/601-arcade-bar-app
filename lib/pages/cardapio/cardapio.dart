import 'package:arcade/entities/categories_enum.dart';
import 'package:flutter/material.dart';

import '../../entities/produto_dto.dart';
import '../../widgets/cardapio_widget.dart';

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  @override
  Widget build(BuildContext context) {
    List<Produto> produtos = [
      Produto(nome: "X-Burger", url: 'assets/image1.png', preco: 24.90, categoria: Categorias.lanches),
      Produto(nome: "X-Egg", url: 'assets/image2.png', preco: 26.90, categoria: Categorias.lanches),
      Produto(nome: "X-Bacon", url: 'assets/image3.png', preco: 28.90, categoria: Categorias.lanches),
      Produto(nome: "X-Pagan", url: 'assets/image3.png', preco: 34.90, categoria: Categorias.lanches),
      Produto(nome: "Cerveja Original", url: 'assets/image3.png', preco: 28.90, categoria: Categorias.bebidas),
      Produto(nome: "Cerveja Eisenbahn", url: 'assets/image3.png', preco: 28.90, categoria: Categorias.bebidas),
      Produto(nome: "Coca-Cola KS", url: 'assets/image3.png', preco: 34.90, categoria: Categorias.bebidas),
      Produto(nome: "Batata frita", url: 'assets/image3.png', preco: 28.90, categoria: Categorias.porcoes),
      Produto(nome: "Tábua de Frios", url: 'assets/image3.png', preco: 34.90, categoria: Categorias.porcoes),
      Produto(nome: "Ficha Arcade", url: 'assets/image3.png', preco: 2.00, categoria: Categorias.fichas),
      Produto(nome: "Ficha Pinball", url: 'assets/image1.png', preco: 3.00, categoria: Categorias.fichas),
      Produto(nome: "Ficha Snooker", url: 'assets/image2.png', preco: 3.00, categoria: Categorias.fichas),
    ];

    return DefaultTabController(
      length: Categorias.values.length, // Number of categories
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          elevation: 5,
          title: const Text('Cardápio'),
          bottom: TabBar(
            tabs: Categorias.values.map((categoria) => Tab(text: categoria.name.toUpperCase())).toList(),
          ),
        ),
        body: CardapioWidget(produtos: produtos),
      ),
    );
  }
}

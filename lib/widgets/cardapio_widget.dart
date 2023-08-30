import 'package:arcade/entities/produto.dart';
import 'package:flutter/material.dart';

import '../entities/categoria.dart';

class CardapioWidget extends StatelessWidget {
  const CardapioWidget({super.key, required this.products, required this.categories});

  final List<Produto> products;
  final List<Categoria> categories;

  Widget _buildCategoryTab({required List<Produto> products}) {
    return SingleChildScrollView(
      child: Column(
        children: products.map((product) {
          return ListTile(
            leading: Image.asset(product.url),
            title: Text(
              product.name,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              product.precoFormatado,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 20,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: categories.length,

      child: Scaffold(
        backgroundColor: Colors.grey[900],

        appBar: AppBar(
          title: const Text('Cardápio'),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          elevation: 2,

          bottom: TabBar(
            isScrollable: true,
            tabs: categories.map((category) {
              return Tab(
                text: category.name,
              );
            }).toList(),
          ),
        ),

        body: TabBarView(
          children: categories.map((category) {
            List<Produto> produtosPorCategoria = products
                .where((produto) => produto.category.id == category.id)
                .toList();

            return _buildCategoryTab(products: produtosPorCategoria);
          }).toList(),
        ),
      ),
    );
  }
}



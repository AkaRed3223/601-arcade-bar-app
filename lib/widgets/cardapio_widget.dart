import 'package:arcade/entities/produto.dart';
import 'package:arcade/pages/cardapio/cardapio_excluir_produto.dart';
import 'package:arcade/pages/cardapio/cardapio_inserir_categoria.dart';
import 'package:arcade/pages/cardapio/cardapio_inserir_produto.dart';
import 'package:arcade/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../entities/categoria.dart';
import '../pages/cardapio/cardapio_excluir_categoria.dart';

class CardapioWidget extends StatefulWidget {
  final List<Produto> products;
  final List<Categoria> categories;

  const CardapioWidget(
      {super.key, required this.products, required this.categories});

  @override
  State<CardapioWidget> createState() => _CardapioWidgetState();
}

class _CardapioWidgetState extends State<CardapioWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              HapticFeedback.mediumImpact(); // Add haptic feedback here
              Navigator.of(context).pop(); // This will navigate back
            },
          ),
          title: const Text('Cardápio'),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          elevation: 2,
          bottom: TabBar(
            isScrollable: true,
            tabs: widget.categories.map((category) {
              return Tab(
                text: category.name,
              );
            }).toList(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: widget.categories.map((category) {
                  final categoryProducts = widget.products
                      .where((produto) => produto.category.id == category.id)
                      .toList();
                  return _buildCategoryTab(products: categoryProducts);
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ReusableFAB(
                          tag: 'add categoria',
                          text: 'Categoria',
                          builder: (context) =>
                              const CardapioInserirCategoria(),
                          iconData: Icons.add),
                      const SizedBox(width: 5),
                      ReusableFAB(
                        tag: 'add produto',
                        text: 'Produto',
                        builder: (context) => CardapioInserirProduto(
                            categorias: widget.categories,
                            produtos: widget.products),
                        iconData: Icons.add,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ReusableFAB(
                        tag: 'remove categoria',
                        text: 'Categoria',
                        builder: (context) => CardapioExcluirCategoria(
                            categorias: widget.categories,
                            produtos: widget.products),
                        iconData: Icons.remove,
                      ),
                      const SizedBox(width: 5),
                      ReusableFAB(
                        tag: 'remove produto',
                        text: 'Produto',
                        builder: (context) =>
                            CardapioExcluirProduto(produtos: widget.products),
                        iconData: Icons.remove,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab({required List<Produto> products}) {
    return SingleChildScrollView(
      child: Column(
        children: products.map((product) {
          return ListTile(
            leading: Icon(Icons.warning, color: Colors.grey[850]),
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
}

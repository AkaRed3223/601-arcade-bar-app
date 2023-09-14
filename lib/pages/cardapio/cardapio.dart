import 'package:arcade/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../entities/produto.dart';
import '../../providers/provider.dart';
import '../../widgets/floating_action_button.dart';
import 'cardapio_excluir_categoria.dart';
import 'cardapio_excluir_produto.dart';
import 'cardapio_inserir_categoria.dart';
import 'cardapio_inserir_produto.dart';

class Cardapio extends StatelessWidget {
  const Cardapio({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final categorias = provider.categorias;
    final produtos = provider.produtos;

    return DefaultTabController(
      length: categorias.length,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              HapticFeedback.mediumImpact();
              //Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
          ),
          title: const Text('Cardápio'),
          centerTitle: true,
          backgroundColor: Colors.grey[800],
          elevation: 2,
          bottom: TabBar(
            isScrollable: true,
            tabs: categorias.map((category) {
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
                children: categorias.map((category) {
                  final categoryProducts = produtos
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
                            categorias: categorias, produtos: produtos),
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
                            categorias: categorias, produtos: produtos),
                        iconData: Icons.remove,
                      ),
                      const SizedBox(width: 5),
                      ReusableFAB(
                        tag: 'remove produto',
                        text: 'Produto',
                        builder: (context) =>
                            CardapioExcluirProduto(produtos: produtos),
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

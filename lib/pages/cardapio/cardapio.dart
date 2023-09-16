import 'package:arcade/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../entities/produto.dart';
import '../../providers/provider.dart';
import 'cardapio_excluir_categoria.dart';
import 'cardapio_excluir_produto.dart';
import 'cardapio_inserir_categoria.dart';
import 'cardapio_inserir_produto.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({super.key});

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
  set categorias(categorias) {}
  set produtos(produtos) {}

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
              Navigator.of(context).pop(const MyHomePage());
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
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton.extended(
                          heroTag: 'add categoria',
                          onPressed: () async {
                            HapticFeedback.heavyImpact();
                            final newCategorias = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const CardapioInserirCategoria()),
                            );
                            setState(() {
                              this.categorias = newCategorias;
                            });
                          },
                          backgroundColor: Colors.grey[800],
                          icon: const Icon(Icons.add),
                          label: const Text('Categoria'),
                        )
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton.extended(
                          heroTag: 'add produto',
                          onPressed: () async {
                            HapticFeedback.heavyImpact();
                            final newProdutos = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CardapioInserirProduto(
                                  categorias: categorias, produtos: produtos)),
                            );
                            setState(() {
                              this.produtos = newProdutos;
                            });
                          },
                          backgroundColor: Colors.grey[800],
                          icon: const Icon(Icons.add),
                          label: const Text('Produto'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton.extended(
                          heroTag: 'remove categoria',
                          onPressed: () async {
                            HapticFeedback.heavyImpact();
                            final newCategorias = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CardapioExcluirCategoria(
                                  categorias: categorias, produtos: produtos)),
                            );
                            setState(() {
                              this.categorias = newCategorias;
                            });
                          },
                          backgroundColor: Colors.grey[800],
                          icon: const Icon(Icons.remove),
                          label: const Text('Categoria'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton.extended(
                          heroTag: 'remove produto',
                          onPressed: () async {
                            HapticFeedback.heavyImpact();
                            final newProdutos = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CardapioExcluirProduto(produtos: produtos)),
                            );
                            setState(() {
                              this.produtos = newProdutos;
                            });
                          },
                          backgroundColor: Colors.grey[800],
                          icon: const Icon(Icons.remove),
                          label: const Text('Produto'),
                        ),
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

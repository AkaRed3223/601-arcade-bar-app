import 'package:flutter/material.dart';

import '../../entities/categoria.dart';
import '../../entities/produto.dart';
import '../../widgets/cardapio_widget.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({super.key});

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
  late Future<List<Categoria>> futureCategories;
  late Future<List<Produto>> futureProducts;
  late List<Categoria> loadedCategories = [];
  late List<Produto> loadedProducts = [];

  @override
  void initState() {
    super.initState();
    futureCategories = CategoriasService().fetchCategorias();
    futureProducts = ProdutosService().fetchProdutos();
    _loadData();
  }

  Future<void> _loadData() async {
    loadedCategories = await futureCategories;
    loadedProducts = await futureProducts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.wait([futureCategories, futureProducts]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CardapioWidget(
            categories: loadedCategories,
            products: loadedProducts,
          );
        }
      },
    );
  }
}

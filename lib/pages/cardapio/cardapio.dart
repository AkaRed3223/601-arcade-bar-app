import 'package:flutter/material.dart';

import '../../entities/categories.dart';
import '../../entities/product.dart';
import '../../widgets/cardapio_widget.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({super.key});

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
  late Future<List<Categories>> futureCategories;
  late List<Product> produtos;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoriesService().fetchCategories();
    produtos = [
      Product(
          name: "X-Burger",
          url: 'assets/image1.png',
          price: 24.90,
          category: 'Lanches'),
      Product(
          name: "X-Egg",
          url: 'assets/image2.png',
          price: 26.90,
          category: 'Lanches'),
      Product(
          name: "X-Bacon",
          url: 'assets/image3.png',
          price: 28.90,
          category: 'Lanches'),
      Product(
          name: "X-Pagan",
          url: 'assets/image3.png',
          price: 34.90,
          category: 'Lanches'),
      Product(
          name: "Cerveja Original",
          url: 'assets/image3.png',
          price: 28.90,
          category: 'Bebidas'),
      Product(
          name: "Cerveja Eisenbahn",
          url: 'assets/image3.png',
          price: 28.90,
          category: 'Bebidas'),
      Product(
          name: "Coca-Cola KS",
          url: 'assets/image3.png',
          price: 34.90,
          category: 'Bebidas'),
      Product(
          name: "Batata frita",
          url: 'assets/image3.png',
          price: 28.90,
          category: 'Porções'),
      Product(
          name: "Tábua de Frios",
          url: 'assets/image3.png',
          price: 34.90,
          category: 'Porções'),
      Product(
          name: "Ficha Arcade",
          url: 'assets/image3.png',
          price: 2.00,
          category: 'Fichas'),
      Product(
          name: "Ficha Pinball",
          url: 'assets/image1.png',
          price: 3.00,
          category: 'Fichas'),
      Product(
          name: "Ficha Snooker",
          url: 'assets/image2.png',
          price: 3.00,
          category: 'Fichas'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categories>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No categories available.');
        } else {
          return DefaultTabController(
            length: snapshot.data!.length,
            child: Scaffold(
              backgroundColor: Colors.grey[800],
              appBar: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  tabs: snapshot.data!.map((category) {
                    return Tab(
                      text: category.name,
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: snapshot.data!.map((category) {
                  List<Product> produtosPorCategoria = produtos
                      .where((produto) => produto.category == category.name)
                      .toList();

                  return ListView.builder(
                    itemCount: produtosPorCategoria.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.asset(produtosPorCategoria[index].url),
                        title: Text(
                          produtosPorCategoria[index].name,
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                        subtitle: Text(
                          produtosPorCategoria[index].precoFormatado,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}

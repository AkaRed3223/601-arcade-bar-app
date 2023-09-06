import 'package:arcade/entities/produto.dart';
import 'package:arcade/pages/comandas/comanda_excluir.dart';
import 'package:arcade/pages/comandas/comanda_todas.dart';
import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';

import '../../entities/categoria.dart';
import '../../entities/comanda.dart';
import '../../widgets/home_page_main_buttons.dart';

class ComandasHome extends StatefulWidget {
  const ComandasHome({super.key});

  @override
  State<ComandasHome> createState() => _ComandasHomeState();
}

class _ComandasHomeState extends State<ComandasHome> {
  late Future<List<Comanda>> futureComandas;
  late Future<List<Produto>> futureProdutos;
  late Future<List<Categoria>> futureCategorias;

  late List<Comanda> loadedComandas = [];
  late List<Produto> loadedProdutos = [];
  late List<Categoria> loadedCategorias = [];

  @override
  void initState() {
    super.initState();
    futureComandas = ComandasService().fetchComandas();
    futureProdutos = ProdutosService().fetchProdutos();
    futureCategorias = CategoriasService().fetchCategorias();
    _loadData();
  }

  Future<void> _loadData() async {
    loadedComandas = await futureComandas;
    loadedProdutos = await futureProdutos;
    loadedCategorias = await futureCategorias;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.wait([futureComandas, futureProdutos, futureCategorias]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: const CustomAppBar(title: 'Menu Comandas'),
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Comandas(comandas: loadedComandas, cardapio: loadedProdutos, categorias: loadedCategorias)
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(50.0),
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'Ver Comandas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: HomeButton(title: 'Abrir Comanda'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ComandaExcluir(comandas: loadedComandas)
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(50.0),
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'Excluir Comanda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

import 'package:arcade/entities/categoria.dart';
import 'package:arcade/entities/produto.dart';
import 'package:flutter/material.dart';

import '../entities/comanda.dart';

class AppProvider extends ChangeNotifier {
  List<Comanda> _comandas = [];
  List<Produto> _produtos = [];
  List<Categoria> _categorias = [];

  List<Comanda> get comandas => _comandas;
  List<Produto> get produtos => _produtos;
  List<Categoria> get categorias => _categorias;

  AppProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _comandas = await ComandasService().fetchComandas();
    _produtos = await ProdutosService().fetchProdutos();
    _categorias = await CategoriasService().fetchCategorias();

    notifyListeners();
  }

  void addComanda(Comanda comanda) {
    _comandas.add(comanda);
    notifyListeners();
  }

  void addProduto(Produto produto) {
    _produtos.add(produto);
    notifyListeners();
  }

  void addCategoria(Categoria categoria) {
    _categorias.add(categoria);
    notifyListeners();
  }
}
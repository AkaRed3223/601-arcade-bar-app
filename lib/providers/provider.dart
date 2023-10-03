import 'package:arcade/entities/categoria.dart';
import 'package:arcade/entities/produto.dart';
import 'package:flutter/material.dart';

import '../entities/comanda.dart';
import '../entities/operation.dart';
import '../entities/payment.dart';

class AppProvider extends ChangeNotifier {
  List<Comanda> _comandas = [];
  List<Produto> _produtos = [];
  List<Categoria> _categorias = [];
  List<Operation> _operations = [];

  List<Comanda> get comandas => _comandas;
  List<Produto> get produtos => _produtos;
  List<Categoria> get categorias => _categorias;
  List<Operation> get operations => _operations;

  late Comanda currentComanda;
  late Operation currentOperation;

  AppProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await fetchCategorias();
    await fetchProdutos();
    await fetchComandas();
    await fetchOperations();
    notifyListeners();
  }

  Future<void> fetchCategorias() async {
    _categorias = await CategoriasService().fetchCategorias();
  }

  Future<void> fetchProdutos() async {
    _produtos = await ProdutosService().fetchProdutos();
    _produtos.sort((a, b) => a.price.compareTo(b.price));
  }

  Future<void> fetchComandas() async {
    _comandas = await ComandasService().fetchComandas();
  }

  Future<void> fetchOperations() async {
    _operations = await OperationsService().fetchOperations();
  }

  Future<void> loadCategorias() async {
    await fetchCategorias();
    notifyListeners();
  }

  Future<void> loadProdutos() async {
    await fetchProdutos();
    notifyListeners();
  }

  Future<void> loadComandas() async {
    await fetchComandas();
    notifyListeners();
  }

  Future<void> loadOperations() async {
    await fetchOperations();
    notifyListeners();
  }

  void addCategoria(Categoria categoria) {
    _categorias.add(categoria);
    notifyListeners();
  }

  void removeCategoria(int id) {
    _categorias.removeWhere((categoria) => categoria.id == id);
    notifyListeners();
  }

  void addComanda(Comanda comanda) {
    _comandas.add(comanda);
    notifyListeners();
  }

  void removeComanda(int id) {
    _comandas.removeWhere((comanda) => comanda.id == id);
    notifyListeners();
  }

  void addProduto(Produto produto) {
    _produtos.add(produto);
    notifyListeners();
  }

  void removeProduto(int id) {
    _produtos.removeWhere((produto) => produto.id == id);
    notifyListeners();
  }

  void addPaymentToComanda(Payment payment) {
    //currentComanda.payments.add(payment);
    notifyListeners();
  }

  void setCurrentComanda(Comanda comanda) {
    currentComanda = comanda;
  }

  Comanda getCurrentComanda() {
    return currentComanda;
  }

  Operation getCurrentOperation() {
    return currentOperation;
  }
}
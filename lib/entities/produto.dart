import 'package:arcade/entities/categoria.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Produto {
  final int id;
  final String name;
  final String url = 'assets/image3.png';
  final double price;
  final Categoria category;
  final String createdAt;
  final String updatedAt;

  Produto({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  DateTime get createdAtDateTime => DateTime.parse(createdAt);
  DateTime get updatedAtDateTime => DateTime.parse(updatedAt);
  String get precoFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(price);

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      category: Categoria.fromJson(json['category']
      ),
    );
  }

  static List<Produto> listFromJson(List<dynamic> jsonList) {
    List<Produto> produtos = jsonList.map((item) => Produto.fromJson(item)).toList();
    produtos.sort((a, b) => a.name.compareTo(b.name));
    return produtos;
  }
}

class ProdutosService {
  /*static void sortProdutosByInsertedAt(List<Produto> produtos) {
    produtos.sort((a, b) => a.insertedAt.compareTo(b.insertedAt));
  }*/

  Future<List<Produto>> fetchProdutos() async {

    // const String baseUrl = 'http://localhost:8080';
    const String baseUrl = 'http://172.31.48.1:8080';
    // const String baseUrl = 'http://3.137.160.128:8080';

    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json; charset=utf-8' },
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final List<Produto> productList = Produto.listFromJson(jsonData);
      return productList;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }
}
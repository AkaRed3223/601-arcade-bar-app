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

  Produto({
    required this.id,
    required this.name,
    required this.price,
    required this.category});

  String get precoFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(price);

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      category: Categoria.fromJson(json['category']),
    );
  }

  static List<Produto> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Produto.fromJson(item)).toList();
  }
}

class ProductsService {
  Future<List<Produto>> fetchProdutos() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/products'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
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
import 'dart:convert';

import 'package:arcade/entities/produto.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Comanda {
  final int id;
  final int externalId;
  final String name;
  final List<Produto> products;
  final double total;

  Comanda({
    required this.id,
    required this.externalId,
    required this.name,
    required this.products,
    required this.total,
  });

  String get totalFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(total);

  factory Comanda.fromJson(Map<String, dynamic> json) {
    return Comanda(
      id: json['id'],
      externalId: json['externalId'],
      name: json['name'], 
      products: Produto.listFromJson(json['products']), 
      total: json['total'],
    );
  }

  static List<Comanda> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Comanda.fromJson(item)).toList();
  }
}

class ComandasService {
  Future<List<Comanda>> fetchComandas() async {
    final response = await http.get(
      Uri.parse('http://192.168.240.1:8080/tabs'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final List<Comanda> productList = Comanda.listFromJson(jsonData);
      return productList;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }
}

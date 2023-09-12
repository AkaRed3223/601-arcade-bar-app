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
  final bool isOpen;

  Comanda({
    required this.id,
    required this.externalId,
    required this.name,
    required this.products,
    required this.total,
    required this.isOpen
  });

  String get totalFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(total);

  factory Comanda.fromJson(Map<String, dynamic> json) {
    return Comanda(
      id: json['id'],
      externalId: json['externalId'],
      name: json['name'], 
      products: Produto.listFromJson(json['products']), 
      total: json['total'],
      isOpen: json['isOpen']
    );
  }

  static List<Comanda> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Comanda.fromJson(item)).toList();
  }
}

class ComandasService {
  Future<List<Comanda>> fetchComandas() async {

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.20.128.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    final response = await http.get(
      Uri.parse('$baseUrl/tabs'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final List<Comanda> comandaList = Comanda.listFromJson(jsonData);
      return comandaList;
    } else {
      throw Exception('API call failed with status code: ${response.statusCode}');
    }
  }
}

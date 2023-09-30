import 'dart:convert';

import 'package:arcade/entities/produto.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Comanda {
  final int id;
  final int externalId;
  final String name;
  final String phone;
  late final List<Produto> products;
  final double total;
  final bool isOpen;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  Comanda({
    required this.id,
    required this.externalId,
    required this.name,
    required this.phone,
    required this.products,
    required this.total,
    required this.isOpen,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  String get totalFormatado =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(total);

  factory Comanda.fromJson(Map<String, dynamic> json) {
    return Comanda(
      id: json['id'],
      externalId: json['externalId'],
      name: json['name'],
      phone: Comanda.formatPhone(json['phone']),
      products: Produto.listFromJson(json['products']),
      total: json['total'],
      isOpen: json['isOpen'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  static List<Comanda> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => Comanda.fromJson(item)).toList();
  }

  static String formatPhone(String phone) {
    final cleanedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (cleanedPhone.length == 10) {
      return '(${cleanedPhone[0]}${cleanedPhone[1]}) ${cleanedPhone[2]}${cleanedPhone[3]}${cleanedPhone[4]}${cleanedPhone[5]}-${cleanedPhone[6]}${cleanedPhone[7]}${cleanedPhone[8]}${cleanedPhone[9]}';
    } else if (cleanedPhone.length == 11) {
      return '(${cleanedPhone[0]}${cleanedPhone[1]}) ${cleanedPhone[2]}${cleanedPhone[3]}${cleanedPhone[4]}${cleanedPhone[5]}${cleanedPhone[6]}-${cleanedPhone[7]}${cleanedPhone[8]}${cleanedPhone[9]}${cleanedPhone[10]}';
    } else {
      return '';
    }
  }
}

class ComandasService {
  Future<List<Comanda>> fetchComandas() async {
    // const String baseUrl = 'http://localhost:8080';
    const String baseUrl = 'http://172.31.48.1:8080';
    // const String baseUrl = 'http://3.137.160.128:8080';

    final response = await http.get(
      Uri.parse('$baseUrl/tabs'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final List<Comanda> comandaList = Comanda.listFromJson(jsonData);
      return comandaList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(
          'API call failed with status code: ${response.statusCode}');
    }
  }
}

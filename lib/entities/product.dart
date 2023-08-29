import 'package:intl/intl.dart';

class Product {
  final String name;
  final String url;
  final double price;
  final String category;

  Product({required this.name, required this.url, required this.price, required this.category});

  String get precoFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(price);
}
import 'package:intl/intl.dart';

import 'categories_enum.dart';

class Produto {
  final String nome;
  final String url;
  final double preco;
  final Categorias categoria;

  Produto({required this.nome, required this.url, required this.preco, required this.categoria});

  String get precoFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(preco);
}
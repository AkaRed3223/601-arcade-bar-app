import 'package:intl/intl.dart';

class Produto {
  final String nome;
  final String url;
  final double preco;

  Produto({required this.nome, required this.url, required this.preco});

  String get precoFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(preco);
}
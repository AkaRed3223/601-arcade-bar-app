import 'package:arcade/entities/produto.dart';
import 'package:intl/intl.dart';

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
  }) : total = products.fold(0.0, (total, produto) => total + produto.price);

  String get totalFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(total);
}

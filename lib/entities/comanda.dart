import 'package:arcade/entities/product.dart';
import 'package:intl/intl.dart';

class Comanda {
  final int id;
  final String nome;
  final List<Product> produtos;
  final double total;

  Comanda({
    required this.id,
    required this.nome,
    required this.produtos,
  }) : total = produtos.fold(0.0, (total, produto) => total + produto.price);

  String get totalFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(total);
}

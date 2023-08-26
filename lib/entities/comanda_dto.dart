import 'package:arcade/entities/produto_dto.dart';
import 'package:intl/intl.dart';

class Comanda {
  final int id;
  final String nome;
  final List<Produto> produtos;
  final double total;

  Comanda({
    required this.id,
    required this.nome,
    required this.produtos,
  }) : total = produtos.fold(0.0, (total, produto) => total + produto.preco);

  String get totalFormatado => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(total);
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../entities/categoria.dart';
import '../../entities/comanda.dart';
import '../../entities/produto.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'package:http/http.dart' as http;

class PedidoInserir extends StatefulWidget {
  final Comanda comanda;
  final List<Produto> cardapio;
  final List<Categoria> categorias;

  const PedidoInserir({
    Key? key,
    required this.comanda,
    required this.cardapio,
    required this.categorias,
  }) : super(key: key);

  @override
  State<PedidoInserir> createState() => _PedidoInserirState();
}

class _PedidoInserirState extends State<PedidoInserir> {
  Produto? selectedProduct;
  bool showSuccess = false;
  bool showError = false;

  final ScrollController _scrollController = ScrollController();

  Future<void> _atualizarComanda(int comandaId, int productId) async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://172.20.128.1:8080';
    // const String baseUrl = 'http://localhost:8080';
    const String baseUrl = 'https://arcade-bar-backend-398600.ue.r.appspot.com';

    final url = Uri.parse('$baseUrl/tabs/$comandaId/insert');
    final headers = {'Content-Type': 'application/json'};
    final queryParams = {'productId': productId.toString()};

    final response = await http.put(url.replace(queryParameters: queryParams),
        headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        showSuccess = true;
      });
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Novo Pedido'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            for (Categoria categoria in widget.categorias)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Colors.green,
                    thickness: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoria.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white, thickness: 0),
                  Column(
                    children: [
                      for (Produto produto in widget.cardapio)
                        if (produto.category.id == categoria.id)
                          ListTile(
                            title: Text(
                              '${produto.name} - ${produto.precoFormatado}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              setState(() {
                                selectedProduct = produto;
                              });
                            },
                          ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomSheet: selectedProduct != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Produto selecionado:\n${selectedProduct!.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          HapticFeedback.heavyImpact();
          final selectedProduct = this.selectedProduct;
          if (selectedProduct != null) {
            widget.comanda.products.add(selectedProduct);
            await _atualizarComanda(widget.comanda.id, selectedProduct.id);
          }
          if (showSuccess) {
            setState(() {
              this.selectedProduct = null;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Center(
                    child: Text(
                  'PEDIDO RECEBIDO!',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
                duration: Duration(seconds: 1),
              ));
            });
          }
          if (showError) {
            setState(() {
              this.selectedProduct = null;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Center(
                    child: Text(
                      'PROBLEMA AO INSERIR PEDIDO!',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                duration: Duration(seconds: 1),
              ));
            });
          }
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.done),
      ),
    );
  }
}

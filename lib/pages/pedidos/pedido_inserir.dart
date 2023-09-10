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

    final url =
        Uri.parse('https://arcade-bar-backend-398600.ue.r.appspot.com/tabs/$comandaId/insert');
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
                              /*_scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                // Adjust the duration as needed
                                curve: Curves.easeInOut, // Adjust the curve as needed
                              );*/
                            },
                          ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 80),
            /*if (showSuccess)
              const Column(
                children: [
                  SizedBox(height: 20),
                  Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text('Produto adicionado!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ],
              ),
            if (showError)
              const Column(
                children: [
                  SizedBox(height: 20),
                  Icon(
                    Icons.error_outline,
                    size: 100,
                    color: Colors.red,
                  ),
                  SizedBox(height: 20),
                  Text('Erro ao adicionar produto!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ],
              ),*/
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
        onPressed: () {
          HapticFeedback.heavyImpact();
          final selectedProduct = this.selectedProduct;
          if (selectedProduct != null) {
            widget.comanda.products.add(selectedProduct);
            _atualizarComanda(widget.comanda.id, selectedProduct.id);
          }
          /*setState(() {
            this.selectedProduct = null;
          });*/
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.done),
      ),
    );
  }
}

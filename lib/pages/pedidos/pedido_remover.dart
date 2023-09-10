import 'package:arcade/entities/produto.dart';
import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../entities/comanda.dart';

class PedidoRemover extends StatefulWidget {
  final Comanda comanda;

  const PedidoRemover({super.key, required this.comanda});

  @override
  State<PedidoRemover> createState() => _PedidoRemoverState();
}

class _PedidoRemoverState extends State<PedidoRemover> {
  int? selectedProdutoId;
  bool showSuccess = false;
  bool showError = false;

  Future<void> _atualizarComanda() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://172.20.128.1:8080';
    //const String baseUrl = 'http://localhost:8080';
    const String baseUrl = 'https://arcade-bar-backend-398600.ue.r.appspot.com';

    if (selectedProdutoId != null) {
      final url = Uri.parse(
          '$baseUrl/tabs/${widget.comanda.id}/remove');
      final headers = {'Content-Type': 'application/json'};
      final queryParams = {'productId': selectedProdutoId.toString()};

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Excluir Pedido'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<int>(
                      items: widget.comanda.products.map((produto) {
                        return DropdownMenuItem<int>(
                          value: produto.id,
                          child: Text(
                              '${produto.name} (${produto.precoFormatado})'),
                        );
                      }).toList(),
                      itemHeight: 60,
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      value: selectedProdutoId,
                      onChanged: (value) {
                        setState(() {
                          selectedProdutoId = value;
                          showSuccess = false;
                        });
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Selecionar Produto',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (selectedProdutoId != null)
                      ProdutoDetailsCard(
                        produto: widget.comanda.products.firstWhere(
                            (produto) => produto.id == selectedProdutoId!),
                        onDelete: _atualizarComanda,
                        showSuccess: showSuccess,
                      ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (showSuccess)
                            const Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 100,
                                  color: Colors.green,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Produto excluído com sucesso!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
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
                                Text(
                                  'Erro ao excluir Produto!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProdutoDetailsCard extends StatelessWidget {
  final Produto produto;
  final VoidCallback onDelete;
  final bool showSuccess;

  const ProdutoDetailsCard(
      {super.key,
      required this.produto,
      required this.onDelete,
      required this.showSuccess});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[800],
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Produto: ${produto.name}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Preço: ${produto.precoFormatado}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(220, 90)),
              onPressed: () {
                HapticFeedback.heavyImpact();
                onDelete;
              },
              child: const Text(
                'Excluir Pedido',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

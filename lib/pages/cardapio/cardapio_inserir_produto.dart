import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../entities/categoria.dart';
import '../../entities/produto.dart';
import '../../providers/provider.dart';
import '../../widgets/custom_app_bar_widget.dart';
import 'cardapio.dart';

class CardapioInserirProduto extends StatefulWidget {
  const CardapioInserirProduto(
      {super.key, required this.categorias, required this.produtos});

  final List<Categoria> categorias;
  final List<Produto> produtos;

  @override
  State<CardapioInserirProduto> createState() => _CardapioInserirProdutoState();
}

class _CardapioInserirProdutoState extends State<CardapioInserirProduto> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  int? selectedCategoriaId;
  bool showSuccess = false;
  bool showError = false;

  Future<void> _inserirProduto() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.31.64.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    final url = Uri.parse('$baseUrl/products');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'name': nameController.text,
      'price': priceController.text,
      'categoryId': selectedCategoriaId
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201) {
      setState(() {
        showSuccess = true;
      });

      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final newProduto = Produto.fromJson(jsonData);

      final provider = Provider.of<AppProvider>(context, listen: false);
      provider.addProduto(newProduto);
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
      appBar: const CustomAppBar(
        title: 'Inserir Produto',
        backDestination: Cardapio(),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            HapticFeedback.heavyImpact();
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome do Produto',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: priceController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Preço do Produto',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<int>(
                          itemHeight: 60,
                          dropdownColor: Colors.grey[800],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          value: selectedCategoriaId,
                          onChanged: (value) {
                            setState(() {
                              selectedCategoriaId = value;
                              showSuccess = false;
                            });
                          },
                          items: widget.categorias.map((categoria) {
                            return DropdownMenuItem<int>(
                              value: categoria.id,
                              child: Text(
                                  '${categoria.name} (${categoria.position})'),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Selecionar Categoria',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(220, 90)),
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            _inserirProduto();
                            FocusScope.of(context).unfocus();
                          },
                          child: const Text(
                            'Inserir Produto',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (showSuccess)
                  const Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 100,
                        color: Colors.green,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Produto inserido!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                if (showError)
                  const Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 100,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Erro ao inserir produto!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

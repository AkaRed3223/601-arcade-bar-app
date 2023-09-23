import 'dart:convert';

import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../entities/categoria.dart';
import '../../providers/provider.dart';
import 'cardapio.dart';

class CardapioInserirCategoria extends StatefulWidget {
  const CardapioInserirCategoria({super.key});

  @override
  State<CardapioInserirCategoria> createState() =>
      _CardapioInserirCategoriaState();
}

class _CardapioInserirCategoriaState extends State<CardapioInserirCategoria> {
  final TextEditingController nameController = TextEditingController();

  bool showSuccess = false;
  bool showError = false;

  Future<void> _inserirCategoria() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.26.128.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    final url = Uri.parse('$baseUrl/categories');
    final headers = {'Content-Type': 'application/json'};
    final body = {'name': nameController.text};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201) {
      setState(() {
        showSuccess = true;
      });

      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final newCategoria = Categoria.fromJson(jsonData);

      final provider = Provider.of<AppProvider>(context, listen: false);
      provider.addCategoria(newCategoria);

      //await Future.delayed(const Duration(seconds: 1));

      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Cardapio(),
        ),
      );*/
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
        title: 'Inserir Categoria',
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome da Categoria',
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
                      const SizedBox(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(220, 90)),
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          _inserirCategoria();
                          FocusScope.of(context).unfocus();
                        },
                        child: const Text(
                          'Inserir Categoria',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Text('Categoria criada!',
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
                      Text('Erro ao criar categoria!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
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

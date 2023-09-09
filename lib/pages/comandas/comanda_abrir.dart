import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widgets/custom_app_bar_widget.dart';

class ComandaAbrir extends StatefulWidget {
  const ComandaAbrir({super.key});

  @override
  State<ComandaAbrir> createState() => _ComandaAbrirState();
}

class _ComandaAbrirState extends State<ComandaAbrir> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool showSuccess = false;
  bool showError = false;

  Future<void> _abrirComanda() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    final url = Uri.parse('https://arcade-bar-backend.rj.r.appspot.com/tabs');
    final headers = { 'Content-Type': 'application/json' };
    final body = {'externalId': idController.text, 'name': nameController.text};

    final response = await http.post(url,headers: headers,body: jsonEncode(body));

    if (response.statusCode == 201) {
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
      appBar: const CustomAppBar(title: 'Abrir Comanda'),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                  child: Column(
                    children: [
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: idController,
                        decoration: const InputDecoration(
                          labelText: 'Número da Comanda',
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
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Cliente',
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
                          _abrirComanda();
                          FocusScope.of(context).unfocus();
                        },
                        child: const Text(
                          'Abrir Comanda',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      Text(
                          'Comanda criada!',
                          style: TextStyle(
                              fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
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
                          'Erro ao abrir comanda!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )
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

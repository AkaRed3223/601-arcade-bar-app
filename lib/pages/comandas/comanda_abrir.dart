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

  Future<void> _abrirComanda() async {
    final url = Uri.parse('http://localhost:8080/tabs');
    final headers = {'Content-Type': 'application/json'}; // Set the content type to JSON
    final body = {'externalId': idController.text, 'name': nameController.text};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body), // Convert the body map to a JSON string
    );

    if (response.statusCode == 201) {
      setState(() {
        showSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Abrir Comanda'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showSuccess)
              const Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text('Comanda criada!', style: TextStyle(fontSize: 20)),
                ],
              )
            else
              Column(
                children: [
                  TextField(
                    controller: idController,
                    decoration: const InputDecoration(labelText: 'ID'),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _abrirComanda,
                    child: const Text('Abrir Comanda'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }


}

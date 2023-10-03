import 'dart:convert';

import 'package:arcade/pages/comandas/comandas_home.dart';
import 'package:arcade/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../entities/comanda.dart';
import '../../providers/provider.dart';
import '../../widgets/custom_app_bar_widget.dart';

class ComandaAbrir extends StatefulWidget {
  const ComandaAbrir({super.key});

  @override
  State<ComandaAbrir> createState() => _ComandaAbrirState();
}

class _ComandaAbrirState extends State<ComandaAbrir> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool showSuccess = false;
  bool showError = false;
  late Comanda currentComanda;

  Future<void> _abrirComanda() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.31.48.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    final url = Uri.parse('$baseUrl/tabs');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'externalId': idController.text,
      'name': nameController.text,
      'phone': phoneController.text
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201) {
      setState(() {
        showSuccess = true;
      });

      final responseBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(responseBody);
      final newComanda = Comanda.fromJson(jsonData);

      final provider = Provider.of<AppProvider>(context, listen: false);
      provider.addComanda(newComanda);

      setState(() {
        currentComanda = newComanda;
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
      appBar: const CustomAppBar(
        title: 'Abrir Comanda',
        backDestination: ComandasHome(),
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Column(
                    children: [
                      TextInputWidget(
                          controller: idController,
                          label: 'Número da Comanda'
                      ),
                      TextInputWidget(
                          controller: nameController,
                          label: 'Nome'
                      ),
                      TextInputWidget(
                          controller: phoneController,
                          label: 'Telefone'
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(220, 90)),
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            _abrirComanda();
                            FocusScope.of(context).unfocus();
                          },
                          child: const Text(
                            'Abrir Comanda',
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
                      SizedBox(height: 12),
                      Text('Comanda criada!',
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
                      Text('Erro ao abrir comanda!',
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

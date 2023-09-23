import 'package:arcade/pages/cardapio/cardapio.dart';
import 'package:arcade/pages/comandas/comandas_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../widgets/reusable_main_buttons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showSuccess = false;
  bool showError = false;

  Future<void> initiateOperation() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.26.128.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    final response = await http.post(
      Uri.parse('$baseUrl/operations/initiate'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

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

  Future<void> closeoutOperation() async {
    setState(() {
      showSuccess = false;
      showError = false;
    });

    // const String baseUrl = 'http://localhost:8080';
    // const String baseUrl = 'http://172.26.128.1:8080';
    const String baseUrl = 'http://3.137.160.128:8080';

    final response = await http.post(
      Uri.parse('$baseUrl/operations/closeout'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

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
      appBar: AppBar(
        title: const Text('601 Arcade Bar - Home Page'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 2,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ReusableMainButtons(title: 'Comandas', destination: ComandasHome()),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ReusableMainButtons(title: 'Cardápio', destination: Cardapio()),
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onLongPress: _showCloseoutOperationDialog,
              child: Container(
                color: Colors.redAccent,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'ENCERRAR OPERAÇÃO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onLongPress: _showInitiateOperationDialog,
              child: Container(
                color: Colors.greenAccent,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'INICIAR OPERAÇÃO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInitiateOperationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja iniciar a operação de hoje?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () async {
                HapticFeedback.heavyImpact();
                await initiateOperation();
                Navigator.of(context).pop();
                if (showSuccess) {
                  setState(() {
                    _buildSnackbar(Colors.green, 'OPERAÇÃO INICIADA!');
                  });
                }
                if (showError) {
                  setState(() {
                    _buildSnackbar(Colors.red, 'PROBLEMA AO INICIAR OPERAÇÃO!');
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCloseoutOperationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja encerrar a operação de hoje?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                HapticFeedback.heavyImpact();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () async {
                HapticFeedback.heavyImpact();
                await closeoutOperation();
                Navigator.of(context).pop();
                if (showSuccess) {
                  setState(() {
                    _buildSnackbar(Colors.green, 'OPERAÇÂO ENCERRADA!');
                  });
                }
                if (showError) {
                  setState(() {
                    _buildSnackbar(Colors.red, 'PROBLEMA AO ENCERRAR OPERAÇÃO!');
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  _buildSnackbar(Color color, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
      duration: const Duration(seconds: 2),
    ));
  }
}

import 'package:flutter/material.dart';

import '../widgets/custom_app_bar_widget.dart';

class ComandaDetails extends StatelessWidget {
  const ComandaDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments ?? 0;
    double fontSize = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Detalhes da Comanda'),
      body: Center(
        child: Text(
          'Detalhes da Comanda: $id',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

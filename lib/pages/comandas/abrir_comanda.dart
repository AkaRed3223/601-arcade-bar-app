import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar_widget.dart';

class ComandaAbrir extends StatelessWidget {
  const ComandaAbrir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: 'Abrir Comanda'),
    );
  }
}

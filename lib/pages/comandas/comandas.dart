import 'package:arcade/entities/comanda.dart';
import 'package:flutter/material.dart';

import '../../widgets/comanda_widget.dart';
import '../../widgets/custom_app_bar_widget.dart';

class Comandas extends StatefulWidget {
  const Comandas({super.key});

  @override
  State<Comandas> createState() => _ComandasState();
}

class _ComandasState extends State<Comandas> {
  late Future<List<Comanda>> futureComandas;
  late List<Comanda> loadedComandas = [];

  @override
  void initState() {
    super.initState();
    futureComandas = ComandasService().fetchComandas();
    _loadData();
  }

  Future<void> _loadData() async {
    loadedComandas = await futureComandas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.wait([futureComandas]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: const CustomAppBar(title: 'Todas as Comandas'),
            body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0),
                itemCount: loadedComandas.length,
                itemBuilder: (BuildContext context, int index) {
                  return ComandaWidget(guestTab: loadedComandas[index]);
                }),
          );
        }
      },
    );
  }
}

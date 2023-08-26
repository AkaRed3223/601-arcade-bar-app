import 'package:flutter/material.dart';

import '../entities/comanda_dto.dart';

class ComandaWidget extends StatelessWidget {
  final Comanda guestTab;

  const ComandaWidget({super.key, required this.guestTab});

  @override
  Widget build(BuildContext context) {
    Container comandaWidget = Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(guestTab.nome,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text("${guestTab.id}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Total: R\$ ${guestTab.total.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  color: Colors.white)),
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'comandas/{id}',
            arguments: {'id': guestTab.id});
      },
      child: comandaWidget,
    );
  }
}

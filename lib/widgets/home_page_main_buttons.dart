import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HomeButton({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () {
        if (title == 'Comandas') {
          Navigator.pushNamed(context, 'comandas');
        } else if (title == 'Cardápio') {
          Navigator.pushNamed(context, 'cardapio');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(50.0),
        color: Colors.grey,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black87
            ),
          ),
        ),
      ),
    );
  }
}

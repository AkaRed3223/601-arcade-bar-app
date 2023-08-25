import 'package:arcade/widgets/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/home_page_main_buttons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var scaffold = Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const CustomAppBar(title: '601 Arcade Bar'),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HomeButton(title: 'Comandasss'),
          HomeButton(title: 'Cardápio'),
        ],
      ),
    );

    return scaffold;
  }
}

/*drawer: Drawer(
        backgroundColor: Colors.blueGrey[800],
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                "Comandas",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "comandas");
              },
            ),
            ListTile(
              title: const Text(
                "Cardápio",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "cardapio");
              },
            ),
          ],
        ),
      ),*/

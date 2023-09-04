import 'package:flutter/material.dart';

class ReusableFAB extends StatelessWidget {
  final String text;
  final Widget Function(BuildContext) builder;
  final IconData iconData;

  const ReusableFAB({
    Key? key,
    required this.text,
    required this.builder,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: builder),
        );
      },
      backgroundColor: Colors.grey[800],
      icon: Icon(iconData),
      label: Text(text),
    );
  }
}
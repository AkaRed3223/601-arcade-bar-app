import 'package:flutter/material.dart';

class ReusableFAB extends StatelessWidget {
  final String text;
  final Widget Function(BuildContext) builder;
  final IconData iconData;
  final String tag;

  const ReusableFAB({
    Key? key,
    required this.text,
    required this.builder,
    required this.iconData,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FloatingActionButton.extended(
        heroTag: tag,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: builder),
          );
        },
        backgroundColor: Colors.grey[800],
        icon: Icon(iconData),
        label: Text(text),
      ),
    );
  }
}

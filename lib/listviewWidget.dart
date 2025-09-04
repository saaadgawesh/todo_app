import 'package:flutter/material.dart';
import 'package:todo_app/appthem.dart';

class ListTilewidget extends StatelessWidget {
  const ListTilewidget({
    super.key,
    required this.leadingicon,
    required this.trailingicon,
    required this.text,
  });

  final IconData leadingicon;
  final IconData trailingicon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingicon, color: Appthem.primary),
      title: Text(text, style: TextStyle(color: Appthem.primary)),
      trailing: Icon(trailingicon, color: Appthem.primary),
    );
  }
}

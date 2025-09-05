import 'package:flutter/material.dart';
import 'package:todo_app/view/widget/appthem.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton({
    super.key,
    required this.label,
    required this.onpress,
  });

  final String label;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Appthem.backgroundlight,
        fixedSize: Size(MediaQuery.of(context).size.width, 52),
        shape: RoundedRectangleBorder(
          // ✅ هنا التعديل
          borderRadius: BorderRadius.circular(12), // لو عايز كورنر راوند
          side: const BorderSide(color: Appthem.primary, width: 2),
        ),
      ),
      onPressed: onpress,
      child: Text(
        label,
        style: text.titleLarge?.copyWith(color: Appthem.primary),
      ),
    );
  }
}

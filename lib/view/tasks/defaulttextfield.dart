import 'package:flutter/material.dart';
import 'package:todo_app/appthem.dart';

class Defaulttextfield extends StatefulWidget {
Defaulttextfield({
  super.key,
  required this.controller,
  this.ispassword = false,
  required this.label,
  this.validator,
  this.maxlines = 1,
});

final TextEditingController controller;
final String label;
final bool ispassword;
final int? maxlines;
final String? Function(String?)? validator;

  @override
  State<Defaulttextfield> createState() => _DefaulttextfieldState();
}

class _DefaulttextfieldState extends State<Defaulttextfield> {
  bool isobserved = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon:widget.ispassword? IconButton(
          icon: Icon(
            isobserved ? Icons.visibility_off : Icons.visibility,
          ),style:const ButtonStyle(iconColor: WidgetStatePropertyAll(Appthem.primary)),
          onPressed: () {
            // Toggle the isobserved state
            setState(() {
              isobserved = !isobserved;
            });
          },
        ):null,

        hintText: widget.label,hintStyle:TextStyle(
          color:Appthem.primary.withValues(alpha: 0.5)
        )
      ),
      maxLines: widget.maxlines,
      textCapitalization: TextCapitalization.sentences,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText:isobserved,
    style: TextStyle(color: Appthem.primary),
    );

  }
}

import 'package:flutter/material.dart';

class FieldForText extends StatelessWidget {
  String hintText, type, fieldvalue;
  FieldForText(
    this.type,
    this.hintText,
    this.fieldvalue,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.green[100]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          cursorColor: Colors.green,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          validator: (value) {
            return value.isEmpty ? 'Please Add a $type' : null;
          },
          onSaved: (value) {
            return fieldvalue = value;
          },
        ),
      ),
    );
  }
}

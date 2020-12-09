import 'package:flutter/material.dart';
import 'package:todofirebase/components/theme_color.dart';
import 'text_field_container.dart';
//import 'package:iiitk_app/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (value) {
          return value.isEmpty ? "$hintText is Required" : null;
        },
        controller: controller,
        onChanged: onChanged,
        cursorColor: primayColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primayColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

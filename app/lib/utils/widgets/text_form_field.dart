import 'package:app/utils/validators/required_validator.dart';
import 'package:app/utils/validators/type_helpers.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final ValidatorCall? validator;
  final EdgeInsets padding;
  final InputBorder border;
  final Widget? suffixIcon;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.validator = requiredValidator,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.border = const OutlineInputBorder(),
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: border,
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
      ),
    );
  }
}

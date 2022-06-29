import 'package:dummy_trade/constants/style.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class PasswordEditText extends StatelessWidget {
  final bool showText;
  final String hint;
  final TextInputType inputType;
  final TextEditingController controller;
  final VoidCallback onPressed;
  final Iterable<String>? autofillHint;
  final VoidCallback? onEditComplete;

  const PasswordEditText({Key? key,
    required this.showText,
    required this.hint,
    required this.inputType,
    required this.controller, required this.onPressed,required this.autofillHint, this.onEditComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
      kEmailEditTextDecoration.copyWith(hintText: hint,
          labelText: hint,
          suffixIcon: IconButton(onPressed: onPressed, icon:Icon(showText ?Icons.visibility_off:Icons.visibility))),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      obscureText: showText,
      controller: controller,
      autofillHints: autofillHint,
      //use to validate email
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>value != null && value.length < 6
            ? "Enter min. 6 characters"
            :  null
      ,
      onEditingComplete: onEditComplete,
    );
  }
}

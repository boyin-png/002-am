import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final FocusNode focusNode;
  final void Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;
  final bool isPassword;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.focusNode,
    required this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _isObscured,
      decoration: InputDecoration(
        labelText: widget.labelText,
        // Solo muestra el ícono si es un campo de contraseña.
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
    );
  }
}

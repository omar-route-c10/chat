import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    required this.controller,
    this.validator,
    this.hintText,
    this.labelText,
    this.maxLines = 1,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final int maxLines;
  final bool isPassword;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        label: widget.labelText != null
            ? Text(
                widget.labelText!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() => isObscure = !isObscure),
                icon: isObscure
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(Icons.visibility_off_outlined),
              )
            : null,
      ),
      obscureText: widget.isPassword ? isObscure : false,
      maxLines: widget.maxLines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

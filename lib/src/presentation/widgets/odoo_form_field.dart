import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';

class OdooFormField<T> extends StatelessWidget {
  const OdooFormField({
    super.key,
    this.controller,
    this.hint,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final String? Function(String?)? validator;
  final  ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        border: _inputBorder(context),
        enabledBorder: _inputBorder(context),
        disabledBorder: _inputBorder(context),
        focusedBorder: _inputBorder(context),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }

  InputBorder _inputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

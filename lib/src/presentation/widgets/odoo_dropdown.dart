import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_icons.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';

class OdooDropdown<T> extends StatelessWidget {
  const OdooDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    required this.hint,
  });

  final List<T> items;
  final Function(T?) onChanged;
  final T? selectedValue;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      validator: (s){
        if(selectedValue == null){
          return AppStrings.of(context).requiredField;
        }
        return null;
      },
      hint: OdooText(hint, style: Theme.of(context).textTheme.bodyLarge,),
      decoration: InputDecoration(
        border: _inputBorder(context),
        enabledBorder: _inputBorder(context),
        disabledBorder: _inputBorder(context),
        focusedBorder: _inputBorder(context),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
      icon: Icon(
        AppIcons.chevron_down,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      items: items
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: OdooText(
                  e.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ))
          .toList(),
      onChanged: onChanged,
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

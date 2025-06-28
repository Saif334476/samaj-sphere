import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final List<String> options;
  final void Function(String) onChanged;
  final String? errorText;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selectedValue?.isEmpty ?? true ? null : selectedValue,
        items: options
            .map((opt) => DropdownMenuItem<String>(
          value: opt,
          child: Text(opt),
        ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          filled: true,
          fillColor: isDark ? Colors.grey[900] : Colors.grey[200],
          labelStyle: TextStyle(
            color: isDark ? Colors.white70 : Colors.black87,
          ),
          errorStyle: const TextStyle(color: Colors.redAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 1.8,
            ),
          ),
        ),
      ),
    );
  }
}

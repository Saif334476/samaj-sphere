import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController? controller;
  final String? initialValue;
  final void Function(String value)? onChanged;
  final String? errorText;
  final TextInputType keyboardType;
  final bool readOnly;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.suffixIcon,
  }) : assert(controller == null || initialValue == null,
  'Cannot provide both a controller and an initialValue');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        obscureText: isPassword,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: readOnly
              ? (isDark ? Colors.grey[850] : Colors.grey[300])
              : (isDark ? Colors.grey[900] : Colors.grey[200]),
          labelStyle: TextStyle(
            color: isDark ? Colors.white70 : Colors.black87,
          ),
          errorStyle: const TextStyle(color: Colors.redAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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

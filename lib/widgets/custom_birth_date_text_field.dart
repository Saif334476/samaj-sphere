import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BirthDateField extends StatelessWidget {
  final RxString dateValue;
  final RxnString errorValue;
  final void Function(String date) onDatePicked;

  const BirthDateField({
    super.key,
    required this.dateValue,
    required this.errorValue,
    required this.onDatePicked,
  });

  Future<void> _pickDate(BuildContext context) async {
    final initialDate = dateValue.value.isNotEmpty
        ? DateFormat.yMd().parse(dateValue.value)
        : DateTime.now().subtract(const Duration(days: 365 * 20));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (ctx, child) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        final scheme = Theme.of(ctx).colorScheme;
        return Theme(
          data: isDark
              ? ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: scheme.primary,
              onPrimary: scheme.onPrimary,
              onSurface: scheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: scheme.primary),
            ),
          )
              : ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: scheme.primary,
              onPrimary: scheme.onPrimary,
              onSurface: scheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: scheme.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDatePicked(DateFormat.yMd().format(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        readOnly: true,
        onTap: () => _pickDate(context),
        controller: TextEditingController(text: dateValue.value),
        decoration: InputDecoration(
          labelText: "Birth Date",
          errorText: errorValue.value,
          suffixIcon: const Icon(Icons.calendar_month),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900]
              : Colors.grey[200],
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      );
    });
  }
}

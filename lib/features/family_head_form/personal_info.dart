import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:samaj_sphere/features/family_head_form/head_form_controller.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';
import '../../widgets/custom_birth_date_text_field.dart';
import '../../widgets/custom_dropdown.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});

  final HeadFormController controller = Get.find();

  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  //
  // Future<void> _pickDate(BuildContext context) async {
  //   final initialDate = controller.birthDate.value.isNotEmpty
  //       ? DateFormat.yMd().parse(controller.birthDate.value)
  //       : DateTime.now().subtract(const Duration(days: 365 * 20));
  //
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //     builder: (ctx, child) {
  //       final isDark = Theme.of(ctx).brightness == Brightness.dark;
  //       return Theme(
  //         data: isDark
  //             ? ThemeData.dark().copyWith(
  //           colorScheme: ColorScheme.dark(
  //             primary: Theme.of(ctx).colorScheme.primary,
  //             onPrimary: Theme.of(ctx).colorScheme.onPrimary,
  //             onSurface: Theme.of(ctx).colorScheme.onSurface,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: Theme.of(ctx).colorScheme.primary,
  //             ),
  //           ),
  //         )
  //             : ThemeData.light().copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: Theme.of(ctx).colorScheme.primary,
  //             onPrimary: Theme.of(ctx).colorScheme.onPrimary,
  //             onSurface: Theme.of(ctx).colorScheme.onSurface,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: Theme.of(ctx).colorScheme.primary,
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (picked != null) {
  //     controller.updateFieldAndClearError(
  //       'birthDate',
  //       DateFormat.yMd().format(picked),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Obx(
                      () => CustomDropdownField(
                    label: "Marital Status",
                    selectedValue: controller.maritalStatus.value,
                    options: const [
                      "Married",
                      "Unmarried",
                      "Divorced",
                      "Widowed",
                    ],
                    errorText: controller.maritalStatusError.value,
                    onChanged: (value) {
                      controller.updateFieldAndClearError('maritalStatus', value);
                    },
                  ),
                ),
                Obx(() => CustomTextField(
                  label: "Qualification",
                  initialValue: controller.qualification.value,
                  errorText: controller.qualificationError.value,
                  onChanged: (v) => controller.updateFieldAndClearError('qualification', v),
                )),
                 BirthDateField(
                  dateValue: controller.birthDate,
                  errorValue: controller.birthDateError,
                  onDatePicked: (value) =>
                      controller.updateFieldAndClearError('birthDate', value),
                ),
                const SizedBox(height: 16),
                CustomDropdownField(
                  label: "Blood Group",
                  selectedValue: controller.bloodGroup.value,
                  options: bloodGroups,
                  onChanged: (val) {
                    controller.updateFieldAndClearError('bloodGroup', val);
                  },
                ),
                if (controller.bloodGroupError.value != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 12),
                    child: Text(
                      controller.bloodGroupError.value!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            );
          }),
          const SizedBox(height: 16),
          Obx(() {
            return CustomTextField(
              label: "Exact Nature of Duties",
              initialValue: controller.natureOfDuties.value,
              onChanged: (v) =>
                  controller.updateFieldAndClearError('natureOfDuties', v),
              errorText: controller.natureOfDutiesError.value,
            );
          }),
        ],
      ),
    );
  }
}

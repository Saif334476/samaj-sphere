import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';
import 'package:samaj_sphere/features/family_member_form/family_member_form_controller.dart';
import '../../widgets/custom_birth_date_text_field.dart';
import '../../widgets/custom_dropdown.dart';

class FamilyPersonalInfoStep extends StatelessWidget {
  FamilyPersonalInfoStep({super.key});

  final FamilyMemberFormController controller = Get.find();
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


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => CustomTextField(
            label: "Age",
            keyboardType: TextInputType.number,
            initialValue: controller.age.value,
            onChanged: (v) => controller.updateFieldAndClearError('age', v),
            errorText: controller.ageError.value,
          )),
          BirthDateField(
            dateValue: controller.birthDate,
            errorValue: controller.birthDateError,
            onDatePicked: (value) =>
                controller.updateFieldAndClearError('birthDate', value),
          ),
          const SizedBox(height: 16),
          Obx(() => CustomDropdownField(
            label: "Blood Group",
            selectedValue: controller.bloodGroup.value,
            options: bloodGroups,
            onChanged: (val) {
              controller.updateFieldAndClearError('bloodGroup', val);
            },
          ),),
          Obx(() => CustomTextField(
            label: "Qualification",
            initialValue: controller.qualification.value,
            onChanged: (v) => controller.updateFieldAndClearError('qualification', v),
            errorText: controller.qualificationError.value,
          )),
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
            label: "Exact Nature of Duties",
            initialValue: controller.natureOfDuties.value,
            onChanged: (v) => controller.updateFieldAndClearError('natureOfDuties', v),
            errorText: controller.natureOfDutiesError.value,
          )),
          // Obx(() => CustomTextField(
          //   label: "Medical Conditions",
          //   initialValue: controller.medicalCondition.value,
          //   onChanged: (v) => controller.updateField('medicalCondition', v),
          //   errorText: controller.medicalConditionError.value,
          // )),
        ],
      ),
    );
  }
}

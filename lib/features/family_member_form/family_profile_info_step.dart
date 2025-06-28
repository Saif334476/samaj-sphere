import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';
import '../../widgets/custom_dropdown.dart';
import 'family_member_form_controller.dart';

class FamilyProfileInfoStep extends StatelessWidget {
  FamilyProfileInfoStep({super.key});
  final FamilyMemberFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(() {
            final imagePath = controller.avatarImagePath.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage:
                      imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
                      child: imagePath.isEmpty
                          ? const Icon(Icons.person, size: 50, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: InkWell(
                        onTap: controller.pickAvatarImage,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: const Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                if (controller.avatarImageError.value != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      controller.avatarImageError.value!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            );
          }),
          Obx(() => CustomTextField(
            label: "First Name",
            initialValue: controller.firstName.value,
            onChanged: (v) => controller.updateFieldAndClearError('firstName', v),
            errorText: controller.firstNameError.value,
          )),
          Obx(() => CustomTextField(
            label: "Middle Name",
            initialValue: controller.middleName.value,
            onChanged: (v) => controller.updateFieldAndClearError('middleName', v),
            errorText: controller.middleNameError.value,
          )),
          Obx(() => CustomTextField(
            label: "Last Name",
            initialValue: controller.lastName.value,
            onChanged: (v) => controller.updateFieldAndClearError('lastName', v),
            errorText: controller.lastNameError.value,
          )),

          Obx(() => CustomDropdownField(
            label: "Gender",
            selectedValue: controller.gender.value,
            options: const ["Male", "Female", "Other"],
            errorText: controller.genderError.value,
            onChanged: (v) => controller.updateField('gender', v),
          )),


          Obx(() => CustomTextField(
            label: "Occupation",
            initialValue: controller.occupation.value,
            onChanged: (v) => controller.updateFieldAndClearError('occupation', v),
            errorText: controller.occupationError.value,
          )),

          Obx(() => CustomTextField(
            label: "Relation with Family Head",
            initialValue: controller.relation.value,
            onChanged: (v) => controller.updateFieldAndClearError('relation', v),
            errorText: controller.relationError.value,
          )),
        ],
      ),
    );
  }
}

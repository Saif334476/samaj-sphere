import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/features/family_head_form/head_form_controller.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';
import '../../widgets/custom_dropdown.dart';

class ProfileInfoScreen extends StatelessWidget {
  ProfileInfoScreen({super.key});

  final HeadFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: controller.avatarImagePath.value.isNotEmpty
                        ? FileImage(File(controller.avatarImagePath.value))
                        : null,
                    child: controller.avatarImagePath.value.isEmpty
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
                        child: const Icon(Icons.edit,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
          ),
          Obx(() => controller.avatarImageError.value != null
              ? Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              controller.avatarImageError.value!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          )
              : const SizedBox.shrink()),
          const SizedBox(height: 24),
          Obx(() => CustomTextField(
                label: "Full Name",
                initialValue: controller.name.value,
                errorText: controller.nameError.value,
                onChanged: (v) =>
                    controller.updateFieldAndClearError('name', v),
              )),
          Obx(() => CustomTextField(
                label: "Age",
                initialValue: controller.age.value,
                keyboardType: TextInputType.number,
                errorText: controller.ageError.value,
                onChanged: (v) => controller.updateFieldAndClearError('age', v),
              )),
          Obx(() => CustomDropdownField(
                label: "Gender",
                selectedValue: controller.gender.value,
                options: const ["Male", "Female", "Other"],
                errorText: controller.genderError.value,
                onChanged: (v) =>
                    controller.updateFieldAndClearError('gender', v),
              )),
          Obx(() {
            final options = controller.samajList.toSet().toList();
            final value = controller.samajName.value;
            return CustomDropdownField(
              label: "Samaj Name",
              selectedValue: controller.samajName.value,
              options: options,
              errorText: controller.samajNameError.value,
              onChanged: (v) =>
                  controller.updateFieldAndClearError('samajName', v),
            );
          }),
          Obx(() => CustomTextField(
                label: "Occupation",
                initialValue: controller.occupation.value,
                errorText: controller.occupationError.value,
                onChanged: (v) =>
                    controller.updateFieldAndClearError('occupation', v),
              )),
        ],
      ),
    );
  }
}

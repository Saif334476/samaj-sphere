import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';
import 'package:samaj_sphere/features/family_member_form/family_member_form_controller.dart';

class FamilyContactInfoStep extends StatelessWidget {
  FamilyContactInfoStep({super.key});

  final FamilyMemberFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => CustomTextField(
            label: "Phone Number",
            keyboardType: TextInputType.phone,
            initialValue: controller.contactPhone.value,
            onChanged: (v) => controller.updateFieldAndClearError('contactPhone', v),
            errorText: controller.contactPhoneError.value,
          )),
          Obx(() => CustomTextField(
            label: "Alternate Number",
            keyboardType: TextInputType.phone,
            initialValue: controller.contactAlternate.value,
            onChanged: (v) => controller.updateFieldAndClearError('contactAlternate', v),
            errorText: controller.contactAlternateError.value,
          )),
          Obx(() => CustomTextField(
            label: "Landline Number",
            keyboardType: TextInputType.phone,
            initialValue: controller.contactLandline.value,
            onChanged: (v) => controller.updateFieldAndClearError('contactLandline', v),
            errorText: controller.contactLandlineError.value,
          )),
          Obx(() => CustomTextField(
            label: "Email",
            keyboardType: TextInputType.emailAddress,
            initialValue: controller.contactEmail.value,
            onChanged: (v) => controller.updateFieldAndClearError('contactEmail', v),
            errorText: controller.contactEmailError.value,
          )),

        ],
      ),
    );
  }
}

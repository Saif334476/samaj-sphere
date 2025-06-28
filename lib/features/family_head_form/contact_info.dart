import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/features/family_head_form/head_form_controller.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';

class ContactInfoScreen extends StatelessWidget {
  ContactInfoScreen({super.key});

  final HeadFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return  SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Obx(() {
              return CustomTextField(
                label: "Email ID",
                initialValue: controller.contactEmail.value,
                onChanged: (v) =>
                    controller.updateFieldAndClearError('contactEmail', v),
                keyboardType: TextInputType.emailAddress,
                errorText: controller.contactEmailError.value,
              );
            }),

            Obx(() {
              return CustomTextField(
                label: "Phone Number",
                initialValue: controller.contactPhone.value,
                onChanged: (v) =>
                    controller.updateFieldAndClearError('contactPhone', v),
                keyboardType: TextInputType.phone,
                readOnly: true,
                errorText: controller.contactPhoneError.value,
              );
            }),

            CustomTextField(
              label: "Alternative Number",
              initialValue: controller.contactAlternate.value,
              onChanged: (v) =>
                  controller.updateFieldAndClearError('contactAlternate', v),
              keyboardType: TextInputType.phone,
            ),

            CustomTextField(
              label: "Landline Number",
              initialValue: controller.contactLandline.value,
              onChanged: (v) =>
                  controller.updateFieldAndClearError('contactLandline', v),
              keyboardType: TextInputType.phone,
            ),
            CustomTextField(
              label: "Social Media Link",
              initialValue: controller.contactSocial.value,
              onChanged: (v) =>
                  controller.updateFieldAndClearError('contactSocial', v),
              keyboardType: TextInputType.url,
            ),
          ],
        ),

    );
  }
}

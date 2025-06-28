import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/features/family_head_form/address_info.dart';
import 'package:samaj_sphere/features/family_head_form/contact_info.dart';
import 'package:samaj_sphere/features/family_head_form/head_form_controller.dart';
import 'package:samaj_sphere/features/family_head_form/personal_info.dart';
import 'package:samaj_sphere/features/family_head_form/preview_submit.dart';
import 'package:samaj_sphere/features/family_head_form/profile_info.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/custom_stepper.dart';
import '../dashboard/dashboard.dart';


class HeadFormNavigatorScreen extends StatelessWidget {
  HeadFormNavigatorScreen({super.key});
  final controller = Get.put(HeadFormController());

  final List<Widget> steps = [
    ProfileInfoScreen(),
    PersonalInfoScreen(),
    ContactInfoScreen(),
    AddressInfoScreen(),
    SummarySubmitScreen(),
  ];

  final List<String> stepTitles = [
    'Profile',
    'Personal',
    'Contact',
    'Address',
    'Review',
  ];

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final phone =
        args != null && args['phone'] != null ? args['phone'] as String : '';
    final theme = Theme.of(context);

    if (phone.isNotEmpty && controller.contactPhone.value.isEmpty) {
      controller.updateField('contactPhone', phone);
    }
    print(phone);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 600,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                            child: CustomVerticalStepper(
                          titles: stepTitles,currentStep: controller.currentStep,
                          //currentStep: controller.currentStep,
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child:
                                Obx(() => steps[controller.currentStep.value]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),


              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.currentStep.value > 0)
                        OutlinedButton(
                          onPressed: controller.previousStep,
                          child: const Text('Back'),
                        )
                      else
                        const SizedBox(width: 100),
                      SizedBox(width: 100,
                        child: CustomButton(
                          isLoading: controller.isLoading.value,
                          backgroundColor: const Color(0xFF12559F),
                          dotColor: Colors.white,
                          label: controller.currentStep.value == steps.length - 1
                              ? 'Submit'
                              : 'Next',
                          onPressed: ()async {
                            final current = controller.currentStep.value;
                            if (_validateStep(current)) {
                              if (current == steps.length - 1) {
                               await controller.submitHeadForm();
                                Get.offAll(() => const Dashboard());
                              } else {
                                controller.nextStep();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateStep(int stepIndex) {
    switch (stepIndex) {
      case 0:
        if (!controller.validateProfileFieldsIndividually()) {
          return false;
        }
        break;
      case 1:
        if (!controller.validatePersonalFields()) {
          return false;
        }
        break;
      case 2:
        if (!controller.validateContactFields()) {
          return false;
        }
        break;
      case 3:
        if (!controller.validateAddressFields()) {
          return false;
        }
        break;
    }
    return true;
  }
}

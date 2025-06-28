import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/widgets/custom_elevated_button.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/custom_stepper.dart';
import 'family_address_info_step.dart';
import 'family_contact_info_step.dart';
import 'family_member_form_controller.dart';
import 'family_personal_info_step.dart';
import 'family_profile_info_step.dart';


class FamilyMemberRegistrationScreen extends StatelessWidget {
  FamilyMemberRegistrationScreen({super.key});

  final FamilyMemberFormController controller =
  Get.put(FamilyMemberFormController());

  final List<Widget> steps = [
    FamilyProfileInfoStep(),
    FamilyPersonalInfoStep(),
    FamilyContactInfoStep(),
    FamilyAddressInfoStep(),
  ];

  final List<String> stepTitles = [
    'Profile',
    'Personal',
    'Contact',
    'Address',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height:20,),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.75,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 600,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text(
                                "Register a New Member",
                                style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Color(
                                    0xFF19578A))
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: CustomVerticalStepper(
                                      titles: stepTitles, currentStep: controller.currentStep,
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(() => steps[controller.currentStep.value]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
          
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
                    SizedBox(
                      width: 100,
                      child: CustomButton(
                        isLoading: controller.isLoading.value,
                        backgroundColor: const Color(0xFF12559F),
                        dotColor: Colors.white,
                        label: controller.currentStep.value == steps.length - 1
                            ? "Submit"
                            : "Next",
                        onPressed: () {
                          print("Button pressed...");
                          final current = controller.currentStep.value;
                          if (_validateStep(current)) {
                            print("Validation passed...");
                            if (current == steps.length - 1) {
                              print("Submitting form...");
                              controller.submitFamilyMemberForm();
                            } else {
                              controller.nextStep();
                            }
                          } else {
                            print("Validation failed.");
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
      ),
    );
  }

  bool _validateStep(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return controller.validateProfileStep();
      case 1:
        return controller.validatePersonalStep();
      case 2:
        return controller.validateContactStep();
      case 3:
        return controller.validateAddressStep();
      default:
        return false;
    }
  }
}

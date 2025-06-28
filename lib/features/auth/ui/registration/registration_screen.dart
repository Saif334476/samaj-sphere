import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:samaj_sphere/widgets/animated_button.dart';
import '../../controller/registration_controller.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                if (!isDark)
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset("assets/app_logo.png", height: 100),
                      const SizedBox(height: 16),
                      Text(
                        "Welcome to Samaj Sphere",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "We'll send you an OTP for verification",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onBackground.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                Obx(() => IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorText:
                            registrationController.phoneError.value.isEmpty
                                ? null
                                : registrationController.phoneError.value,
                      ),
                      initialCountryCode: 'PK',
                      onChanged: (phone) {
                        registrationController
                            .updatePhoneNumber(phone.completeNumber);
                      },
                      keyboardType: TextInputType.phone,
                      disableLengthCheck: true,
                    )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child:Obx(()=> CustomButton(
                    dotColor: Colors.white,
                    backgroundColor: const Color(0xFF12559F),
                    label: "Send OTP",
                    onPressed: () {  registrationController.sendOtp(isRegistration: true);},
                    isLoading: registrationController.isLoading.value,
                  )),
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     registrationController.sendOtp(isRegistration: true);
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(vertical: 14),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ).copyWith(
                  //     backgroundColor: MaterialStatePropertyAll(colorScheme.primary),
                  //     foregroundColor: MaterialStatePropertyAll(colorScheme.onPrimary),
                  //   ),
                  //   child: Text(
                  //     "Send OTP",
                  //     style: theme.textTheme.labelLarge?.copyWith(
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

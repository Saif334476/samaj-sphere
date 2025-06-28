import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:samaj_sphere/features/auth/ui/registration/registration_screen.dart';
import 'package:samaj_sphere/widgets/custom_elevated_button.dart';
import '../../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 700;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints:
                BoxConstraints(maxWidth: isDesktop ? 500 : double.infinity),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                if (theme.brightness == Brightness.light)
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App logo
                Image.asset(
                  "assets/app_logo.png",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 16),
                Text(
                  "Welcome to Wallet Hunter",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login using your phone number",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 32),

                Obx(() => IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorText: loginController.phoneError.value.isEmpty
                            ? null
                            : loginController.phoneError.value,
                      ),
                      initialCountryCode: 'PK', // Default Pakistan
                      onChanged: (phone) {
                        loginController.updatePhoneNumber(phone.completeNumber);
                      },
                      keyboardType: TextInputType.phone,
                      disableLengthCheck: true,
                      showDropdownIcon: true,
                    )),

                const SizedBox(height: 24),

                SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                        label: "Send Otp", onPressed: () {})),

                const SizedBox(height: 20),
                Text(
                  "You'll receive a code via SMS",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Get.to(const RegistrationScreen());
                  },
                  child: const Text("Don't have an account? Register here"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

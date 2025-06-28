import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:samaj_sphere/splash_screen.dart';
import 'features/auth/ui/registration/otp/otp_controller.dart';
import 'features/auth/ui/registration/otp/otp_screen.dart';
import 'features/auth/ui/registration/registration_screen.dart';
import 'features/dashboard/dashboard.dart';
import 'features/family_head_form/head_form_controller.dart';
import 'features/family_head_form/head_form_navigator_screen.dart';
import 'firebase_options.dart';
import 'app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        //GetPage(name: '/', page: () => const LoginScreen()),
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/registration', page: () => const RegistrationScreen()),
        GetPage(name: '/otp', page: () =>  OTPScreen()),
        GetPage(name: '/dashboard', page: () =>  const Dashboard()),
        GetPage(
          name: '/family-head-form',
          page: () => HeadFormNavigatorScreen(),
          binding: BindingsBuilder(() {
            Get.put(HeadFormController());
          }),
        ),

      ],
      debugShowCheckedModeBanner: false,
      title: 'Wallet Hunter',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

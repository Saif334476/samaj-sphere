import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:samaj_sphere/features/auth/ui/registration/registration_screen.dart';
import 'features/animated_dots.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override

  void initState() {
    super.initState();
    //seedSamajAndTemples();
    _timer = Timer(const Duration(seconds: 3), () async{
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {

        final userDoc = await FirebaseFirestore.instance
            .collection('family_heads')
            .doc(user.uid)
            .get();

        if (userDoc.exists && userDoc.data()?['isRegistrationCompleted'] == true) {
          Get.offAllNamed('/dashboard');
        } else {
          Get.offAllNamed('/registration');
        }
      } else {
        Get.offAllNamed('/registration');
      }
    });
  }

  //
  // Future<void> seedSamajAndTemples() async {
  //   final firestore = FirebaseFirestore.instance;
  //
  //   final samajs = [
  //     "Arya Samaj",
  //     "Brahmo Samaj",
  //     "Prajapati Samaj",
  //     "Prarthana Samaj",
  //     "Ramakrishna Mission",
  //     "Deva Samaj",
  //     "Aligarh Movement",
  //     "Seva Sadan Society",
  //   ];
  //
  //   final temples = [
  //     {
  //       "name": "Shore Temple",
  //       "location": "Mahabalipuram, Tamil Nadu",
  //       "samajList": ["Arya Samaj", "Brahmo Samaj"]
  //     },
  //     {
  //       "name": "Meenakshi Amman Temple",
  //       "location": "Madurai, Tamil Nadu",
  //       "samajList": ["Prarthana Samaj", "Ramakrishna Mission"]
  //     },
  //     {
  //       "name": "Sri Venkateswara Temple",
  //       "location": "Pittsburgh, USA",
  //       "samajList": ["Arya Samaj", "Deva Samaj"]
  //     },
  //     {
  //       "name": "Brihadeeswarar Temple",
  //       "location": "Thanjavur, Tamil Nadu",
  //       "samajList": ["Prajapati Samaj", "Brahmo Samaj"]
  //     },
  //   ];
  //
  //   for (final name in samajs) {
  //     await firestore.collection('samajs').add({"name": name});
  //   }
  //
  //   for (final temple in temples) {
  //     await firestore.collection('temples').add(temple);
  //   }
  //
  //   print("Samajs and Temples seeded successfully.");
  // }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, const Color(0xFF1B1B1B)]
                : [Colors.white, const Color(0xFFE8F5E9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(24),
                child: Image.asset(
                  "assets/app_logo.png",
                  fit: BoxFit.contain,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(height: 24),

              // App Title
              Text(
                "Samaj Sphere",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 16),


               const BouncingDots(),

              const SizedBox(height: 20),

              // Optional: Tagline
              Text(
                "Smart. Secure. Family-Driven.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

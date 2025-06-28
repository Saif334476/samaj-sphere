import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var otpCode = ''.obs;
  var verificationId = ''.obs;
  var phoneNumber = ''.obs;
  var isVerifying = false.obs;
  var secondsRemaining = 60.obs;
  var isResendEnabled = false.obs;

  void startTimer() {
    secondsRemaining.value = 60;
    isResendEnabled.value = false;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
        return true;
      } else {
        isResendEnabled.value = true;
        return false;
      }
    });
  }

  void verifyOTP() async {
    if (otpCode.value.length != 6) {
      Get.snackbar("Error", "Enter valid 6-digit code");
      return;
    }

    isVerifying.value = true;
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpCode.value,
      );
      await _auth.signInWithCredential(credential);
      Get.snackbar("Success", "Phone verified successfully");

      final userDoc = await FirebaseFirestore.instance
          .collection('family_heads')
          .doc(_auth.currentUser?.uid)
          .get();

      if (userDoc.exists && userDoc.data()?['isRegistrationCompleted'] == true) {
        Get.offAllNamed('/dashboard');
      } else {
        Get.offAllNamed('/family-head-form', arguments: {
          'phone': phoneNumber.value,
        });
      }

    } catch (e) {
      Get.snackbar("Error", "OTP verification failed");
    } finally {
      isVerifying.value = false;
    }
  }

  void resendOTP() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.value,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        Get.snackbar("Error", e.message ?? "OTP resend failed");
      },
      codeSent: (vId, _) {
        verificationId.value = vId;
        startTimer();
        Get.snackbar("Sent", "New OTP sent to ${phoneNumber.value}");
      },
      codeAutoRetrievalTimeout: (vId) {
        verificationId.value = vId;
      },
    );
  }

  void setData({required String phone, required String vId}) {
    print("✅ setData called with: phone = $phone, vId = $vId");
    phoneNumber.value = phone;
    verificationId.value = vId;
    startTimer();
  }
}

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final phoneNumber = ''.obs;
  final phoneError = ''.obs;

  void updatePhoneNumber(String value) => phoneNumber.value = value;


}

final loginController = Get.put(LoginController());

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samaj_sphere/models/profile_model.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var profileData = ProfileModel().obs;
  var isLoading = false.obs;
  final associatedTemples = <Map<String,dynamic>>[].obs;


  @override
  void onInit() {
    super.onInit();
    getProfileData();
    fetchAssociatedTemples(profileData.value.samajName ?? '');

  }
  Future<void> fetchAssociatedTemples(String samaj) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('temples')
          .where('samajList', arrayContains: samaj)
          .get();

      associatedTemples.value = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch associated temples");
      associatedTemples.clear();
    }
  }

  Future<void> pickAndUploadProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedFile == null) {
      return;
    }
    try {
      isLoading.value = true;
      final file = File(pickedFile.path);
      final uid = _auth.currentUser?.uid;

      final ref = FirebaseStorage.instance.ref().child('profile_pictures/$uid.jpg');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();

      await _firestore.collection('family_heads').doc(uid).update({
        'profilePicUrl': downloadUrl,
      });

      profileData.update((p) {
        if (p != null) p.avatarPath = downloadUrl;
      });

      Get.snackbar("Success", "Profile picture updated");
    } catch (e) {
      Get.snackbar("Error", "Failed to upload profile picture");
    } finally {
      isLoading.value = false;
    }
  }
  void getProfileData() async {
    isLoading.value = true;
    try {
      final doc = await _firestore.collection('family_heads').doc(_auth.currentUser?.uid).get();
      if (doc.exists) {
        profileData.value = ProfileModel.fromMap(doc.data()!);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data');
    } finally {
      isLoading.value = false;
    }
  }
  void resetController() {
    profileData.value = ProfileModel();
    associatedTemples.clear();
  }
  void logout() async {
    await _auth.signOut();
    resetController();
    Get.offAllNamed('/registration');
  }
}
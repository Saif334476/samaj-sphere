import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/family_member_model.dart';
import '../../services/firestore/firebase_firestore_services.dart';

class FamilyMemberFormController extends GetxController {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  var avatarImagePath = ''.obs;
  var avatarImageError = RxnString();
  final ImagePicker _picker = ImagePicker();
  var isLoading = false.obs;

  var firstName = ''.obs,
      middleName = ''.obs,
      lastName = ''.obs,
      age = ''.obs,
      gender = ''.obs,
      maritalStatus = ''.obs,
      qualification = ''.obs,
      occupation = ''.obs,
      natureOfDuties = ''.obs,
      relation = ''.obs;

  var firstNameError = RxnString(),
      middleNameError = RxnString(),
      lastNameError = RxnString(),
      ageError = RxnString(),
      genderError = RxnString(),
      maritalStatusError = RxnString(),
      qualificationError = RxnString(),
      occupationError = RxnString(),
      natureOfDutiesError = RxnString(),
      relationError = RxnString();


  var birthDate = ''.obs, bloodGroup = ''.obs, disability = ''.obs;
  var birthDateError = RxnString(),
      bloodGroupError = RxnString(),
      disabilityError = RxnString();


  var contactEmail = ''.obs,
      contactPhone = ''.obs,
      contactAlternate = ''.obs,
      contactLandline = ''.obs,
      contactSocial = ''.obs;

  var contactEmailError = RxnString(),
      contactPhoneError = RxnString(),
      contactAlternateError = RxnString(),
      contactLandlineError = RxnString(),
      contactSocialError = RxnString();


  var addressFlat = ''.obs,
      addressBuilding = ''.obs,
      addressStreet = ''.obs,
      addressLandmark = ''.obs,
      addressCountry = ''.obs,
      addressState = ''.obs,
      addressCity = ''.obs,
      addressDistrict = ''.obs,
      addressPincode = ''.obs,
      nativeState=''.obs,
      nativeCity=''.obs;

  var addressFlatError = RxnString(),
      addressBuildingError = RxnString(),
      addressStreetError = RxnString(),
      addressLandmarkError = RxnString(),
      addressCountryError = RxnString(),
      addressStateError = RxnString(),
      cityError = RxnString(),
      addressDistrictError = RxnString(),
      addressPincodeError = RxnString(),
      nativeStateError=RxnString(),
      nativeCityError=RxnString();

  var currentStep = 0.obs;

  Future<void> pickAvatarImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      avatarImagePath.value = picked.path;
      avatarImageError.value = null;
    }
  }
  void nextStep() {
    if (currentStep.value < 4) currentStep.value++;
  }

  void previousStep() {
    if (currentStep.value > 0) currentStep.value--;
  }


  void updateField(String field, String value) {
    switch (field) {

      case 'firstName': firstName.value = value; break;
      case 'middleName': middleName.value = value; break;
      case 'lastName': lastName.value = value; break;
      case 'age': age.value = value; break;
      case 'gender': gender.value = value; break;
      case 'maritalStatus': maritalStatus.value = value; break;
      case 'qualification': qualification.value = value; break;
      case 'occupation': occupation.value = value; break;
      case 'natureOfDuties': natureOfDuties.value = value; break;
      case 'relation': relation.value = value; break;


      case 'birthDate': birthDate.value = value; break;
      case 'bloodGroup': bloodGroup.value = value; break;
      case 'disability': disability.value = value; break;


      case 'contactEmail': contactEmail.value = value; break;
      case 'contactPhone': contactPhone.value = value; break;
      case 'contactAlternate': contactAlternate.value = value; break;
      case 'contactLandline': contactLandline.value = value; break;
      case 'contactSocial': contactSocial.value = value; break;


      case 'addressFlat': addressFlat.value = value; break;
      case 'addressBuilding': addressBuilding.value = value; break;
      case 'addressStreet': addressStreet.value = value; break;
      case 'addressLandmark': addressLandmark.value = value; break;
      case 'addressCountry': addressCountry.value = value; break;
      case 'addressState': addressState.value = value; break;
      case 'addressCity': addressCity.value = value; break;
      case 'addressDistrict': addressDistrict.value = value; break;
      case 'addressPincode': addressPincode.value = value; break;
      case 'nativeState': nativeState.value = value; break;
      case 'nativeCity': nativeCity.value = value; break;
    }
  }

  void clearError(String field) {
    switch (field) {

      case 'firstName': firstNameError.value = null; break;
      case 'middleName': middleNameError.value = null; break;
      case 'lastName': lastNameError.value = null; break;
      case 'age': ageError.value = null; break;
      case 'gender': genderError.value = null; break;
      case 'maritalStatus': maritalStatusError.value = null; break;
      case 'qualification': qualificationError.value = null; break;
      case 'occupation': occupationError.value = null; break;
      case 'natureOfDuties': natureOfDutiesError.value = null; break;
      case 'relation': relationError.value = null; break;


      case 'birthDate': birthDateError.value = null; break;
      case 'bloodGroup': bloodGroupError.value = null; break;
      case 'disability': disabilityError.value = null; break;


      case 'contactEmail': contactEmailError.value = null; break;
      case 'contactPhone': contactPhoneError.value = null; break;
      case 'contactAlternate': contactAlternateError.value = null; break;
      case 'contactLandline': contactLandlineError.value = null; break;
      case 'contactSocial': contactSocialError.value = null; break;


      case 'addressFlat': addressFlatError.value = null; break;
      case 'addressBuilding': addressBuildingError.value = null; break;
      case 'addressStreet': addressStreetError.value = null; break;
      case 'addressLandmark': addressLandmarkError.value = null; break;
      case 'addressCountry': addressCountryError.value = null; break;
      case 'addressState': addressStateError.value = null; break;
      case 'addressCity': cityError.value = null; break;
      case 'addressDistrict': addressDistrictError.value = null; break;
      case 'addressPincode': addressPincodeError.value = null; break;
      case 'nativeState': nativeStateError.value = null; break;
      case 'nativeCity': nativeCityError.value = null; break;

    }
  }

  void updateFieldAndClearError(String field, String value) {
    updateField(field, value);
    clearError(field);
  }


  bool validateProfileStep() {
    bool valid = true;
    if (avatarImagePath.value.isEmpty) {
      avatarImageError.value = 'Photo is required';
      valid = false;
    }
    if (firstName.value.isEmpty) {
      firstNameError.value = 'First Name is required';
      valid = false;
    }
    if (lastName.value.isEmpty) {
      lastNameError.value = 'Last Name is required';
      valid = false;
    }

    if (gender.value.isEmpty) {
      genderError.value = 'Gender is required';
      valid = false;
    }
    if (occupation.value.isEmpty) {
      occupationError.value = 'Occupation is required';
      valid = false;
    }
    if (relation.value.isEmpty) {
      relationError.value = 'Relation is required';
      valid = false;
    }

    return valid;
  }

  bool validatePersonalStep() {
    bool valid = true;

    if (age.value.isEmpty) {
      ageError.value = 'Age is required';
      valid = false;
    }
    if (maritalStatus.value.isEmpty) {
      maritalStatusError.value = 'Marital status is required';
      valid = false;
    }
    if (qualification.value.isEmpty) {
      qualificationError.value = 'Qualification is required';
      valid = false;
    }

    if (natureOfDuties.value.isEmpty) {
      natureOfDutiesError.value = 'Exact nature of duties is required';
      valid = false;
    }
    if (birthDate.value.isEmpty) {
      birthDateError.value = 'Birth date is required';
      valid = false;
    }
    if (bloodGroup.value.isEmpty) {
      bloodGroupError.value = 'Blood group is required';
      valid = false;
    }

    return valid;
  }

  bool validateContactStep() {
    bool valid = true;

    if (contactPhone.value.isEmpty) {
      contactPhoneError.value = 'Phone number is required';
      valid = false;
    }
    if (contactEmail.value.isEmpty) {
      contactEmailError.value = 'Email is required';
      valid = false;
    }

    return valid;
  }

  bool validateAddressStep() {
    bool valid = true;

    if (addressFlat.value.isEmpty) {
      addressFlatError.value = 'Flat number is required';
      valid = false;
    }
    if (addressBuilding.value.isEmpty) {
      addressBuildingError.value = 'Building name is required';
      valid = false;
    }
    if (addressStreet.value.isEmpty) {
      addressStreetError.value = 'Street is required';
      valid = false;
    }
    if (addressCountry.value.isEmpty) {
      addressCountryError.value = 'Country is required';
      valid = false;
    }
    if (addressState.value.isEmpty) {
      addressStateError.value = 'State is required';
      valid = false;
    }
    if (addressCity.value.isEmpty) {
      cityError.value = 'City is required';
      valid = false;
    }
    if (addressPincode.value.isEmpty) {
      addressPincodeError.value = 'Pincode is required';
      valid = false;
    }
    if (nativeState.value.isEmpty) {
      nativeStateError.value = 'NativeState is required';
      valid = false;
    }
    if (nativeCity.value.isEmpty) {
      nativeCityError.value = 'NativeCity is required';
      valid = false;
    }

    return valid;
  }
  Future<void> submitFamilyMemberForm() async {
    isLoading.value = true;
    print("Submitting family member form...");
    if (!validateProfileStep() ||
        !validatePersonalStep() ||
        !validateContactStep() ||
        !validateAddressStep()) {
      Get.snackbar("Error", "Please fill in all required fields.");
      isLoading.value = false;
      return;
    }

    final headId = FirebaseAuth.instance.currentUser?.uid;
    if (headId == null) {
      Get.snackbar("Error", "User not logged in.");
      return;
    }
    late var photoUrl;
    try {
      final file = File(avatarImagePath.value);
      final downloadUrl =
      await _firestoreService.uploadProfilePhoto(file,FirebaseAuth.instance.currentUser!.uid);
      photoUrl = downloadUrl;

    } catch (e) {
      Get.snackbar("Error", "Failed to upload photo. Try again.");
    }
    final member = FamilyMember(
      firstName: firstName.value,
      middleName: middleName.value,
      lastName: lastName.value,
      birthDate: birthDate.value,
      age: age.value,
      gender: gender.value,
      maritalStatus: maritalStatus.value,
      qualification: qualification.value,
      occupation: occupation.value,
      natureOfDuties: natureOfDuties.value,
      bloodGroup: bloodGroup.value,
      relationWithHead: relation.value,
      phone: contactPhone.value,
      alternatePhone: contactAlternate.value,
      landline: contactLandline.value,
      email: contactEmail.value,
      socialLink: contactSocial.value,
      avatarPath:photoUrl,
      flat: addressFlat.value,
      building: addressBuilding.value,
      street: addressStreet.value,
      landmark: addressLandmark.value,
      city: addressCity.value,
      district: addressDistrict.value,
      state: addressState.value,
      country: addressCountry.value,
      pincode: addressPincode.value,
      nativeCity: nativeCity.value,
      nativeState: nativeState.value,
    );

    try {
      await _firestoreService.addFamilyMember(headId, member);
      Get.snackbar("Success", "Family member Registered!");
      reset();

    } catch (e) {
      print("Error submitting member: $e");
      Get.snackbar("Error", "Failed to submit member.");
    }finally{
      isLoading.value = false;
    }
  }
  void reset() {
    avatarImagePath.value = '';
    avatarImageError.value = null;
    firstName.value = '';
    middleName.value = '';
    lastName.value = '';
    age.value = '';
    gender.value = '';
    maritalStatus.value = '';
    qualification.value = '';
    occupation.value = '';
    natureOfDuties.value = '';
    relation.value = '';
    birthDate.value = '';
    bloodGroup.value = '';
    disability.value = '';
    contactEmail.value = '';
    contactPhone.value = '';
    contactAlternate.value = '';
    contactLandline.value = '';
    contactSocial.value = '';
    addressFlat.value = '';
    addressBuilding.value = '';
    addressStreet.value = '';
    addressLandmark.value = '';
    addressCountry.value = '';
    addressState.value = '';
    addressCity.value = '';
    addressDistrict.value = '';
    addressPincode.value = '';
    nativeState.value = '';
    nativeCity.value = '';
    currentStep.value = 0;
  }

}

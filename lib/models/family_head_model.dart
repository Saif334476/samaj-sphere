import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FamilyHeadModel {
  final String uid;
  final String name;
  final String age;
  final String gender;
  final String occupation;
  final String samajName;
  final  String avatarPath;

  final String maritalStatus;
  final String qualification;
  final String birthDate;
  final String bloodGroup;
  final String natureOfDuties;


  final String contactEmail;
  final String contactPhone;
  final String contactAlternate;
  final String contactLandline;
  final String contactSocial;


  final String addressFlat;
  final String addressBuilding;
  final String addressStreet;
  final String addressLandmark;
  final String addressCity;
  final String addressDistrict;
  final String addressState;
  final String addressCountry;
  final String addressPincode;
  final String addressNativeState;
  final String addressNativeCity;


  const FamilyHeadModel({
    required this.avatarPath,
    required this.name,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.occupation,
    required this.samajName,
    required this.qualification,
    required this.birthDate,
    required this.bloodGroup,
    required this.natureOfDuties,
    required this.contactEmail,
    required this.contactPhone,
    required this.contactAlternate,
    required this.contactLandline,
    required this.contactSocial,
    required this.addressFlat,
    required this.addressBuilding,
    required this.addressStreet,
    required this.addressLandmark,
    required this.addressCity,
    required this.addressDistrict,
    required this.addressState,
    required this.addressCountry,
    required this.addressPincode,
    required this.addressNativeState,
    required this.addressNativeCity,
    required this.uid,

  });


  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'name': name,
      'age': age,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'occupation': occupation,
      'samajName': samajName,
      'qualification': qualification,
      'birthDate': birthDate,
      'bloodGroup': bloodGroup,
      'natureOfDuties': natureOfDuties,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'contactAlternate': contactAlternate,
      'contactLandline': contactLandline,
      'contactSocial': contactSocial,
      'addressFlat': addressFlat,
      'addressBuilding': addressBuilding,
      'addressStreet': addressStreet,
      'addressLandmark': addressLandmark,
      'addressCity': addressCity,
      'addressDistrict': addressDistrict,
      'addressState': addressState,
      'addressCountry': addressCountry,
      'addressPincode': addressPincode,
      'addressNativeState': addressNativeState,
      'addressNativeCity': addressNativeCity,
      'avatarPath':avatarPath,

    };
  }


  factory FamilyHeadModel.fromMap(Map<String, dynamic> map) {
    return FamilyHeadModel(
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      maritalStatus: map['maritalStatus'] ?? '',
      occupation: map['occupation'] ?? '',
      samajName: map['samajName'] ?? '',
      qualification: map['qualification'] ?? '',
      birthDate: map['birthDate'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      natureOfDuties: map['natureOfDuties'] ?? '',
      contactEmail: map['contactEmail'] ?? '',
      contactPhone: map['contactPhone'] ?? '',
      contactAlternate: map['contactAlternate'] ?? '',
      contactLandline: map['contactLandline'] ?? '',
      contactSocial: map['contactSocial'] ?? '',
      addressFlat: map['addressFlat'] ?? '',
      addressBuilding: map['addressBuilding'] ?? '',
      addressStreet: map['addressStreet'] ?? '',
      addressLandmark: map['addressLandmark'] ?? '',
      addressCity: map['addressCity'] ?? '',
      addressDistrict: map['addressDistrict'] ?? '',
      addressState: map['addressState'] ?? '',
      addressCountry: map['addressCountry'] ?? '',
      addressPincode: map['addressPincode'] ?? '',
      addressNativeState: map['addressNativeState'] ?? '',
      addressNativeCity: map['addressNativeCity'] ?? '',
      avatarPath: map['avatarPath'],
      uid: map['uid'],

    );
  }
}

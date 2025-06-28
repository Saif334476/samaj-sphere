class FamilyMember {
  final String firstName;
  final String middleName;
  final String lastName;
  final String birthDate;
  final String age;
  final String gender;
  final String maritalStatus;
  final String qualification;
  final String occupation;
  final String natureOfDuties;
  final String bloodGroup;
  final String relationWithHead;
  final String phone;
  final String alternatePhone;
  final String landline;
  final String email;
  final String socialLink;
  final String avatarPath;

  final String flat;
  final String building;
  final String street;
  final String landmark;
  final String city;
  final String district;
  final String state;
  final String country;
  final String pincode;
  final String nativeCity;
  final String nativeState;

  FamilyMember({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.qualification,
    required this.occupation,
    required this.natureOfDuties,
    required this.bloodGroup,
    required this.relationWithHead,
    required this.phone,
    required this.alternatePhone,
    required this.landline,
    required this.email,
    required this.socialLink,
    required this.avatarPath,
    required this.flat,
    required this.building,
    required this.street,
    required this.landmark,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.nativeCity,
    required this.nativeState,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "birthDate": birthDate,
      "age": age,
      "gender": gender,
      "maritalStatus": maritalStatus,
      "qualification": qualification,
      "occupation": occupation,
      "natureOfDuties": natureOfDuties,
      "bloodGroup": bloodGroup,
      "relationWithHead": relationWithHead,
      "phone": phone,
      "alternatePhone": alternatePhone,
      "landline": landline,
      "email": email,
      "socialLink": socialLink,
      "avatarPath": avatarPath,
      "flat": flat,
      "building": building,
      "street": street,
      "landmark": landmark,
      "city": city,
      "district": district,
      "state": state,
      "country": country,
      "pincode": pincode,
      "nativeCity": nativeCity,
      "nativeState": nativeState,
    };
  }
}

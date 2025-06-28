class ProfileModel {
  String? samajName;
  String? name;
  String? contactPhone;
  String? birthDate;
  String? bloodGroup;
  String? natureOfDuties;
  String? avatarPath;
  String? contactEmail;

  ProfileModel({
    this.name,
    this.contactPhone,
    this.birthDate,
    this.bloodGroup,
    this.natureOfDuties,
    this.avatarPath,
    this.contactEmail,
    this.samajName,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      samajName: map['samajName'],
      name: map['name'],
      contactPhone: map['contactPhone'],
      birthDate: map['birthDate'],
      bloodGroup: map['bloodGroup'],
      natureOfDuties: map['natureOfDuties'],
      avatarPath: map['avatarPath'],
      contactEmail: map['contactEmail'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../../models/family_head_model.dart';
import '../../models/family_member_model.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> submitHeadForm(FamilyHeadModel model) async {

    try {
      await _firestore
          .collection('family_heads')
          .doc(model.uid)
          .set({
        ...model.toMap(),
        'isRegistrationCompleted': true,
      });
    } catch (e) {
      print("Firestore Error: $e");
      throw Exception("Failed to submit form");
    }
  }
  Future<void> addFamilyMember(String headId, FamilyMember member) async {
    try {
      await FirebaseFirestore.instance
          .collection('family_heads')
          .doc(headId)
          .collection('members')
          .add(member.toJson());
    } catch (e) {
      print("Error submitting member: $e");
      throw Exception("Failed to submit member");
    }
  }
  Future<String> uploadProfilePhoto(File file, String uid) async {
    try {
      final ref = _storage.ref().child('profile_photos/$uid.jpg');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Storage Error: $e");
      throw Exception("Failed to upload profile photo");
    }
  }

  Future<void> updateProfilePhotoUrl(String uid, String downloadUrl) async {
    try {
      await _firestore
          .collection('family_heads')
          .doc(uid)
          .update({'avatarPath': downloadUrl});
    } catch (e) {
      print("Firestore Error: $e");
      throw Exception("Failed to update profile photo URL");
    }
  }



  Future<void> seedSamajAndTemples() async {
    final firestore = FirebaseFirestore.instance;

    final samajs = [
      "Arya Samaj",
      "Brahmo Samaj",
      "Prajapati Samaj",
      "Prarthana Samaj",
      "Ramakrishna Mission",
      "Deva Samaj",
      "Aligarh Movement",
      "Seva Sadan Society",
    ];

    final temples = [
      {
        "name": "Shore Temple",
        "location": "Mahabalipuram, Tamil Nadu",
        "samajList": ["Arya Samaj", "Brahmo Samaj"]
      },
      {
        "name": "Meenakshi Amman Temple",
        "location": "Madurai, Tamil Nadu",
        "samajList": ["Prarthana Samaj", "Ramakrishna Mission"]
      },
      {
        "name": "Sri Venkateswara Temple",
        "location": "Pittsburgh, USA",
        "samajList": ["Arya Samaj", "Deva Samaj"]
      },
      {
        "name": "Brihadeeswarar Temple",
        "location": "Thanjavur, Tamil Nadu",
        "samajList": ["Prajapati Samaj", "Brahmo Samaj"]
      },
    ];

    for (final name in samajs) {
      await firestore.collection('samajs').add({"name": name});
    }

    for (final temple in temples) {
      await firestore.collection('temples').add(temple);
    }

    print(" Samajs and Temples seeded successfully.");
  }





}
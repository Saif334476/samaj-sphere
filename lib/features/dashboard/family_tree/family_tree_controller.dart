import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FamilyTreeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var head = Rxn<Map<String, dynamic>>();
  var members = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  StreamSubscription? _headSubscription;
  StreamSubscription? _membersSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchFamilyTree();
  }

  @override
  void onClose() {
    _headSubscription?.cancel();
    _membersSubscription?.cancel();
    super.onClose();
  }

  Future<void> fetchFamilyTree() async {
    isLoading.value = true;

    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not logged in");
      }

      _headSubscription = _firestore.collection('family_heads').doc(uid).snapshots().listen((headDoc) {
        if (headDoc.exists) {
          head.value = {
            "name": headDoc['name'] ?? '',
            "relation": "Head",
            "profilePicUrl": headDoc['profilePicUrl'] ?? '',
          };
        } else {
          head.value = null;
        }
      });
      _membersSubscription = _firestore.collection('family_heads').doc(uid).collection("members").snapshots().listen((membersQuery) {
        members.value = membersQuery.docs.map((doc) {
          final data = doc.data();
          return {
            "name": data['firstName'] ?? '',
            "relation": data['relationWithHead'] ?? '',
            "profilePicUrl": data['avatarPath'] ?? '',
          };
        }).toList();
        isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch family tree");
      print("🔥 FamilyTree Error: $e");
      isLoading.value = false;
    }
  }
}
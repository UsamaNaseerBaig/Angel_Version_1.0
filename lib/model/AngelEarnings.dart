import 'package:angel_v1/view/angel_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AngelEarning {
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get angelEarning =>
      _firestore.collection("Billing").where("angel_number", isEqualTo: AngelProfile.angel_number).snapshots();
}
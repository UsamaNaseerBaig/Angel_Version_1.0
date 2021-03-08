import 'package:angel_v1/view/angel_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectionRequest{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Stream<QuerySnapshot> get Requests => _firestore.collection("Connection").where("to",isEqualTo: AngelProfile.cnic).orderBy("time",descending: true).snapshots();
}
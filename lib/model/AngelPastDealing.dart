import 'dart:io';
import 'package:angel_v1/view/angel_past_dealing.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PastDealing {
  final _storageRef = FirebaseStorage.instance.ref();
  final  _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> get PastDealings => _firestore.collection("Dealing").where("number",isEqualTo: AngelProfile.angel_number).orderBy("time",descending: true).snapshots();


  Future<String> UploadImageAndGiveStorageURL(File image_arr,String name) async {
    await _storageRef.child("$name _PastDealing_photo_${AngelPastDealing.image_count}.jpg").putFile(image_arr);
    String url = await FirebaseStorage.instance.ref("$name _PastDealing_photo_${AngelPastDealing.image_count}.jpg")
        .getDownloadURL();
    print("${url} here I have uploaded image check on firestorage");
    return url;
  }


  void UploadDealing(Map<String,dynamic> dealing_info) async {
    print(dealing_info);
    await _firestore.collection("Dealing")
        .add(dealing_info)
        .then((value) => print("Dealing has been uploaded"))
        .catchError((onError) => print("$onError failed to update"));
  }



}
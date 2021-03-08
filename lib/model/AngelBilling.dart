import 'package:cloud_firestore/cloud_firestore.dart';

class AngelBilling{
  final  _firestore = FirebaseFirestore.instance;

  void UploadBillingDetail(Map<String,dynamic> billing_info) async {
    print(billing_info);
    await _firestore.collection("Billing")
        .add(billing_info)
        .then((value) => print("Done adding billing"))
        .catchError((onError) => print("$onError failed to update"));
  }
}
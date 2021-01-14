import 'package:angel_v1/controller/angel_profile_validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AngelPersonalDetail{
  String cnic_name;
  String address;
  String dob;
  String gender;
  String category;
  static Map angel_profile={};
  static bool angel_exist =false;
  final  _firestore = FirebaseFirestore.instance;


  AngelPersonalDetail({this.category,this.gender,this.address,this.cnic_name,this.dob});

  Future<bool> AngelExist(String cnic_num)async{
    var angel_ref = _firestore.collection("ANGEL").doc(cnic_num);
    var doc = await angel_ref.get();
    if (!doc.exists){
      return false;
    }
    else{
      angel_exist = true;
      return true;
    }
  }

  void AddPersonalDetail(String cnic_num)async {
    var angel_personal_detail = {
      "full_name": cnic_name,
      "home_address": address,
      "date_of_birth": dob,
      "gender": gender,
      "category": category,
    };
    var personal_identity = {
      "personal_details": angel_personal_detail
    };
    var ref =  _firestore.collection("ANGEL").doc(cnic_num);
    var res = await ref.update(personal_identity).then((value) => print("updated")).catchError((onError)=>print("$onError failed to update"));
  }

  void Declaration(String cnic_num)async{
    print("i am going to declare");
    print(angel_exist);
    var ref = _firestore.collection("ANGEL").doc(cnic_num);
    var res = await ref.update({
      "Declaration" : true,
    }).then((value) => print("declaration Added")).catchError((onError)=>print("cannot declare"));
  }

  void CompleteProfile(String cnic_num)async{
    print("completing profile");
    var fetch = _firestore.collection("ANGEL").doc(cnic_num);
    var fetch_doc = await fetch
        .get().then((DocumentSnapshot doc){
          angel_profile = doc.data();
    });
    AngelProfileValidator.isComplete = angel_profile['Declaration'];
  }
}
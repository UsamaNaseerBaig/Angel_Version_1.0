import 'dart:io';
import 'package:angel_v1/controller/angel_experience_info.dart';
import 'package:angel_v1/view/angel_identity.dart';
import 'package:angel_v1/view/angel_past_dealing.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AngelCredential{
  String number;
  String password;
  String cnic;
  int image_count;
  List<String> imageList=[];
  static final _auth=FirebaseAuth.instance;
  static User loggedIn;
  final  _storageRef = FirebaseStorage.instance.ref();
  final  _firestore = FirebaseFirestore.instance;

  AngelCredential({this.number,this.password});

  Future<List<String>> UploadImages(List<File> image_arr,String name)async{


    for (var image in image_arr) {
      AngelPastDealing.image_count++;
      print(AngelPastDealing.image_count);
      var uploadTask = await _storageRef.child("$name _ $cnic _ photo${AngelPastDealing.image_count}.jpg").putFile(image);
      String url = await FirebaseStorage.instance.ref("$name _ $cnic _ photo${AngelPastDealing.image_count}.jpg")
          .getDownloadURL();
      imageList.add(url);
    }
    return imageList;

  }

  void AddIdentity(String cnic_num,List<File> image)async {
    print("i am in identity");
    cnic = cnic_num;
    await UploadImages(image,"Cnic");
    print(imageList);
    var angel_proof={
      "cnic" : cnic,
      "number" : number,
      "password": password,
      "cnic_photos":imageList
    };
    var angel_identity={
      "identity_proof" : angel_proof
    };
    await _firestore.collection("ANGEL").doc(cnic).set(angel_identity);


  }

  Future<bool> CreateNewAngel()async {
    try{
      final new_angel=await _auth.createUserWithEmailAndPassword(
          email: "${number}@Angel.com",
          password: password);
      return new_angel != null ? true: false;
    }
    catch(e)
    {
      print(e);
    }
  }


  //for angel experience
  void UploadExperience(List<File> image_arr)async {
    List<String> exp_images = [];
    List<String> past_deal=[];
    exp_images  =  await UploadImages(image_arr,"ExperienceImage");
    var exp_image ={
      "experience_letter" :exp_images
    };
    var angel_exp= {
      "experience_info" : exp_image,
      'past_dealings' : past_deal,
    };
    var ref =  _firestore.collection("ANGEL").doc(AngelIdentity.angel_id);
    var res = await ref.update(angel_exp).then((value) => AngelExperienceInfoO.exp_status = true).catchError((onError)=>print("$onError failed to update"));
  }

  //for angel dealings
  void UploadDealings(List<File> image_arr)async {
    this.cnic = AngelProfile.cnic;
    List<String> deal_images = [];
    deal_images  =  await UploadImages(image_arr,"PastDealings");
    deal_images = AngelPastDealing.image_string + deal_images;
    print(deal_images);
    var angel_exp= {
      "past_dealings" : deal_images
    };
    var ref =  _firestore.collection("ANGEL").doc(AngelProfile.cnic);
    var res = await ref.update({'past_dealings':deal_images}).then((value) => AngelExperienceInfoO.deal_status = true).catchError((onError)=>print("$onError failed to update"));
  }

  //to get Past Dealings
  Future<List<dynamic>> GetPastDealings()async{
    print("getting past dealings");
    var list=[];
    print(AngelProfile.cnic);
      AngelPastDealing.image_stream =_firestore.collection("ANGEL").doc(AngelProfile.cnic).snapshots();
      await for (var snapshot in _firestore.collection("ANGEL").doc(AngelProfile.cnic).snapshots()){
              list =  snapshot.data()['past_dealings'];
                image_count = list.length;
                print("below past dealing image length");
                print(image_count);
      }

    return list;
  }
  //log in method
  Future<bool> LogInAngel()async {
    try{
      final new_angel=await _auth.signInWithEmailAndPassword(
          email: "${number}@Angel.com",
          password: password);
      return new_angel != null ? true: false;
    }
    catch(e)
    {
      print(e);
    }
  }
//event will be trigger in sign ini in
  Future<bool> GetCurrentAngel()async{
    final angel =await _auth.currentUser;
    if (angel != null){
      print(loggedIn);
      loggedIn = angel;
      return true;
    }
    return false;
  }

  Future<Map> GetProfile()async{
    String num = loggedIn.email;
    num = num.split('@')[0];
    final QuerySnapshot snap =await _firestore.collection("ANGEL")
        .where('identity_proof.number',isEqualTo: num).getDocuments();
    var pro ={};
     snap.docs.forEach((DocumentSnapshot element) {
      pro = element.data();
    });
     return pro;
  }


}
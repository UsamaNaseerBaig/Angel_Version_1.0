import 'dart:io';

import 'package:angel_v1/model/AngelCredential.dart';

class AngelIdentityO{
  String number;
  String cnic;
  List<File> imageList;
  String password;
  AngelCredential newAngel;

  AngelIdentityO({this.number,this.password,this.cnic,this.imageList});
  //
  // void PrepareData(){
  //
  // }
  Future<bool> CompleteIdentity()async{
    await newAngel.AddIdentity(cnic,imageList);
    return true;
  }

  Future<bool> Register()async {
    newAngel=AngelCredential(//giving shape to object
        number: number,
        password: password,
        cnic: cnic
    );
    var status =   await  newAngel.CreateNewAngel(cnic);
    if (status == true){
       return true;
     }
     else{
      return false;
     }
  }

  Future<bool> LogIn()async {
    newAngel=AngelCredential(
        number: number,
        password: password
    );
    var status =   await  newAngel.LogInAngel();
    if (status == true){
      return true;
    }
    else{
      return false;
    }
  }



}
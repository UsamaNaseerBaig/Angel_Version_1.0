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
  Future<void> CompleteIdentity()async{
    await newAngel.AddIdentity(cnic,imageList);
    print("added");

  }

  Future<bool> Register()async {
    newAngel=AngelCredential(
        number: number,
        password: password
    );
    var status =   await  newAngel.CreateNewAngel();
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
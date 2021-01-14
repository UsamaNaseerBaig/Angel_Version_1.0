import 'package:angel_v1/model/AngelCredential.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AngelProfileController{

  var profile={};
  AngelCredential sign_in_track;

  Future<bool> GetCurrentUser()async{
    sign_in_track = AngelCredential();
   bool curr =await sign_in_track.GetCurrentAngel();
   print(curr);
   return curr;
  }
  Future<Map> getProfileDetails()async{
    try{
      profile = await sign_in_track.GetProfile();
        return profile;
    }
    catch(e)
    {
      print(e);
    }
  }

}
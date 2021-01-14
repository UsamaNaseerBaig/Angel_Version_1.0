import 'dart:io';

import 'package:angel_v1/model/AngelCredential.dart';
import 'package:angel_v1/model/AngelPersonalDetail.dart';

class AngelExperienceInfoO{
  List<File> experience_image=[];
  List<File> dealing_image=[];
  static bool exp_status=false;
  static bool deal_status=false;

  AngelExperienceInfoO({this.experience_image,this.dealing_image});

  void AddExperience(String cnic_num)async{
    //checking if angel exists
    AngelPersonalDetail exp = AngelPersonalDetail();
    await exp.AngelExist(cnic_num);
    AngelCredential uploading_exp = AngelCredential();
    AngelPersonalDetail.angel_exist ?
    await uploading_exp.UploadExperience(experience_image):
    print("Angel does not exits");
  }

  //for past dealing
  void AddPastDealing(String cnic_num)async{
    //checking if angel exists
    AngelPersonalDetail exp = AngelPersonalDetail();
    await exp.AngelExist(cnic_num);
    AngelCredential uploading_deal = AngelCredential();
    AngelPersonalDetail.angel_exist ?
    await uploading_deal.UploadDealings(dealing_image):
    print("Angel does not exits");
  }

  //for getting images regarding dealings from cloud
Future<void> GetImages()async{
    AngelCredential getting_images = AngelCredential();
    await getting_images.GetPastDealings();
  }

}
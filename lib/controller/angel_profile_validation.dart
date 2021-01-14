

import 'package:angel_v1/model/AngelPersonalDetail.dart';

class AngelProfileValidator{
  static bool isComplete;

  Future<bool> Validate(String cnic_num)async{
    AngelPersonalDetail validator = AngelPersonalDetail();
    await validator.AngelExist(cnic_num);
    AngelPersonalDetail.angel_exist ? await validator.CompleteProfile(cnic_num):print("angel didnt add declaration or proof");
    print(isComplete);
   return  isComplete;

  }
}
import 'package:angel_v1/model/AngelPersonalDetail.dart';

class AngelPersonalDetailO{
  String cnic_name;
  String address;
  String dob;
  String gender;
  String category;

  AngelPersonalDetailO({this.category,this.gender,this.address,this.cnic_name,this.dob});

  Future<void> RegisterPersonalDetail(String cnic_num)async{

    AngelPersonalDetail personal = AngelPersonalDetail(
      address: address,
      cnic_name: cnic_name,
      dob: dob,
      gender: gender,
      category: category
    );
    print("angel personal details created now checking");
    bool doc =await personal.AngelExist(cnic_num);
    doc ? personal.AddPersonalDetail(cnic_num): null;
  }

  void AddDeclaration(String cnic_num)async {
    var declare = AngelPersonalDetail();
    await declare.AngelExist(cnic_num);
    AngelPersonalDetail.angel_exist ? declare.Declaration(cnic_num):print("Angel does not exits");
  }

}
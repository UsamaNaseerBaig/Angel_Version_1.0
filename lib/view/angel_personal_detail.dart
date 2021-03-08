import 'package:angel_v1/controller/angel_personal_detailO.dart';
import 'package:angel_v1/view/angel_identity.dart';
import 'package:angel_v1/view/components.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AngelPersonalDetail extends StatefulWidget {
  static String id = "AngelPersonalDetail";

  @override
  _AngelPersonalDetailState createState() => _AngelPersonalDetailState();
}

class _AngelPersonalDetailState extends State<AngelPersonalDetail> {

  //fields
  DateTime date;
  String gender;
  String category;
  String full_name;
  String home_address;


  //methods
  Future<Null> SelectDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(context: context, initialDate: date, firstDate:DateTime(1960), lastDate: DateTime(2030));
    if(picked != null && date != null){
      setState(() {
        date = picked ;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        title: Text("Personal Details",style: kTextStyle,),
        iconTheme: IconThemeData(color: kFillerColour),
      ),
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kindly Add Personal Details",
              style: kLabelStyle,
            ),
            InputField(
              name: "CNIC Name",
              focus: true,
              onChange: (val){
                setState(() {
                  full_name = val;
                });
              },
            ),
            InputField(
              name: "Home-Address",
              focus: false,
              onChange: (val){
                setState(() {
                  home_address = val;
                });
              },
            ),
            Container(
              width: 300,
              decoration:  BoxDecoration(
                border: Border.all(width: 2.0,color: kFillerColour),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListTile(
                title: date == null? Text("Date Of Birth"):Text("${date.year}-${date.month}-${date.day}"),
                trailing: Icon(Icons.date_range,color: kTextColor,),
                onTap: (){
                  date = DateTime.now();
                  SelectDatePicker(context);

                },
              ),
            ),
            Container(
                width: 300,
                decoration:  BoxDecoration(
                  border: Border.all(width: 2.0,color: kFillerColour),
                  borderRadius: BorderRadius.circular(4),
                ),
                child:ListTile(
                  title: gender != null ? Text(gender):Text("Gender"),
                  trailing: DropdownButton<String>(
                    items: Gender(),
                    onChanged: (value){
                      print(value);
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                )
            ),
            Container(
                width: 300,
                decoration:  BoxDecoration(
                  border: Border.all(width: 2.0,color: kFillerColour),
                  borderRadius: BorderRadius.circular(4),
                ),
                child:ListTile(
                  title: category != null?Text(category):Text("Category"),
                  trailing: DropdownButton<String>(
                    items: Category(),
                    onChanged: (value){
                      print(value);
                      setState(() {
                        category = value;
                      });
                    },
                  ),
                )
            ),
            ActionButton(
              name: "Complete Personal Detail",
              onTap: ()async{
               if (AngelIdentity.angel_id != null) {
                   if (gender != null && category != null && full_name != null && home_address != null ){
                     AngelPersonalDetailO personal_detail= AngelPersonalDetailO(
                       cnic_name: full_name,
                       address: home_address,
                       dob: date.toString(),
                       gender: gender,
                       category: category
                     );
                     await personal_detail.RegisterPersonalDetail(AngelIdentity.angel_id);
                     Fluttertoast.showToast(
                         msg: "Personal Detail Has been added Successfully",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Colors.green,
                         textColor: Colors.white,
                         fontSize: 16.0
                     );
                     Navigator.pop(context);
                   }
                   else{
                     Fluttertoast.showToast(
                         msg: "Unsuccessful",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 1,
                         backgroundColor: Colors.red,
                         textColor: Colors.white,
                         fontSize: 16.0
                     );
                   }
               }
              },
            )
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> Gender(){
  List<DropdownMenuItem<String>> item=[];
  int end=genderList.length;
  for (String curr in genderList ){
    var newChild=DropdownMenuItem(
      child: Text(curr),
      value: curr,
    );
    item.add(newChild);
  }
  return item;
}

const List<String> genderList = [
  'male',
  'female',
];

const List<String> catList = [
  'Electronics',
  'Home-Appliances',
  'Clothing',
];

List<DropdownMenuItem<String>> Category(){
  List<DropdownMenuItem<String>> item=[];
  int end=catList.length;
  for (String curr in catList ){
    var newChild=DropdownMenuItem(
      child: Text(curr),
      value: curr,
    );
    item.add(newChild);
  }
  return item;
}
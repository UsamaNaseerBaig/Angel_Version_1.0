import 'package:angel_v1/controller/angel_profile_validation.dart';
import 'package:angel_v1/view/angel_declaration.dart';
import 'package:angel_v1/view/angel_identity.dart';
import 'package:angel_v1/view/angel_personal_detail.dart';
import 'package:angel_v1/view/components.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignCompleteProfile extends StatelessWidget {

  static String id = "SignCompleteProfile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        iconTheme: IconThemeData(
          color: kFillerColour
        ),
        title: Text("Complete Your Profile",style: kTextStyle,),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text(
                "We Would Like to have following Details from You",
              style: kLabelStyle.copyWith(
                fontSize: 32
              ),
              ),
              ActionButton(
                name: "Identity Proof",
                onTap: (){
                  Navigator.pushNamed(context,AngelIdentity.id);
                },
              ),
              ActionButton(
                name: "Personal Details",
                onTap: (){
                  Navigator.pushNamed(context,AngelPersonalDetail.id);
                },
              ),
              ActionButton(
                name: "Declaration",
                onTap: (){
                  Navigator.pushNamed(context,AngelDeclaration.id);
                },
              ),
              ActionButton(
                name: "Profile Completed",
                onTap: ()async{
                  AngelProfileValidator val = AngelProfileValidator();
                  bool status = await val.Validate(AngelIdentity.angel_id);
                  if (status == true){
                    Fluttertoast.showToast(
                        msg: "Profile Has been created Successfully",
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
                        msg: "UnSuccessful",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }

                },
              )
            ],
          )
        ),
      ),
    );
  }
}

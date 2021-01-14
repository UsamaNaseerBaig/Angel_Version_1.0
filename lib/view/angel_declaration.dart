import 'package:angel_v1/controller/angel_personal_detailO.dart';
import 'package:angel_v1/view/angel_identity.dart';
import 'package:angel_v1/view/components.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
class AngelDeclaration extends StatelessWidget {

  static String id = "AngelDeclaration";
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
                  "Please Do read Following Terms",
                  style: kLabelStyle,
                ),
                Text(
                  "I have filled information regarding best of my knowledge",
                  style: kTextStyle,
                ),
                Text(
                  "The Company can make changes/add/remove my profile per need without my consent",
                  style: kTextStyle,
                ),
                Text(
                  "The company can make new policies and rules regarding use of this app per need",
                  style: kTextStyle,
                ),Text(
                  "I declare my provided information to be used my company",
                  style: kTextStyle,
                ),
                ActionButton(
                  name: "I Agree",
                  onTap: (){
                    //bool will be true
                    AngelPersonalDetailO declare =AngelPersonalDetailO();
                    print(AngelIdentity.angel_id);
                    declare.AddDeclaration(AngelIdentity.angel_id);
                    Navigator.pop(context);
                  },
                )

              ],
            )
        ),
      ),
    );
  }
}

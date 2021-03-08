import 'package:angel_v1/view/angel_experience.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:angel_v1/view/main_page.dart';
import 'package:angel_v1/view/sign_complete_profile.dart';
import 'package:flutter/material.dart';
import 'components.dart';
import 'angel_profile.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AngelSignUp extends StatelessWidget {
  static String id = "AngelSignUp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF6dd47e),
        ),
        backgroundColor: kbackgroundColor,
        title: Text(
          "Angel SignUp",
          style: kTextStyle,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Complete Below Steps",
                  style: kLabelStyle,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ActionButton( //completing profile button
                name: "Complete Your Profile",
                onTap: (){
                  //write code to complete profule
                  Navigator.pushNamed(context,SignCompleteProfile.id);
                  print("completing profile");
                },
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                flex: 2,
                child: ActionDescription(
                  desc: "Add a profile photo, describe your service, Enter your information, add your service information And create an awesome profile",
                ),
              ),
              // ActionButton(//completing verification
              //   name: "Profile Verification/Approval",
              //   onTap: (){
              //     //write code to complete profule
              //     Navigator.pushNamed(context,AngelExperience.id);
              //     print("completing verification profile");
              //   },
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // Expanded(
              //   flex: 2,
              //   child: ActionDescription(
              //     desc: "In order to maintain full quality service to customers,Every angel shall meet minimum requirements of Experience and skill,Please provide as much information so that we may Approve you asap.",
              //   )
              // ),
              ActionButton(
                name: "Done",
                onTap: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      )
    );
  }
}


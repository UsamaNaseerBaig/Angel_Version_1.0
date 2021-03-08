import 'dart:async';

import 'package:angel_v1/controller/angel_identity_register.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:angel_v1/view/angel_sign_up.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'components.dart';




class MainPage extends StatefulWidget {


  static String id = "MainPageScreen";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();

  String number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffd55a),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Angel Log In",
                textAlign: TextAlign.center,
                style: kLabelStyle.copyWith(letterSpacing:2)
              ),
              SizedBox(
                height: 24,
              ),
              InputField(
                focus: true,
                type: TextInputType.number,
                name: "Enter Phone Number",
                onChange: (phone_num){
                  setState(() {
                    number = phone_num;
                  });
                },
              ),
              SizedBox(
                height: 24,
              ),
              PinCodeTextField(
                enablePinAutofill: false,
                autoFocus: true,
                keyboardType: TextInputType.number,
                appContext: context,
                backgroundColor: kbackgroundColor,
                length: 6,
                obscureText: true,
                animationType: AnimationType.slide,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  selectedColor: kFillerColour,
                  inactiveFillColor: kFillerColour,
                  inactiveColor: kTextColor,
                  activeFillColor: kFillerColour,
                ),
                errorAnimationController: errorController,
                animationDuration: Duration(milliseconds: 300),
                onCompleted: (v)async {
                  AngelIdentityO login =AngelIdentityO(
                      number: number,
                      password: v.toString()
                  );
                  bool status =await login.LogIn();
                  status? Navigator.pushNamed(context, AngelProfile.id):
                    errorController.add(ErrorAnimationType.shake);

                },

              ),
              SizedBox(
                height: 13,
              ),
              ActionButton(
                name: "Register With New Account",
                onTap:  (){
                  //Angel Screen starts here
                  Navigator.pushNamed(context,AngelSignUp.id);
                },
              ),
              GestureDetector(
                child: Text(
                  "Need Help?",
                  style: kDescStyle,
                  textAlign: TextAlign.right,
                ),
                onTap: (){
                  Fluttertoast.showToast(
                      msg: "Call At 0320-1462009",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.yellow,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


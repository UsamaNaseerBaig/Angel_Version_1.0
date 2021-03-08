import 'package:angel_v1/view/angel_accept_request.dart';
import 'package:angel_v1/view/angel_declaration.dart';
import 'package:angel_v1/view/angel_experience.dart';
import 'package:angel_v1/view/angel_identity.dart';
import 'package:angel_v1/view/angel_past_dealing.dart';
import 'package:angel_v1/view/angel_personal_detail.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:angel_v1/view/angel_sign_up.dart';
import 'package:angel_v1/view/billing_view.dart';
import 'package:angel_v1/view/components.dart';
import 'package:angel_v1/view/sign_complete_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'view/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      initialRoute: MainPage.id,
      routes: {
        MainPage.id :(BuildContext context) => MainPage(),
        AngelSignUp.id :(BuildContext context) => AngelSignUp(),
        SignCompleteProfile.id :(BuildContext context) => SignCompleteProfile(),
        AngelIdentity.id :(BuildContext context) => AngelIdentity(),
        AngelPersonalDetail.id :(BuildContext context) => AngelPersonalDetail(),
        AngelDeclaration.id :(BuildContext context) => AngelDeclaration(),
        AngelExperience.id :(BuildContext context) => AngelExperience(),
        AngelProfile.id :(BuildContext context) => AngelProfile(),
        AngelPastDealing.id :(BuildContext context) => AngelPastDealing(),
        AngelAcceptRequest.id :(BuildContext context) => AngelAcceptRequest(),
        AngelBilling.id :(BuildContext context) => AngelBilling(),
        ShowImage.id :(BuildContext context) => ShowImage(),
      },
    );
  }
}
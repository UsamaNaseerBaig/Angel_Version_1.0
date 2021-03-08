import 'dart:io';

import 'package:angel_v1/model/AngelBilling.dart';
import 'package:angel_v1/model/AngelPastDealing.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:flutter/material.dart';

class Billing{
  String charges;
  File photo;
  String angel_number;
  String customer_number;
  DateTime bill_time_stamp;

  Billing({this.charges,this.angel_number,this.bill_time_stamp,this.customer_number,this.photo});

  void AddBillingDetails()async{
    PastDealing past = PastDealing();
    var photo_url = await past.UploadImageAndGiveStorageURL(photo, AngelProfile.angel_number);
    Map<String,dynamic> dealing_info = {
      'image' : photo_url,
      'number' : angel_number,
      'time' : DateTime.now(),
    } ;
    await past.UploadDealing(dealing_info);
    Map<String,dynamic> billing_info = {
      'image' : photo_url,
      'angel_number' : angel_number,
      'time' : DateTime.now(),
      'charges' : charges,
      'customer_number' : customer_number
    } ;
    AngelBilling bill = AngelBilling();
    await bill.UploadBillingDetail(billing_info);
  }


}
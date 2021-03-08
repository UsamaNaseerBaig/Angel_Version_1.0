import 'package:angel_v1/model/AngelEarnings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EarningController{
  static Stream<QuerySnapshot> get angelEarning => AngelEarning().angelEarning;
}
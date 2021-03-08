import 'package:angel_v1/model/ConnectionRequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConnectionRequestController{

  static Stream<QuerySnapshot> get Request => ConnectionRequest().Requests;
}
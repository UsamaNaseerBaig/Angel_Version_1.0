import 'package:angel_v1/controller/connection_request_controller.dart';
import 'package:angel_v1/controller/AngelProfile.dart';
import 'package:angel_v1/controller/earning_controller.dart';
import 'package:angel_v1/view/angel_accept_request.dart';
import 'package:angel_v1/view/angel_past_dealing.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components.dart';

void main() {
  runApp(AngelProfile());
}

class AngelProfile extends StatefulWidget {
  static String id = "AngelTabProfile";
  static String cnic = '';
  static String angel_number = "";
  @override
  _AngelProfileState createState() => _AngelProfileState();
}

class _AngelProfileState extends State<AngelProfile> {
  AngelProfileController angel_obj;
  var profile={};
  var identity = {};
  var personal ={};
  String num='';
  String category='';
  String name='';
  String address='';

  @override
  void initState() {
       getCurrentAngel();
  }
  Future<void> getCurrentAngel()async{
     angel_obj = AngelProfileController();
     await angel_obj.GetCurrentUser();
     profile = await angel_obj.getProfileDetails();
     identity = profile['identity_proof'];
     personal = profile['personal_details'];
     setState(() {
       num = identity['number'];
       AngelProfile.angel_number = identity['number'];
       AngelProfile.cnic = identity['cnic'];
       category = personal['category'];
       name = personal['full_name'];
       address = personal['home_address'];
     });
  }

  String GetLocation(){
    String loc= '';
    setState(() {
      if (category == 'Home-Appliances')
        loc = 'Abid Market';
      else if(category == 'Clothing')
        loc = 'Azam Market';
      else if (category == 'Electronics')
        loc = "Hafeez Center";
    });
    return loc;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: kbackgroundColor,
            appBar: AppBar(
              backgroundColor: kbackgroundColor,
              bottom: TabBar(
                labelStyle: kTextStyle,
                labelColor: kFillerColour,
                indicatorColor: kFillerColour,
                unselectedLabelColor: kTextColor,
                tabs: [
                  Tab(text: "Requests",icon: Icon(Icons.call)),
                  Tab(text: "Profile",icon: Icon(Icons.account_circle_outlined)),
                  Tab(text: "Earnings",icon: Icon(Icons.attach_money)),
                ],
              ),
              title: Center(
                  child: Text(
                    'Angel',
                    style: kLabelStyle.copyWith(fontSize: 30),
                  )
              ),
            ),
            body: TabBarView(
              children: [
               Column(//tab bar for received requests
                 children: [
                   StreamBuilder<QuerySnapshot>(
                     stream: ConnectionRequestController.Request,
                     builder: (context,snapshot){
                       if (!snapshot.hasData || snapshot.hasError) return Center(child: CircularProgressIndicator(),);
                       List<ConnectionTile> tile_List=  [];
                       try{ //in case of crash
                         String cust_name;
                         String number;
                         String budget;
                         String Date;
                         for (var snap in snapshot.data.docs){
                           cust_name = snap['from'];
                           final String message = snap['message'];
                           budget = snap['budget'];
                           number = snap['number'];
                           Timestamp time = snap['time'];
                           DateTime date = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
                           Date = "${date.day}/${date.month}/${date.year}";
                           var req = ConnectionTile(
                             title: message,
                             name: cust_name,
                             Date: Date,
                             number: number,
                             desc: "",
                             budget:budget,
                             time: "${date.hour} : ${date.minute}",
                           );
                           tile_List.add(req);
                         }
                       }
                       catch(e){
                         print(e);
                       }
                       return Expanded(
                         child: ListView.builder(
                             itemBuilder: (context,index){
                               return GestureDetector(
                                 onTap: (){
                                   Navigator.push(
                                       context, new MaterialPageRoute(
                                       builder: (context) => new AngelAcceptRequest(),
                                       settings: RouteSettings(
                                         arguments: AcceptRequestArgs(
                                           name: tile_List[index].name,
                                           Date: tile_List[index].Date,
                                           number: tile_List[index].number,
                                           budget: tile_List[index].budget,
                                         )
                                       )
                                      )
                                      );
                                   },
                                 child: ConnectionTile(
                                   title: tile_List[index].title,
                                   name: tile_List[index].name,
                                   desc: tile_List[index].desc,
                                   budget: tile_List[index].budget,
                                   time: tile_List[index].time,
                                 ),
                               );
                             },
                           itemCount: tile_List.length,
                         ),
                       );
                     },
                   )
                 ],
               ),
               Column(//tab bar for Angel Main profile
                 children: [
                   Expanded(
                     flex: 2,
                     child: Column(//for image,name,address,rating
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         CircleAvatar(
                           backgroundColor: kbackgroundColor,
                           child: Icon(Icons.account_circle,size: 54,),
                         ),
                         SizedBox(
                           height: 10,
                         ),
                         Text(name,style: kTextStyle,),
                         Text(address,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text("Rating",style: kTextStyle,),
                             SizedBox(
                               width: 20,
                             ),
                             Icon(Icons.star,color: kFillerColour,),
                             Icon(Icons.star,color: kFillerColour,),
                             Icon(Icons.star,color: kFillerColour,),
                           ],
                         ),
                       ],
                     ),
                   ),
                   Expanded(
                     flex: 7,
                     child: ListView(
                       children: [
                         RequestTile(
                           icon: Icon(Icons.call),
                           title: num,
                           desc: "Whatsapp/jazz",
                         ),
                         SizedBox(
                           height: 24,
                           child: Divider(
                             color: kTextColor,
                             indent: 73,
                             endIndent: 22,
                           ),
                         ),
                         RequestTile(
                           icon: Icon(Icons.mail),
                           title: AngelProfile.cnic,
                           desc: "CNIC Number",
                         ),
                         SizedBox(
                           height: 24,
                           child: Divider(
                             color: kTextColor,
                             indent: 73,
                             endIndent: 22,
                           ),
                         ),
                         RequestTile(
                           icon: Icon(Icons.laptop_mac),
                           title:category,
                           desc: "Shopping Category",
                         ),
                         SizedBox(
                           height: 24,
                           child: Divider(
                             color: kTextColor,
                             indent: 73,
                             endIndent: 22,
                           ),
                         ),
                         RequestTile(
                           icon: Icon(Icons.shopping_bag_sharp),
                           title: "Past Dealings",
                           desc: "Click To View",
                           ontap: (){
                             Navigator.pushNamed(context,AngelPastDealing.id);
                           },
                         ),
                         SizedBox(
                           height: 24,
                           child: Divider(
                             color: kTextColor,
                             indent: 73,
                             endIndent: 22,
                           ),
                         ),
                         RequestTile(
                           icon: Icon(Icons.location_on_rounded),
                           title: "Working Area",
                           desc: GetLocation(),
                         ),
                         SizedBox(
                           height: 24,
                           child: Divider(
                             color: kTextColor,
                             indent: 73,
                             endIndent: 22,
                           ),
                         ),
                       ],
                     ),
                   )
                 ],
               ),
               Column(//tab bar for angel earning status
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded
                     (
                     flex: 3,
                       child: StreamBuilder<QuerySnapshot>(
                         stream: EarningController.angelEarning,
                         builder: (context,snapshot){
                           if (!snapshot.hasData || snapshot.hasError){
                             print("i am about to generate progress");
                             return Center(
                               child: CircularProgressIndicator(
                                 backgroundColor: kbackgroundColor,
                               ),
                             );
                           }
                           final bill_detail = snapshot.data.docs; //past dealings  are empty
                           var no_of_client = bill_detail.length;
                           double earned = 0;
                           for (var bill in bill_detail){
                             earned += double.parse(bill['charges']);
                           }
                           print("${earned} earned having clients ${no_of_client}");
                           return Column(
                             children: [
                               RequestTile(
                                 icon: Icon(Icons.account_circle_rounded),
                                 title: no_of_client.toString(),
                                 desc: "No of Clients",
                               ),
                               SizedBox(
                                 height: 24,
                                 child: Divider(
                                   color: kTextColor,
                                   indent: 73,
                                   endIndent: 22,
                                 ),
                               ),
                               RequestTile(
                                 icon: Icon(Icons.attach_money_sharp),
                                 title: earned.toString(),
                                 desc: "Earned",
                               ),
                               SizedBox(
                                 height: 24,
                                 child: Divider(
                                   color: kTextColor,
                                   indent: 73,
                                   endIndent: 22,
                                 ),
                               ),

                             ],
                           );
                         },
                       )
                   ),
                 ],
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


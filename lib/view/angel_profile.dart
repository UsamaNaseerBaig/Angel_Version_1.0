import 'package:angel_v1/model/AngelCredential.dart';
import 'package:angel_v1/controller/AngelProfile.dart';
import 'package:angel_v1/view/angel_accept_request.dart';
import 'package:angel_v1/view/angel_past_dealing.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components.dart';

void main() {
  runApp(AngelProfile());
}

class AngelProfile extends StatefulWidget {
  static String id = "AngelTabProfile";
  static String cnic='';
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
    // TODO: implement initState
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
                   RequestTile(
                     ontap: (){
                       Navigator.pushNamed(context, AngelAcceptRequest.id);
                     },
                     title: "Usama",
                     desc: "03201342330",
                     icon: CircleAvatar(
                       backgroundColor: kbackgroundColor,
                       child: Icon(Icons.account_circle,size: 54,),
                     ),
                     end: Text("${DateTime.now().hour}:${DateTime.now().minute}"),
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
               Column(//tab bar for Angel Main profile
                 children: [
                   Expanded(
                     flex: 1,
                     child: Column(//for image,name,address,rating
                       children: [
                         CircleAvatar(
                           backgroundColor: kbackgroundColor,
                           child: Icon(Icons.account_circle,size: 54,),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         Text(name,style: kTextStyle,),
                         Text(address,),
                         SizedBox(
                           height: 20,
                         ),
                         Expanded(
                           child: Row(
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
                         ),
                       ],
                     ),
                   ),
                   Expanded(
                     flex: 3,
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
                       child: Column(
                         children: [
                           RequestTile(
                             title: "June 2020",
                             desc: "Date",
                             icon: Icon(Icons.calendar_today),
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
                             title: "10",
                             desc: "No of Clients",
                             icon: Icon(Icons.account_circle),
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
                             title: "RS/-4000 Rupees",
                             desc: "Earned",
                             icon: Icon(Icons.attach_money),
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
                       )
                   ),
                   Expanded(
                     flex: 2,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         RequestTile(
                           title: "RS/-1000 Rupees",
                           desc: "Charges",
                           icon: Icon(Icons.attach_money),
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
                           title: "1 july, 2020",
                           desc: "Last Date",
                           icon: Icon(Icons.calendar_today),
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
                     )
                   ),
                   ActionButton(
                     name: "Pay Via",
                   )
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



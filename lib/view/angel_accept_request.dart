import 'package:angel_v1/view/billing_view.dart';
import 'package:flutter/material.dart';
import 'components.dart';
import 'constants.dart';
import 'package:url_launcher/url_launcher.dart';


class AngelAcceptRequest extends StatefulWidget {
  static String id = "/AngelAcceptRequest";
  static String cust_number = "";

  @override
  _AngelAcceptRequestState createState() => _AngelAcceptRequestState();
}

class _AngelAcceptRequestState extends State<AngelAcceptRequest> {

  double charges=0;

  void customLaunch(command)async{
    if (await  canLaunch(command)) {
    await launch(command);
    } else {
    throw 'Could not launch $command';
    }
  }


  @override
  Widget build(BuildContext context) {
    final AcceptRequestArgs args = ModalRoute.of(context).settings.arguments;
    charges = double.parse(args.budget)/100;
    AngelAcceptRequest.cust_number = args.number;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kFillerColour,
        onPressed: (){
          Navigator.push(
              context, new MaterialPageRoute(
              builder: (context) => new AngelBilling()
          )
          );
        },
        child: Icon(Icons.add_a_photo,color: kTextColor,),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text("Accept Request",style: kTextStyle,),
        iconTheme: IconThemeData(color: kFillerColour),
        backgroundColor: kbackgroundColor,
      ),
      body: SafeArea(
        child: Column(//tab bar for angel earning status
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded
              (
                child: Column(
                  children: [
                    RequestTile(
                      title: args.Date,
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
                      title: "30-60 minutes",
                      desc: "Approx. Shopping Time",
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
                      title: "${args.budget}",
                      desc: "Approx. Budget",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RaisedButton(
                  onPressed: ()=>customLaunch("tel:${args.number}"),
                  padding: EdgeInsets.all(12),
                  color: kFillerColour,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                    child: Icon(Icons.call,color: Colors.green.shade800,),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: ()=>customLaunch('sms:${args.number}'),
                  padding: EdgeInsets.all(12),
                  color: Colors.deepPurple.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                    child: Icon(Icons.message,color: Colors.deepPurple,),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RequestTile(
                      title: "RS/-${charges} Rupees",
                      desc: "Estimate Charges",
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
                    Padding(
                      padding: EdgeInsets.only(top: 5,right: 5,left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("ڈیل طے کرنے کیلئے کسٹمر کو کال یا ایس ایم ایس کریں-",style: kDescStyle.copyWith(color: Colors.red),),
                          Text("اپنے صارف کے لئے بہترین خریدیں-",style: kDescStyle.copyWith(color: Colors.red),),
                          Text("خریداری کے بعد،کل فیس کے لئے رسید اپ لوڈ کریں-",style: kDescStyle.copyWith(color: Colors.red),),
                          Text("کل فیس کے لئے نیچے کیمرا بٹن پر کلک کریں-",style: kDescStyle.copyWith(color: Colors.red),),
                        ],
                      ),
                    ),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}

class AddActualDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff756229),
      child: Container(
        child: Padding(
          padding:  EdgeInsets.all(38.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Done Shopping?",style: kTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              InputField(
                type: TextInputType.number,
                name: "Actual Price of Product",
              ),
              SizedBox(
                height: 20,
              ),
              ActionButton(
                name: "Calculate dues",
                onTap: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius:BorderRadius.only(topLeft: Radius.circular(31),topRight: Radius.circular(31)),
            color: kbackgroundColor
        ),
      ),
    );
  }
}

class AcceptRequestArgs{
  String Date;
  String number;
  String name;
  String budget;
  AcceptRequestArgs({this.Date,this.number,this.name,this.budget});
}
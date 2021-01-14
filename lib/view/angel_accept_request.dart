import 'package:flutter/material.dart';
import 'components.dart';
import 'constants.dart';
class AngelAcceptRequest extends StatelessWidget {
  static String id = "/AngelAcceptRequest";

  int min;
  double price;
  double charges;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        title: Text("Accept Request",style: kTextStyle,),
        iconTheme: IconThemeData(color: kFillerColour),
        backgroundColor: kbackgroundColor,
      ),
      body: SafeArea(
        child: Column(//tab bar for angel earning status
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
                      title: "60 minutes",
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
                      title: "RS/-30,000 - 45,000 Rupees",
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
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RequestTile(
                      title: "RS/-300 - 450 Rupees",
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
                  ],
                )
            ),
            ActionButton(
              name: "Accept & Start Shopping",
              onTap: () {
                showModalBottomSheet<void>(context: context,builder: (BuildContext context){
                  return AddActualDetail();
                });
              }
            )
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

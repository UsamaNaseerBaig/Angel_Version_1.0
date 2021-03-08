import 'package:angel_v1/view/angel_identity.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ActionButton extends StatelessWidget {

  final Function onTap;
  final String name;

  ActionButton({this.onTap,this.name});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        name,
        style: kTextStyle,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kFillerColour),
        side: MaterialStateProperty.all(
            BorderSide(width: 2, color: kTextColor)),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
        elevation: MaterialStateProperty.all(24),
      ),
    );
  }
}

//for Action Description


class ActionDescription extends StatelessWidget {
  final String desc;
  ActionDescription({this.desc});
  @override
  Widget build(BuildContext context) {
    return Text(
      desc,
      textAlign: TextAlign.center,
      style: kTextStyle,
    );
  }
}

//custom input/text field

class InputField extends StatelessWidget {

  final TextInputType type;
  final String name;
  final Function onChange;
  final bool focus;
  InputField({this.name,this.focus,this.onChange,this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextFormField(
        keyboardType: type,
        onChanged: onChange,
        style: kTextStyle,
        autofocus: focus!=null?focus:false,
        cursorColor: kFillerColour,
        decoration: InputDecoration(
            fillColor: kFillerColour,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kFillerColour, width: 2.0),
            ),
            border: OutlineInputBorder(),
            labelText: name,
            labelStyle: kTextStyle
        ),
      ),
    );
  }
}


//....image widget
class GetImageWidget extends StatelessWidget {
  final image;
  final double width;
  final double height;
  GetImageWidget({this.image,this.width,this.height});
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 20,bottom: 20),
      height: height,
      width: width,
      child:image != null?Container(
          child: Image.file(image),
        decoration: BoxDecoration(
            border: Border.all(
                color: kTextColor,
                width: 3
            )
        ),
      ):Text("Add Photo"),
    );

  }
}

//request tile
class RequestTile extends StatelessWidget {

  final String title;
  final String desc;
  final Widget icon;
  final Widget end;
  final Function ontap;
  RequestTile({this.desc,this.title,this.icon,this.end,this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 5,right: 5,left: 15),
      dense: true,
      onTap: ontap,
      title: Text(title,style: kTextStyle,),
      subtitle: Text(desc),
      leading: icon,
      trailing: end,
    );
  }
}

//image viewer
class ShowImage extends StatelessWidget {

  static String id ="extractArgument";
  @override
  Widget build(BuildContext context) {
    final ScreenArgument args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: kFillerColour
            ),
            backgroundColor: Colors.black,
            title: Text("Images",style: kTextStyle.copyWith(color: Colors.white),),
          ),
          body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: args.image,
          ),
        ),
        ),
      )
    );
  }
}

class ScreenArgument{
  final image;
  final int index;
  ScreenArgument({this.index,this.image});
}

class GeneratePin extends StatelessWidget {
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
                "Generate Your Pin Code",style: kTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                autoFocus: true,
                keyboardType: TextInputType.number,
                appContext: context,
                backgroundColor: kbackgroundColor,
                length: 6,
                obscureText: false,
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
                animationDuration: Duration(milliseconds: 300),
                onCompleted: (v) {
                  AngelIdentity.pin = v;
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 20,
              ),
              ActionButton(
                name: "Confirm Pin Code",
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

class AlertInfo extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final List<Widget> action;

  AlertInfo({this.title,this.children,this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: title,
        content: SingleChildScrollView(
          child: ListBody(
              children: children
          ),
        ),
        actions: action
    );
  }
}

class GetImageWidgetViaUrl extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  GetImageWidgetViaUrl({this.url,this.width,this.height});
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 20,bottom: 20),
      height: height,
      width: width,
      child:url != null?Container(
        child: Image.network(url),
        decoration: BoxDecoration(
            border: Border.all(
                color: kTextColor,
                width: 3
            )
        ),
      ):Text("Add Photo"),
    );

  }
}

class ConnectionTile extends StatelessWidget {

  final String title;
  final String desc;
  final String budget;
  final String time;
  final String name;
  final String number;
  final String Date;


  final Function ontap;
  ConnectionTile({this.name,this.Date,this.number,this.desc,this.title,this.time,this.budget,this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From: ${name}",style: kTextStyle,),
            Text("Message: ${title}",style: kTextStyle,),
            Text(desc,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Approx. Budget: ${budget} RS/-",style: kTextStyle,),
                Text(time,style: kTextStyle,),
              ],
            ),
            SizedBox(
              height: 24,
              child: Divider(
                color: kTextColor,
                indent: 13,
                endIndent: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
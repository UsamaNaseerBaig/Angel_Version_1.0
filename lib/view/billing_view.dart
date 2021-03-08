import 'package:angel_v1/controller/billingO.dart';
import 'package:angel_v1/view/angel_accept_request.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:angel_v1/view/components.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class AngelBilling extends StatefulWidget {

  //get image code
  static String id = "AngelBilling";

  @override
  _AngelBillingState createState() => _AngelBillingState();
}

class _AngelBillingState extends State<AngelBilling> {

  List<File> _image=[];
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        _image.add(image);

        //end here
      } else {
        print('No image selected.');
      }
    });
    if (_image.isEmpty || charges == 0)
    {
      Fluttertoast.showToast(
          msg: "UnSuccessful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }
    else{
      print("${DateTime.now()}/n ${charges} ${AngelProfile.angel_number} ${_image.first} ${AngelAcceptRequest.cust_number}");
      //Giving Object To controller file billingO
      Billing billing = Billing(
          bill_time_stamp: DateTime.now(),
          charges: charges.toString(),
          angel_number: AngelProfile.angel_number,
          photo: _image.first,
          customer_number: AngelAcceptRequest.cust_number
      );
      await billing.AddBillingDetails();
      Fluttertoast.showToast(
          msg: "Details Have been added to Your Profile",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);
    }
    //end here
  }

  double charges = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _image.length == 1?Center(child: CircularProgressIndicator()):FloatingActionButton(
        backgroundColor: kFillerColour,
        onPressed:getImage,
        child: Icon(Icons.add_a_photo,color: kTextColor,),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: kFillerColour
        ),
        backgroundColor: kbackgroundColor,
        title: Text("Final Charges",style: kTextStyle,),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Calculate Final Charges",style: kLabelStyle,),
                    InputField(
                      name: "Final Price of Product",
                      onChange: (newValue){
                        setState(() {
                          newValue.toString().isEmpty ? charges = 0:charges = double.parse(newValue) / 100;
                        });
                      },
                      type: TextInputType.number,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Upload Receipt photo ",style: kTextStyle,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return GetImageWidget(
                                image: _image[index],
                                width: 150,
                                height: 300,
                              );
                            },
                            itemCount: _image.length,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _image.length == 1 ?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Charges",style: kLabelStyle.copyWith(fontSize: 22),),
                      Text("${charges}  RS/-",style: kLabelStyle.copyWith(fontSize: 22),)
                    ],
                  ):Text(""),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




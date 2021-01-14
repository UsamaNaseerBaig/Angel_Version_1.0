import 'package:angel_v1/controller/angel_identity_register.dart';
import 'package:angel_v1/view/components.dart';
import 'package:angel_v1/view/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AngelIdentity extends StatefulWidget {

  //get image code
  static String id = "AngelIdentity";
  static String pin;
  static String angel_id;
  @override
  _AngelIdentityState createState() => _AngelIdentityState();
}

class _AngelIdentityState extends State<AngelIdentity> {

  List<File> _image=[];
  final picker = ImagePicker();
  String number;
  String cnic;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        var image = File(pickedFile.path);
        _image.add(image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _image.length == 2?Icon(Icons.check,size: 71,color: kFillerColour,):FloatingActionButton(
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
        title: Text("Identity Proof",style: kTextStyle,),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
              flex: 1,
              child: Text("Kindly add Details",style: kLabelStyle,)),
              Expanded(
                flex: 1,
                child: InputField(
                  name: "Enter Your Phone Number",
                  onChange: (newValue){
                    setState(() {
                      number = newValue;
                    });
                  },
                  type: TextInputType.number,
                ),
              ),
              Expanded(
                flex: 1,
                child: InputField(
                  name: "Enter Your CNIC Number",
                  onChange: (newValue){
                    setState(() {
                      cnic = newValue;

                    });
                  },
                  type: TextInputType.number,
                ),
              ),
              Text(
                "Upload CNIC Front and Back photo",style: kTextStyle,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        child: GetImageWidget(
                            image: _image[index],
                          width: 150,
                          height: 300,
                        ),
                        onTap: (){
                          Navigator.pushNamed(
                              context,
                              ShowImage.id,
                              arguments:ScreenArgument(
                                image: Image.file(_image[index]),
                              )
                          );
                        },

                      );
                    },
                    itemCount: _image.length,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ActionButton(
                  name: "Complete Identity Proof",
                  onTap: () async {
                    print("cnic set");
                    if (number.length == 11 && cnic.length == 13 && _image.length == 2) {
                          await showModalBottomSheet<void>(
                              context: context, builder: (BuildContext context) {
                            return GeneratePin();
                          });
                          if (AngelIdentity.pin.length == 6) {
                              AngelIdentityO angel_credential = AngelIdentityO(
                                number: number,
                                cnic: cnic,
                                imageList: _image,
                                password: AngelIdentity.pin,
                              );
                              var created = await angel_credential.Register();
                              AngelIdentity.angel_id = cnic;
                              if (created == true) {
                                angel_credential.CompleteIdentity();
                              }
                              else {
                                print("cannot create identity");
                              }
                          }
                          else{
                            print(AngelIdentity.pin);
                          }
                    }
                    else{
                      _showMyDialog(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertInfo(
        title: Text('Invalid Entries'),
        children: <Widget>[
          Text('Make Sure your number is like 03224800342'),
          Text('Make Sure your cnic is like3520345345678'),
          Text('Add front and back cnic photo'),
        ],
        action: <Widget>[
          TextButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



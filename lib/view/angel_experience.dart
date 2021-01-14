import 'package:angel_v1/controller/angel_experience_info.dart';
import 'package:angel_v1/view/angel_identity.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'components.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AngelExperience extends StatefulWidget {

  static String id = "AngelExperience";

  @override
  _AngelExperienceState createState() => _AngelExperienceState();
}

class _AngelExperienceState extends State<AngelExperience> {

  List<File> _image=[];
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        var new_image = File(pickedFile.path);
        _image.add(new_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kFillerColour,
        onPressed: getImage,
        child: Icon(Icons.add_a_photo,color: kTextColor,),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: kFillerColour
        ),
        backgroundColor: kbackgroundColor,
        title: Text("Experience Info/Proof",style: kTextStyle,),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ActionButton(
                name: "save",
                onTap: ()async{
                  //send photos to db
                  AngelExperienceInfoO exp = AngelExperienceInfoO(
                    experience_image: _image
                  );

                  _image.length >= 2 ? await exp.AddExperience(AngelIdentity.angel_id):print("add atleast two images");
                  AngelExperienceInfoO.exp_status?Navigator.pop(context):null;
                },
              ),
              Text(
                  "Experience Letters",style: kLabelStyle,
              ),
              Text("${_image.length.toString()} photos",style: kTextStyle,),
              Text("Upload Photos of experience letter, your work Related experience proof atleast 2",style: kTextStyle,),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    reverse: true,
                    itemBuilder: (context,index){
                      return GestureDetector(
                          child: GetImageWidget(image: _image[index]),
                        onTap: (){
                            print("ss");
                        },

                      );
                    },
                    itemCount: _image.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




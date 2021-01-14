import 'package:angel_v1/controller/angel_experience_info.dart';
import 'package:angel_v1/view/angel_profile.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'components.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AngelPastDealing extends StatefulWidget {

  static String id = "AngelPastDealing";
  static var image_stream;
  static int image_count=0;
  static List<String> image_string=[];

  @override
  _AngelPastDealingState createState() => _AngelPastDealingState();
}

class _AngelPastDealingState extends State<AngelPastDealing> {
  List<File> _image=[];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() async{
      if (pickedFile != null) {
          var new_image = File(pickedFile.path);
          _image.add(new_image);
          AngelExperienceInfoO exp = AngelExperienceInfoO(
              dealing_image: _image
          );
          !_image.isEmpty ? await exp.AddPastDealing(AngelProfile.cnic):print("cant add empty");
          if (AngelExperienceInfoO.deal_status)
            {
            setState(() {
            _image= [];
            });
            }
      }else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    GetPastImages();
  }

  void GetPastImages()async{
    try{
      AngelExperienceInfoO get_image = AngelExperienceInfoO();
      await get_image.GetImages();
    }
    catch(e){
      print(e);
    }
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
        title: Text("Past Dealings",style: kTextStyle,),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                "Past Receipt/proof",style: kLabelStyle,
              ),
              Text("${AngelPastDealing.image_count.toString()} photos",style: kTextStyle,),
              Text("Upload Photos of  your past dealing Receipt make Sure they are clear and precise so that users will be Able to see these photos",style: kTextStyle,),
              Expanded(
                flex: 3,
                  child:StreamBuilder(
                    stream: AngelPastDealing.image_stream,
                    builder: (context,snapshot){
                      if (!snapshot.hasData){
                        print("i am about to generate progress");
                      return Center(
                      child: CircularProgressIndicator(
                      backgroundColor: kbackgroundColor,
                      ),
                      );
                      }
                      AngelPastDealing.image_string = [];
                      final images = snapshot.data; //past dealings  are empty
                      print(images['past_dealings']);
                        final lst = images['past_dealings'];
                        final List<Widget> url_image=[];
                        for (var lst_string in lst){
                          final url = lst_string.toString();
                          AngelPastDealing.image_string.add(url);
                          url_image.add(
                            GestureDetector(
                              child: GetImageWidgetViaUrl(
                                url: url,
                                height: 300,
                                width: 300,
                              ),
                              onTap: (){
                                Navigator.pushNamed(
                                    context,
                                    ShowImage.id,
                                    arguments:ScreenArgument(
                                      image: Image.network(url),
                                    )
                                );
                              },
                            )
                          );
                        }
                        AngelPastDealing.image_count = url_image.length;
                      return ListView(
                        children: url_image,
                      );
                    },
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}




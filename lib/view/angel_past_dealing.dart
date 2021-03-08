import 'package:angel_v1/controller/past_dealing_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'components.dart';


class AngelPastDealing extends StatefulWidget {

  static String id = "AngelPastDealing";
  static var image_stream;
  static int image_count=0;
  static List<String> image_string=[];

  @override
  _AngelPastDealingState createState() => _AngelPastDealingState();
}

class _AngelPastDealingState extends State<AngelPastDealing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Past Dealings",style: kLabelStyle,
              ),
              Text("${AngelPastDealing.image_count.toString()} photos",style: kTextStyle,),
              Text("Upload Photos of  your past dealing Receipt make Sure they are clear and precise so that users will be Able to see these photos",style: kTextStyle,),
              Expanded(
                flex: 3,
                  child:StreamBuilder<QuerySnapshot>(
                    stream: PastDealingController.PastDealings,
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
                      final images = snapshot.data.docs; //past dealings  are empty
                        final List<Widget> url_image=[];
                        for (var lst_string in images){
                          final url = lst_string['image'];
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




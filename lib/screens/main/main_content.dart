import 'dart:io';

import 'package:awsimagecaption/screens/main/widgets/option_button.dart';
import 'package:awsimagecaption/utils/app_colors.dart';
import 'package:awsimagecaption/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../result/result_screen.dart';

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {

  final picker = ImagePicker();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: applicationColors['gunmetal'],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(AppIcons.attach,
              color: applicationColors['cyan'],
              size: MediaQuery.of(context).size.shortestSide * 0.2
            ),
          ),
          SizedBox(height: 16.0,),
          RichText(
            text: TextSpan(text: 'Image', style: TextStyle(
                    color: applicationColors['sienna'], fontSize: 22
                ),
            children: <TextSpan>[
                  TextSpan(text: 'Caption', style: TextStyle(
                      color: applicationColors['sienna'],
                      fontWeight: FontWeight.bold, fontSize: 22
                    ),
                  )
                ]
            ),
          ),
          SizedBox(height: 32,),
          OptionButton(
            color: applicationColors['skyblue'],
            text: 'Select image',
            icon: Icons.image,
            textColor: applicationColors['gunmetal'],
            splashColor: applicationColors['dazzled'],
            onPressed: _selectImage,
          ),
          OptionButton(
            color: applicationColors['sienna'],
            text: 'Take photo',
            icon: Icons.camera,
            textColor: applicationColors['gunmetal'],
            splashColor: Colors.red[900],
            onPressed: _takePhoto,
          )
        ],
      ),
    );
  }

  Future _selectImage() async {
    await picker.getImage(source: ImageSource.gallery).then((image) {
      setState(() { _image = File(image.path); });

      proceedToResult();
    });
  }

  Future _takePhoto() async {
    await picker.getImage(source: ImageSource.camera).then((image) {
      setState(() { _image = File(image.path); });

      proceedToResult();
    });
  }

  proceedToResult() {
    if (_image != null) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(settings: const RouteSettings(name: '/results'),
              builder: (context) =>
                  ResultsScreen(image: _image)
      ));
    }
  }
}

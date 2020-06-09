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
        color: AppColors.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(AppIcons.attach,
            color: AppColors.onPrimary,
            size: MediaQuery.of(context).size.shortestSide * 0.24
          ),
          SizedBox(height: 8.0,),
          RichText(
            text: TextSpan(text: 'Image', style: TextStyle(
                    color: AppColors.accentColor, fontSize: 24
                ),
            children: <TextSpan>[
                  TextSpan(text: 'Caption', style: TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.bold, fontSize: 24
                    ),
                  )
                ]
            ),
          ),
          SizedBox(height: 8.0,),
          OptionButton(
            color: AppColors.secondAccentColor,
            text: 'Select image',
            icon: Icons.image,
            textColor: AppColors.primaryColor,
            splashColor: AppColors.secondAccentColorDark,
            onPressed: _selectImage,
          ),
          OptionButton(
            color: AppColors.accentColor,
            text: 'Take photo',
            icon: Icons.camera,
            textColor: AppColors.primaryColor,
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
    }).catchError((e) {
      print(e);
    });
  }

  Future _takePhoto() async {
    await picker.getImage(source: ImageSource.camera).then((image) {
      setState(() { _image = File(image.path); });

      proceedToResult();
    }).catchError((e) {
      print(e);
    });
  }

  proceedToResult() {
    if (_image != null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ResultsScreen(image: _image)
      ));
    }
  }
}

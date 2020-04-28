import 'package:awsimagecaption/screens/main/widgets/option_button.dart';
import 'package:awsimagecaption/utils/app_colors.dart';
import 'package:awsimagecaption/utils/icons.dart';
import 'package:flutter/material.dart';

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: applicationColors['gunmetal'],
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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
                onPressed: () => {},
              ),
              OptionButton(
                color: applicationColors['sienna'],
                text: 'Take photo',
                icon: Icons.camera,
                textColor: applicationColors['gunmetal'],
                splashColor: Colors.red[900],
                onPressed: () => {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

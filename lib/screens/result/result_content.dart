import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ResultsContent extends StatefulWidget {
  final File image;

  ResultsContent({this.image});

  @override
  _ResultsContentState createState() => _ResultsContentState();
}

class _ResultsContentState extends State<ResultsContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: applicationColors['gunmetal'],
      ),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: applicationColors['cyan'], size: 24.0,),
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/main'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text("Navigate back to choose image", style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: applicationColors['cyan'],
                      fontSize: 20.0
                  )),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      child: Image.file(
                          widget.image, fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width * 0.8
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

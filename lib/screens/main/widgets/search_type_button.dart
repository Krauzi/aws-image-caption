import 'package:awsimagecaption/utils/app_colors.dart';
import 'package:flutter/material.dart';

typedef void OnClick();

class SearchTypeButton extends StatelessWidget {
  final OnClick onPressed;
  final String text;
  final Color color;
  final Color splashColor;

  SearchTypeButton({this.onPressed, this.text, this.color, this.splashColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)
              ),
              splashColor: splashColor,
              color: color,
              child: Text(text.toUpperCase(),
               style: TextStyle(color: AppColors.primaryColor, fontSize: 18.0),
              ),
              onPressed: onPressed,
            ),
          )
        ],
      )
    );
  }
}
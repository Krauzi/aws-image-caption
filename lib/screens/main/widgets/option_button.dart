import 'package:flutter/material.dart';

typedef void OnClick();

class OptionButton extends StatelessWidget {
  final OnClick onPressed;
  final String text;
  final Color textColor;
  final Color color;
  final Color splashColor;
  final IconData icon;

  OptionButton({this.onPressed, this.text, this.color,
    this.textColor, this.splashColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 32.0, right: 32.0, top: 36.0),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
                ),
                splashColor: splashColor,
                color: color,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(text.toUpperCase(),
                        style: TextStyle(color: textColor, fontSize: 16.0),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Transform.translate(
                        offset: Offset(8.0, 0.0),
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              splashColor: Colors.white,
                              color: textColor,
                              child: Icon(icon, color: color,),
                              onPressed: onPressed,
                          ),
                        ),
                    )
                  ],
                ),
                onPressed: onPressed,
              ),
            )],
          )
        );
  }
}
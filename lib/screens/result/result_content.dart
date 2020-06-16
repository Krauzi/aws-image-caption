import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:awsimagecaption/blocs/aws_bloc.dart';
import 'package:awsimagecaption/datasource/ec2_caption.dart';
import 'package:awsimagecaption/datasource/polly_get.dart';
import 'package:awsimagecaption/datasource/polly_send.dart';
import 'package:awsimagecaption/datasource/rekognition_labels.dart';
import 'package:awsimagecaption/screens/main/main_screen.dart';
import 'package:awsimagecaption/screens/main/widgets/search_type_button.dart';
import 'package:awsimagecaption/utils/app_config.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../utils/app_colors.dart';

class ResultsContent extends StatefulWidget {
  final File image;

  ResultsContent({this.image});

  @override
  _ResultsContentState createState() => _ResultsContentState();
}

class _ResultsContentState extends State<ResultsContent>
    with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation<Offset> offset;

  Audio _audio;

  WebSocketChannel channel;

  StreamSubscription _resultSubscription;
  Ec2Bloc _ec2bloc;

  String result = "";
  bool initialData;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
      value: initialData == true ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    initialData = false;
    _ec2bloc = BlocProvider.getBloc();

    _resultSubscription = _ec2bloc.captionObservable.listen(_getCaption);
  }

  @override
  void dispose() {
    super.dispose();

    channel.sink.close();
    _resultSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: AppColors.onPrimary, size: 24.0,),
                    onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text("Navigate back to choose image", style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.onPrimary,
                        fontSize: 20.0
                    )),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.33,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(widget.image),
                                fit: BoxFit.scaleDown
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: SearchTypeButton(
                                  color: AppColors.accentColor,
                                  onPressed: _onEc2SearchClick,
                                  splashColor: Colors.red[800],
                                  text: "Our model",
                                ),
                              ),
                              Expanded(flex: 0, child: Container(width: 16.0)),
                              Expanded(
                                flex: 1,
                                child: SearchTypeButton(
                                  color: AppColors.secondAccentColor,
                                  onPressed: _onRekognitionClick,
                                  splashColor: AppColors.secondAccentColorDark,
                                  text: "Rekognition",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: StreamBuilder(
                        stream: _ec2bloc.loadingCaptionObservable,
                        initialData: initialData,
                        builder: (context, snapshot) {
                          if (snapshot.data) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            initialData = !initialData;
                            return Container(
                              padding: EdgeInsets.only(top: 20.0),
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: FadeTransition(
                                  opacity: new CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.easeOut,
                                  ),
                                  child: SizeTransition(
                                    axisAlignment: -1,
                                    sizeFactor: new CurvedAnimation(
                                      parent: _animationController,
                                      curve: Curves.bounceIn,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget> [
                                        Text("Result:", style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w500
                                        )),
                                        Text(result, style: TextStyle(
                                          color: AppColors.onPrimary,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w300
                                        )),
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  void _onEc2SearchClick() async {
    initialData = false;
    _ec2bloc.getEc2Caption(widget.image);
    _animationController.reverse();
  }

  void _onRekognitionClick() async {
    initialData = false;
    _ec2bloc.getRekognitionLabels(widget.image);
    _animationController.reverse();
  }

  void _getCaption(Object object) {
    if (object is Ec2Caption) {
      setState(() {
        result = object.caption;
        _webSocket(object.caption);
        _animationController.forward();
      });
    } else if (object is RekognitionLabels) {
      setState(() {
        result = object.labelWithPercentage;
        _webSocket(object.labels);
        _animationController.forward();
      });
    }
  }

  void _webSocket(String text) async {
    var channel = IOWebSocketChannel.connect(AppConfig.webSocket);
    channel.sink.add("{\"textToSpeech\": \"$text\"}");
    channel.stream.listen((response) { _processResponse(response); });
  }

  void _processResponse(String text) async {
    Map<String, dynamic> resp = jsonDecode(text);

    List<int> byteArray = new List<int>.from(resp['response']['data']);
    ByteData bd = ByteData(byteArray.length);

    for (int i = 0; i < byteArray.length; i++)
      bd.setUint8(i, byteArray[i]);

    Audio.loadFromByteData(bd)
      ..play()
      ..setVolume(1.0);
  }
}
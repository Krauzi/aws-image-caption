import 'dart:io';

import 'package:flutter/material.dart';

import 'result_content.dart';

class ResultsScreen extends StatelessWidget {

  final File image;

  ResultsScreen({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ResultsContent(image: image),
    );
  }
}
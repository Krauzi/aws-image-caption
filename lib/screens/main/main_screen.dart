import 'package:flutter/material.dart';

import 'main_content.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: MainContent(),
    );
  }
}

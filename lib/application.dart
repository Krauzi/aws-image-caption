import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'injection/bloc_module.dart';
import 'injection/dependency_module.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: appBlocs,
      dependencies: appDependencies,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Caption',
        routes: _routes,
        // initialRoute: '/',
      ),
    );
  }

  Map<String, Widget Function(BuildContext)> get _routes => {

  };
}

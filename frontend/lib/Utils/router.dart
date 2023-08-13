

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Login/LoginScreenNew.dart';

Route<dynamic> generateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case LoginScreenNew.routeName:
      return MaterialPageRoute(
          settings: routeSetting, builder: (_) => const LoginScreenNew());


    default:
      return MaterialPageRoute(
          settings: routeSetting,
          builder: (_) => const Scaffold(
                  body: Center(
                child: Text("Error 404 : Invalid Route "),
              )));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'HomePage/NavPages/firstScreen.dart';
import 'Login/LoginScreenNew.dart';
import 'Utils/router.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isAndroid) PathProviderAndroid.registerWith();
  String? token = await storage.read(key: "Token");
  print(token);
  Widget widget = const LoginScreenNew();
  if (token != null) {
    widget = firstScreen();
    print(widget.toString());
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: (settings) => generateRoute(settings),
    home: widget,//widget,
  ));
}

class PathProviderAndroid {
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shelf_ease/Utils/HexColorUse.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'dart:developer' as devtools show log;

import '../HomePage/NavPages/firstScreen.dart';
import '../global_var.dart';

class LoginScreenNew extends StatefulWidget {
  static const String routeName = "/LoginPage";

  const LoginScreenNew({super.key});

  @override
  _LoginClassState createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginScreenNew> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true, _isLoading = false;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  final List<Widget> users = <Widget>[Text('User'), Text('Worker')];
  final List<bool> selectedUsers = <bool>[true, false];

  void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  void login(String userId, String password) async {
    if (userId.isEmpty) {
      toast("Username cannot be empty");
    } else if (password.length < 6) {
      toast("Password should consist of atleast 6 characters");
    } else {
      setState(() {
        _isLoading = true;
      });
      // Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   const firstScreen()));
      loginUser(userId, password);
    }
  }

  void loginUser(String userId, String password) async {
    try {
      final uri = Uri.parse(GlobalVar.link + "/user/verify");
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
      };

      Map<String, String> body = {
        "username": userId.trim(),
        "password": password.trim()
      };

      String jsonBody = json.encode(body);
      print(jsonBody);

      Response response = await post(uri, headers: headers, body: jsonBody);

      var data = jsonDecode(response.body.toString());

      if (response != null) {
        setState(() {
          _isLoading = false;
        });
      }
      
      print(data["state"].toString());
      if (response.statusCode == 200 && data["state"] == true) {
        //++

        print(data["users"].toString());
        for (int i = 0; i < data["users"].length; i++) {
          await storage.write(
              key: "Token", value: data["users"][i]["userid"].toString());
          await storage.write(
              key: "userId", value: data["users"][i]["username"].toString());
          GlobalVar.username = data["users"][i]["username"].toString();
          GlobalVar.userid = data["users"][i]["userid"].toString();
        }
        toast("Login Success");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const firstScreen()),
            (Route<dynamic> route) => false);

        userIdController.text = "";
        passwordController.text = "";
      } else {
        toast("Invalid Credentials");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      toast(e.toString());
      devtools.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Stack(
        children: [
          Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                  child: SafeArea(
                child: Container(
                    height: 100.h,
                    color: Color(0xFF022136),
                    child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              color: Colors.white,
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(80),
                                      bottomRight: Radius.circular(80))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 6.h,
                                  ),
                                  CircleAvatar(
                                    backgroundImage:
                                        const AssetImage("assets/home.jpg"),
                                    radius: 12.5.h,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Shelf Ease",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.sp,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 1.75.h,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Text(
                                        "Use your credentials to log in to your account",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12.5.sp,
                                            color: Colors.black54),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: TextField(
                                        controller: userIdController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Username',
                                          labelStyle: const TextStyle(
                                              color: Colors.black),
                                          prefixIcon:
                                              const Icon(Icons.mail_outline),
                                          prefixIconColor: '#C20000'.toColor(),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors.black45),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: '#00004d'.toColor()),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: TextFormField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Password',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          prefixIcon: Icon(Icons.lock),
                                          prefixIconColor: '#C20000'.toColor(),
                                          suffixIcon: IconButton(
                                            icon: Icon(_obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _obscureText = !_obscureText;
                                                },
                                              );
                                            },
                                          ),
                                          alignLabelWithHint: false,
                                          filled: false,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors
                                                    .black45), //<-- SEE HERE
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            //<-- SEE HERE
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: '#00004d'.toColor()),
                                          ),
                                        ),
                                        obscureText: _obscureText,
                                      )),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                          padding:
                                              EdgeInsets.only(right: 9.5.w),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const ResetPassPage()));
                                            },
                                            child: Text(
                                              "Forgot password?",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: '#C20000'.toColor()),
                                            ),
                                          ))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 28.w, right: 28.w),
                              child: InkWell(
                                onTap: () {},
                                child: GestureDetector(
                                    onTap: () {
                                      login(userIdController.text,
                                          passwordController.text);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: '#C20000'.toColor(),
                                      ),
                                      child: Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 2.h,
                                                bottom: 2.h,
                                                left: 3.w,
                                                right: 3.w),
                                            child: Text('Login',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    )),
                              )),
                          SizedBox(
                            height: 26.h,
                          ),
                        ])),
              ))),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    });
  }
}

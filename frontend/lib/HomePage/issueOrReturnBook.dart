import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shelf_ease/HomePage/ImportSuccessScreen/confirmationScreen.dart';
import 'package:shelf_ease/HomePage/searchScreenDetailed.dart';
import 'package:shelf_ease/Utils/HexColorUse.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../../Login/LoginScreenNew.dart';
import '../../global_var.dart';

class issueReturn extends StatefulWidget {
  String s;

  issueReturn(this.s);

  @override
  State<issueReturn> createState() => _issueReturnState();
}

class _issueReturnState extends State<issueReturn> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool vis = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController isbnController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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

  showProgressDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => true,
              child: const SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 1,
                        ),
                      ]),
                    )
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 10, left: 10),
                      child: IconButton(
                        constraints:
                            BoxConstraints(minWidth: 40, minHeight: 40),
                        icon: const CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              scale: 2,
                              'https://www.shareicon.net/download/128x128//2015/09/29/648454_arrows_512x512.png'),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.s == "issue"
                              ? Text("Issue Book!",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600))
                              : Text("Search Issued Books",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              widget.s == "issue"
                                  ? Text("Search by:",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22))
                                  : Text("Penalty : ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Title'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18, top: 2, bottom: 18),
                      child: TextFormField(
                        controller: isbnController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Isbn'),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    widget.s=="issue"?
                    Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w),
                        child: InkWell(
                          onTap: () {},
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => searchScreen(
                                  titleController.text,
                                  "",
                                  isbnController.text,
                                  "",
                                  "","issue","",
                                )));

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
                                          left: 2.8.w,
                                          right: 2.8.w),
                                      child: Text('Search!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold))),
                                ),
                              )),
                        )):
                    Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w),
                        child: InkWell(
                          onTap: () {},
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => searchScreen(
                                          titleController.text,
                                          "",
                                          isbnController.text,
                                          "",
                                          "","return","",
                                        )));

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
                                          left: 2.8.w,
                                          right: 2.8.w),
                                      child: Text('Search!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.bold))),
                                ),
                              )),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

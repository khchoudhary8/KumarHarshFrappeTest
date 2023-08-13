import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../../Login/LoginScreenNew.dart';
import '../../global_var.dart';
import '../searchScreenDetailed.dart';
import 'ProfilePageUser.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  TextEditingController titleController = TextEditingController();

  bool vis = false;
  TextEditingController searchController = TextEditingController();
  int got = 0;

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

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: const Color(0xFF022136),
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
                            BoxConstraints(minWidth: 55, minHeight: 55),
                        icon: const CircleAvatar(
                          radius: 200,
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(
                              scale: 2,
                              "https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_man_officer-512.png"),
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePageUser()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("You Have",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Text("100",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 30)),
                              SizedBox(
                                width: 1.h,
                              ),
                              Text("Books In Stock",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: TextField(
                        controller: titleController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Search title",
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          alignLabelWithHint: false,
                          filled: false,
                          focusColor: Colors.white,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.deepOrangeAccent,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => searchScreen(
                                        titleController.text, "", "", "", "","","")));
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 34.0, right: 34),
                      child: Row(
                        children: [
                          Text("Today",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          Spacer(),
                          Text("Space",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15)),
                          Spacer(),
                          Text("Politics",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15)),
                          Spacer(),
                          Text("Motivation",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15)),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      height: 100.h,
                      child: Card(
                        color: Colors.grey.shade100,
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 2.h),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 1.5.h,
                                              bottom: 1.5.h,
                                              left: 5.w,
                                              right: 5.w),
                                          child: Text('Trending',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 9.sp,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                  SizedBox(width: 2.h),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 1.5.h,
                                              bottom: 1.5.h,
                                              left: 5.w,
                                              right: 5.w),
                                          child: Text('Popular',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 9.sp,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 270,
                                      width: 40.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.asset(
                                          'assets/sample1.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 270,
                                      width: 40.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.asset(
                                          'assets/sample2.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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

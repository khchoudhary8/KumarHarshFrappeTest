import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../../Login/LoginScreenNew.dart';
import '../../global_var.dart';


class ProfilePageUser extends StatefulWidget {
  @override
  State<ProfilePageUser> createState() => _ProfilePageUserState();
}

class _ProfilePageUserState extends State<ProfilePageUser> {
  FlutterSecureStorage storage = const FlutterSecureStorage();


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


  showDialogFunction() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('Material Alert Dialog'),
            content: const Text("Are you sure you want to Logout?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    await storage.deleteAll();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreenNew()),
                        (Route<dynamic> route) => true);
                  },
                  child: const Text('Yes')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //close Dialog
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Your Profile",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF022136),
          iconTheme: const IconThemeData(color: Colors.white, size: 22.0),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                child: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                onTap: () async {
                  showDialogFunction();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: const Color(0xFF022136),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: const Color(0xff081108),
                            width: 2,
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white24,
                              blurRadius: 20,
                              offset: Offset(5, 5),
                            ),
                          ]),
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_man_officer-512.png"),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Admin",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    SizedBox(
                      height: 100.h,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50, bottom: 10),
                          child: Column(
                            children: [

                              Container(
                                padding:
                                    const EdgeInsets.only(top:20,left: 10, bottom: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Your" + " Information:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 2.h),
                                  Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(28))),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      leading: const Icon(Icons.email),
                                      title: const Text("Email"),
                                      subtitle: Text("1234admin@gmail.com"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(28))),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      leading: const Icon(Icons.phone),
                                      title: const Text("Phone"),
                                      subtitle: Text("1123456789"),
                                      // onTap: ,
                                      // trailing: InkWell(child: Icon(Icons.edit, color: Colors.blueGrey,)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
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

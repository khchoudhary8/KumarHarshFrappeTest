
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shelf_ease/HomePage/RoutesUser/AllUsers.dart';
import 'package:shelf_ease/HomePage/NavPages/searchPage.dart';
import 'package:shelf_ease/HomePage/RoutesUser/addBooks.dart';
import 'package:shelf_ease/HomePage/RoutesUser/addmembers.dart';
import 'package:shelf_ease/HomePage/issueOrReturnBook.dart';

import 'package:sizer/sizer.dart';


import '../../Utils/dialogbox.dart';
import '../ReportScreen/reportScreen.dart';
import 'ProfilePageUser.dart';


class homeUser extends StatefulWidget {
  @override
  _homeUserState createState() => _homeUserState();
}


class _homeUserState extends State<homeUser> {

  FlutterSecureStorage storage = const FlutterSecureStorage();
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
        backgroundColor: Colors.grey.shade100,

        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 7.h,
            ),

            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoxDeck(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  color:Colors.orange.shade100
                ,
                  text: const Text(
                    "Import Books",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  link: 'assets/import.png',
                  screen: searchPage("import"),
                ),

                BoxDeck(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  color: Colors.blue.shade100,
                  text: const Text(
                    "Add Books",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  link: 'assets/add.png',
                  screen: AddBooks(),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoxDeck(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  color: Color.fromARGB(255, 208, 234, 182),
                  text: const Text(
                    "Issue Books",
                    style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  link: 'assets/2.png',
                  screen: issueReturn("issue"),
                ),

                BoxDeck(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  color: Colors.indigo.shade100,
                  text: const Text(
                    "Return / Members",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  link: 'assets/sos.png',
                  screen: AllUsers(),
                ),

              ],
            ),

            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoxDeck(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  color: Colors.blueGrey.shade100,
                  text: const Text(
                    "All Penalty",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  link: 'assets/penalty.png',
                  screen: issueReturn("return"),
                ),
                BoxDeck(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  color: Colors.yellow.shade200,
                  text: const Text(
                    "Monthly Report",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  link: 'assets/report.png', screen: reportScreen(),
                  // routeName: sos.routeName,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BoxDeck(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  color: Colors.blue.shade100,
                  text: const Text(
                    "Add Members",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  link: 'assets/add-friend.png',
                  screen: addMembers(),
                ),

              ],
            ),
            const SizedBox(
              height:140,
            ),
          ]),
        ),
      );
    });
  }
}

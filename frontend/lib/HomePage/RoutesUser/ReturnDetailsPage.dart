import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../../Models/UserModel.dart';
import '../../Models/bookModel.dart';
import '../../global_var.dart';


class returnDetails extends StatefulWidget {

  BookModel bookModel;
  UserModel userModel;


  returnDetails(this.bookModel, this.userModel);

  @override
  State<returnDetails> createState() => _returnDetailsState();
}

class _returnDetailsState extends State<returnDetails> {
  @override



  @override
  void initState() {
    super.initState();
    //getData(true);
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

  // Future<String> getUserData(String userId) async {
  //   showProgressDialog(context);
  //
  //   try {
  //     final uri = Uri.parse(GlobalVar.link + "/worker/userDetails/" + userId);
  //     final headers = {"auth-token": GlobalVar.auth_token};
  //     Map<String, dynamic> body = {"userId": userId};
  //
  //     String jsonBody = json.encode(body);
  //     Response response = await get(uri, headers: headers);
  //     var data = jsonDecode(response.body.toString());
  //     var data1 = data["message"];
  //     print(response.body.toString());
  //     if (response.statusCode == 200) {
  //       Navigator.of(context, rootNavigator: true).pop();
  //
  //       return data1[0]["phone"].toString();
  //
  //       // for (int i = 0; i < data1.length; i++) {
  //
  //       // entries.add(UserModel(
  //       //   data1[i]["userId"].toString(),
  //       //   data1[i]["email"].toString(),
  //       //   data1[i]["name"].toString(),
  //       //   data1[i]["designation"].toString(),
  //       //   data1[i]["unit"].toString(),
  //       //   data1[i]["quarterType"].toString(),
  //       //   data1[i]["quarterNumber"].toString(),
  //       //   data1[i]["phone"].toString(),
  //       //   "1",
  //       //   "",
  //       //   "user" ,true,
  //       // ));
  //       // }
  //     } else {
  //       Navigator.of(context, rootNavigator: true).pop();
  //
  //       toast("Server Error");
  //     }
  //   } catch (e) {
  //     Navigator.of(context, rootNavigator: true).pop();
  //     print(e);
  //   }
  //   return "";
  // }

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

  // getFormattedDateFromFormattedString(
  //     {required value,
  //       required String currentFormat,
  //       required String desiredFormat,
  //       isUtc = true}) {
  //   DateTime? dateTime = DateTime.now();
  //   String formattedDate = "";
  //   if (value != null || value.isNotEmpty) {
  //     try {
  //       dateTime = DateFormat(currentFormat).parse(value, isUtc).toLocal();
  //       formattedDate = DateFormat(desiredFormat).format(dateTime);
  //     } catch (e) {
  //       print("$e");
  //     }
  //   }
  //   return formattedDate;
  // }

  showDialogFunction(
      BuildContext context, String content, int index, int work) {
    var contextt = context;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('Material Alert Dialog'),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () {


                  },
                  child: Text('Yes')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //close Dialog
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }





  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        // bottomNavigationB
        //ar: const NavBar(),
        //backgroundColor: Colors.grey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10,
                ),
                child: Text(
                  "Ticket No. #",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
            elevation: 1,
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.black, size: 22.0),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (item) => {},
                itemBuilder: (BuildContext context) {
                  return {
                    "Mark Resolved",
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            //await getData(false);
          },
          color: Colors.indigo[900],
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                //print(widget.status),

                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}

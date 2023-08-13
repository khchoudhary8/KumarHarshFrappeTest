import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shelf_ease/HomePage/MembersForIssuing.dart';
import 'package:shelf_ease/Utils/HexColorUse.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../global_var.dart';

class BookDetailScreen extends StatefulWidget {
  final String numpages;
  final String authors;
  final String averageRating;
  final String bookID;
  final String isbn;
  final String isbn13;
  final String languageCode;
  final String publicationDate;
  final String publisher;
  final String ratingsCount;
  final String textReviewsCount;
  final String title;
  final String isAvailable;
  final String issuedate;
  final String userID;

  BookDetailScreen(
      this.numpages,
      this.authors,
      this.averageRating,
      this.bookID,
      this.isbn,
      this.isbn13,
      this.languageCode,
      this.publicationDate,
      this.publisher,
      this.ratingsCount,
      this.textReviewsCount,
      this.title,
      this.isAvailable,
      this.issuedate,
      this.userID);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  int penalty = 0;

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
    String sdatetime = widget.issuedate.toString();
    DateTime sdate = DateTime.parse(sdatetime);
    int stimestamp = sdate.millisecondsSinceEpoch;

    int millis = DateTime.now().millisecondsSinceEpoch;
    int diff = millis - stimestamp;
    print(diff.toString());
    double i = diff / 86400000;
    int d = i.toInt();
    d = d * 10;
    setState(() {
      penalty = d;
    });

    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 30,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white,
          title: Text(
            "Details",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage('assets/mockup1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          width: 1.5.w,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            widget.averageRating,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(width: 0.1.w),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            "(" + "${widget.textReviewsCount}" + " reviews )",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            "" + "${widget.numpages}" + " pages ",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    // Add more information fields here...

                    SizedBox(height: 16),
                    widget.isAvailable == "true"
                        ? Container(
                            height: 45,
                            width: 140,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: 'C20000'.toColor(), // Background color
                              ),
                              onPressed: () {
                                checkAvailabiltyBeforeIssue(widget.bookID);
                              },
                              child: Text(
                                'Issue Book',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          )
                        : Container(
                            height: 45,
                            width: 140,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent, // Background color
                              ),
                              onPressed: () {
                                showDialogFunction(
                                    context, widget.userID, penalty.toString());
                              },
                              child: Text(
                                'Return Book',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                    widget.isAvailable == "false"
                        ? Column(
                            children: [
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Text(
                                  "Issue date: " +
                                      "${widget.issuedate.substring(0, 10)}" +
                                      " ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),

                    SizedBox(height: 26),
                    Text(
                      "Other Details:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 1),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "- BOOKID: " + "${widget.bookID}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          Text(
                            "- ISBN: " + "${widget.isbn}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          Text(
                            "- AUTHORS: " + "${widget.authors}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          Text(
                            "- PUBLISHER: " + "${widget.publisher}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          Text(
                            "- DATE: " +
                                "${widget.publicationDate.substring(0, 16)}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  showProgressDialog(BuildContext context, int i) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        SizedBox(
                          height: 1,
                        ),
                        i == 1
                            ? Text("Checking Availability")
                            : SizedBox(
                                height: 1,
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 1,
                        ),
                      ]),
                    )
                  ]));
        });
  }

  showDialogFunction(BuildContext context, String userid, String penalty) {
    var contextt = context;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('Material Alert Dialog'),
            content: Text("User's Dues: Rs." + '${penalty}'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    returnAbook(contextt, userid, widget.bookID, 1);
                  },
                  child: Text('Return')),

              TextButton(
                onPressed: () {
                  Navigator.pop(context); //close Dialog
                },
                child: Text('Back'),
              ),
            ],
          );
        });
  }

  void checkAvailabiltyBeforeIssue(String bookID) async {
    try {
      showProgressDialog(context, 1);
      final uri = Uri.parse(GlobalVar.link + "/isbookavailable");
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
      };

      Map<String, String> body = {};
      if (bookID.isNotEmpty) {
        body["book_id"] = bookID;
      }

      // body["count"] = "30";

      String jsonBody = json.encode(body);
      print(jsonBody);
      Response response = await post(uri, headers: headers, body: jsonBody);

      var data = jsonDecode(response.body.toString());
      print(data);
      if (response.statusCode == 200) {
        if (data["available"].toString() == "true") {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => membersForIssuing(bookID)));
        } else {
          Navigator.of(context).pop();
          toast("Book not available");
        }
      } else {
        Navigator.of(context).pop();
        toast("Server Response Error");
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  Future<void> returnAbook(BuildContext contextt, String userid, String bookID,
      int paymentfull) async {
    try {
      showProgressDialog(context, 0);
      final uri = Uri.parse("${GlobalVar.link}/returnbook");
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
      };

      Map<String, String> body = {};
      body["book_id"] = bookID;
      body["member_id"] = widget.userID;
      body["amt_returned"] = paymentfull.toString();

      String jsonBody = json.encode(body);
      print(jsonBody);
      Response response = await post(uri, headers: headers, body: jsonBody);

      var data = jsonDecode(response.body.toString());
      print(data);
      toast(data["message"].toString());
      if (response.statusCode == 200) {

          Navigator.of(context).pop();
          Navigator.of(context)..pop()..pop();

        }  else {
        Navigator.of(context).pop();
        Navigator.of(context)..pop()..pop();

        toast("Server Response Error");
      }
    } catch (e) {
      toast(e.toString());
    }
  }
}

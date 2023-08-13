import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shelf_ease/HomePage/bookDetailPage.dart';
import 'package:http/http.dart';

import '../Models/bookModel.dart';
import '../global_var.dart';

class itemRowView extends StatefulWidget {
  BookModel model;
  String userID;
  int index;
  int showpenalty;

  itemRowView(this.model, this.userID, this.index, this.showpenalty);

  @override
  State<itemRowView> createState() => _itemRowViewState();
}

class _itemRowViewState extends State<itemRowView> {
  final List<MaterialAccentColor> colors = <MaterialAccentColor>[
    Colors.greenAccent,
    Colors.redAccent,
  ];

  List imgList = [
    Image.asset(
      'assets/mockup1.jpg',
      fit: BoxFit.fill,
    ),
    Image.asset('assets/mockup3.jpg', fit: BoxFit.fill),
    Image.asset('assets/mockup2.jpg', fit: BoxFit.fill),
  ];

  @override
  Widget build(BuildContext context) {
    int millis = DateTime.now().millisecondsSinceEpoch;
    int dbmillis = int.parse(widget.model.issueDate.trim());
    int diff = millis - dbmillis;
    // print(widget.model.issueDate.toString().trim());
    double i = diff / 86400000;
    int d = i.toInt();
    d = d * 10;

    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, bottom: 10, top: 10),
      child: GestureDetector(
        onTap: () {
          print(widget.showpenalty.toString());
          if (widget.showpenalty != 2) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BookDetailScreen(
                    widget.model.numpages.toString(),
                    widget.model.authors.toString(),
                    widget.model.average_rating.toString(),
                    widget.model.bookID.toString(),
                    widget.model.isbn.toString(),
                    widget.model.isbn13.toString(),
                    widget.model.language_code.toString(),
                    widget.model.publication_date.toString(),
                    widget.model.publisher.toString(),
                    widget.model.ratings_count.toString(),
                    widget.model.text_reviews_count.toString(),
                    widget.model.title.toString(),
                    widget.model.isAvailable.toString(),
                    DateTime.fromMillisecondsSinceEpoch(dbmillis).toString(),
                    widget.userID)));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 7),
                GestureDetector(
                  child: Row(
                    children: [
                      widget.model.isAvailable == "true"
                          ? CircleAvatar(backgroundColor: colors[0], radius: 6)
                          : CircleAvatar(backgroundColor: colors[1], radius: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          width: 170,
                          child: Text(
                            widget.model.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          widget.model.average_rating,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 7,
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.published_with_changes_sharp,
                                color: Colors.teal,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: SizedBox(
                                  width: 170,
                                  child: Text(
                                    widget.model.publisher,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.cyan,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: SizedBox(
                                  width: 170,
                                  child: Text(
                                    widget.model.authors,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.orange,
                                size: 20,
                              ),
                              Container(
                                width: 140,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    widget.model.publication_date.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Icon(
                                Icons.language,
                                color: Colors.teal,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  widget.model.language_code.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 7),
                          widget.showpenalty == 1 || widget.showpenalty == 2
                              ? Row(
                                  children: [
                                    const Icon(
                                      Icons.data_exploration_outlined,
                                      color: Colors.teal,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        DateTime.fromMillisecondsSinceEpoch(
                                                dbmillis)
                                            .toString()
                                            .substring(0, 10)
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox(height: 7),
                          widget.showpenalty == 1 || widget.showpenalty == 2
                              ? Column(
                                  children: [
                                    SizedBox(height: 7),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.attach_money_outlined,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "${d}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.red),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.blue, // Button color
                                      child: InkWell(
                                        splashColor: Colors.red, // Splash color
                                        onTap: () {
                                          deletebook();
                                        },
                                        child: SizedBox(
                                            width: 36,
                                            height: 36,
                                            child: Icon(
                                                Icons.delete_forever_outlined)),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Image border
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(58), // Image radius
                          child: imgList[widget.index % imgList.length],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 1.0),
              ],
            ),
          ),
        ),
      ),
    );
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

  Future<void> deletebook() async {
    if (widget.model.isAvailable == "true") {
      try {
        showProgressDialog(context);
        final uri = Uri.parse(GlobalVar.link + "/bookdelete");
        final headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        };

        Map<String, String> body = {"book_id": widget.model.bookID.toString()};

        String jsonBody = json.encode(body);
        print(jsonBody);
        Response response = await post(uri, headers: headers, body: jsonBody);

        var data = jsonDecode(response.body.toString());

        if (response.statusCode == 200) {
          Navigator.of(context).pop();
          Navigator.of(context)..pop();

          toast(data["message"]);
        } else {
          Navigator.of(context).pop();
          Navigator.of(context)..pop();

          toast("Server Response Error");
        }
      } catch (e) {
        Navigator.of(context).pop();
        Navigator.of(context)..pop();
        toast(e.toString());
      }
    } else
      toast("Book already issued");
  }
}

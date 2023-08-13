import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../Models/bookModel.dart';
import '../RowViews/searchedProduct.dart';
import '../global_var.dart';

class searchScreen extends StatefulWidget {
  static const String routeName = "/searchScreen";
  String title;
  String author;
  String isbn;
  String publisher;
  String pagescount;
  String issueorreturn;
  String userID;

  searchScreen(this.title, this.author, this.isbn, this.publisher,
      this.pagescount, this.issueorreturn, this.userID);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  TextEditingController searchController = TextEditingController();
  List<BookModel> booklist = [];
  bool fetchingData = true;
  int count=0;
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
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  Future<List<BookModel>> searchProduct(String title, String author,
      String isbn, String publisher, String pagescount) async {
    List<BookModel> itemList = [];

    try {
      final uri = Uri.parse(GlobalVar.link + "/search/data");
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
      };

      Map<String, String> body = {};
      if (widget.title.isNotEmpty) {
        body["title"] = widget.title;
      }
      if (widget.author.isNotEmpty) {
        body["author"] = widget.author;
      }
      if (widget.isbn.isNotEmpty) {
        body["isbn"] = widget.isbn;
      }
      if (widget.publisher.isNotEmpty) {
        body["publisher"] = widget.publisher;
      }
      if (widget.pagescount.isNotEmpty) {
        body["pages"] = widget.pagescount;
      }

      // body["count"] = "30";

      String jsonBody = json.encode(body);
      print(jsonBody);
      Response response = await post(uri, headers: headers, body: jsonBody);

      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {

        for (int i = 0; i < data["data"].length; i++) {
          if (widget.issueorreturn == "issue") {
            if (data["data"][i]["isAvailable"].toString() == "true") {
              itemList.add(BookModel(
                  data["data"][i]["  num_pages"].toString(),
                  data["data"][i]["authors"].toString(),
                  data["data"][i]["average_rating"].toString(),
                  data["data"][i]["bookID"].toString(),
                  data["data"][i]["isbn"].toString(),
                  data["data"][i]["isbn13"].toString(),
                  data["data"][i]["language_code"].toString(),
                  data["data"][i]["publication_date"],

                  data["data"][i]["publisher"].toString(),
                  data["data"][i]["ratings_count"].toString(),
                  data["data"][i]["text_reviews_count"].toString(),
                  data["data"][i]["title"].toString(),
                  data["data"][i]["isAvailable"].toString(),
                  data["data"][i]["issuedate"].toString()+"000"));

            }
          } else if (widget.issueorreturn == "return") {
            if (
            data["data"][i]["isAvailable"].toString() == "false") {
              itemList.add(BookModel(
                  data["data"][i]["  num_pages"].toString(),
                  data["data"][i]["authors"].toString(),
                  data["data"][i]["average_rating"].toString(),
                  data["data"][i]["bookID"].toString(),
                  data["data"][i]["isbn"].toString(),
                  data["data"][i]["isbn13"].toString(),
                  data["data"][i]["language_code"].toString(),
                  data["data"][i]["publication_date"],

                  data["data"][i]["publisher"].toString(),
                  data["data"][i]["ratings_count"].toString(),
                  data["data"][i]["text_reviews_count"].toString(),
                  data["data"][i]["title"].toString(),
                  data["data"][i]["isAvailable"].toString(),
                  data["data"][i]["issuedate"].toString()+"000"));

            }
          }else {
            print(widget.issueorreturn.toString());
            print(data["data"][0]["isAvailable"].toString());
            itemList.add(BookModel(
                data["data"][i]["  num_pages"].toString(),
                data["data"][i]["authors"].toString(),
                data["data"][i]["average_rating"].toString(),
                data["data"][i]["bookID"].toString(),
                data["data"][i]["isbn"].toString(),
                data["data"][i]["isbn13"].toString(),
                data["data"][i]["language_code"].toString(),
                data["data"][i]["publication_date"],

                data["data"][i]["publisher"].toString(),
                data["data"][i]["ratings_count"].toString(),
                data["data"][i]["text_reviews_count"].toString(),
                data["data"][i]["title"].toString(),
                data["data"][i]["isAvailable"].toString(),
            data["data"][i]["issuedate"].toString()+"000"));

          }
        }
      } else
        toast("Server Response Error");
    } catch (e) {
      toast(e.toString());
    }
    setState(() {
      count = itemList.length;

    });
    return itemList;
  }

  void getSearchedProduct() async {
    booklist = await searchProduct(widget.title, widget.author, widget.isbn,
        widget.publisher, widget.pagescount);
    setState(() {
      fetchingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Results - "+"${count}",
            style: TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.w600),
          ),
          leading: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              icon: const Icon(
                Icons.sort_outlined,
                color: Colors.black,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    booklist!.sort((b, a) {
                      return a.numpages.compareTo(b.numpages);
                    });
                    setState(() {});
                  },
                  child: Container(
                    child: const Text(
                      'Sort by Pages',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    booklist!.sort(
                        (a, b) => b.average_rating.compareTo(a.average_rating));
                    setState(() {});
                  },
                  child: Container(
                    child: const Text(
                      'Sort by Rating',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: fetchingData
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: booklist!.length,
                    itemBuilder: (context, index) {
                      int t;
                      widget.issueorreturn=="return"?
                          t=2:t=0;
                      return itemRowView(booklist[index],widget.userID, index,t);
                    },
                  ),
                )
              ],
            ),
    );
  }
}

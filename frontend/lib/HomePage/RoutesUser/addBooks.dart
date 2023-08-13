import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shelf_ease/Utils/HexColorUse.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../../Login/LoginScreenNew.dart';
import '../../global_var.dart';
import '../NavPages/ProfilePageUser.dart';
import '../searchScreenDetailed.dart';


class AddBooks extends StatefulWidget {
  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool vis= false;
  TextEditingController numpagess = TextEditingController();
  TextEditingController authors = TextEditingController();
  TextEditingController average_ratings = TextEditingController();
  TextEditingController book_id = TextEditingController();
  TextEditingController isbn = TextEditingController();
  TextEditingController isbn13 = TextEditingController();
  TextEditingController language_code = TextEditingController();
  TextEditingController publication_date = TextEditingController();
  TextEditingController publisher = TextEditingController();
  TextEditingController ratings_count = TextEditingController();
  TextEditingController text_reviews_count = TextEditingController();
  TextEditingController title = TextEditingController();

  int got=0;

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

  Future<void> addBooktoDB(String title, String authors, String isbn, String isbn13, String publisher,
      String numpages, String averagerating, String bookid, String langcode,
      String publicationfate, String ratingcount, String textreviewcount) async {

    if(title.isNotEmpty && authors.isNotEmpty && isbn.isNotEmpty && isbn13.isNotEmpty && publisher.isNotEmpty
    && numpages.isNotEmpty && averagerating.isNotEmpty && bookid.isNotEmpty && langcode.isNotEmpty && publicationfate.isNotEmpty
    && ratingcount.isNotEmpty && textreviewcount.isNotEmpty) {
      showProgressDialog(context);
      try {
        final uri = Uri.parse(GlobalVar.link + "/addbook");
        final headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        };

        Map<String, String> body = { "num_pages": numpages, "authors": authors, "average_rating": averagerating,
          "book_id": bookid, "isbn": isbn,"isbn13":isbn13,"language_code":langcode,"publication_date":publicationfate
        , "publisher": publisher,"ratings_count":ratingcount,"text_reviews_count":textreviewcount,"title":title };

        String jsonBody = json.encode(body);
        print(jsonBody);
        Response response = await post(uri, headers: headers, body: jsonBody);

        var data = jsonDecode(response.body.toString());

        if (response.statusCode == 200) {

          toast(data["message"].toString());

        } else
          toast("Server Response Error");
      } catch (e) {
        toast(e.toString());
      }
      Navigator.of(context).pop();
    }
    else {
      toast("Please fill all the boxes");
    }


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
                      padding: const EdgeInsets.only(top: 12.0, bottom: 10, left: 10),
                      child: IconButton(
                        constraints: BoxConstraints(minWidth: 40, minHeight:40),
                        icon: const CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              scale: 2,
                              'https://www.shareicon.net/download/128x128//2015/09/29/648454_arrows_512x512.png'),
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>  ProfilePageUser()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Hello!",style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 30, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Text("Add Books Here:",style: TextStyle(color: Colors.black,fontSize: 22)),

                            ],
                          ),],
                      ),
                    ),



                    SizedBox(
                      height: 6.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(18.0),
                      child:     TextFormField(
                        controller: title,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Title'),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: authors,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Author'),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: isbn,
                        keyboardType: TextInputType. number,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Isbn'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: isbn13,
                        keyboardType: TextInputType. number,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Isbn13'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: publisher,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Publisher'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: numpagess,
                        keyboardType: TextInputType. number,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'num pages'),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: average_ratings,
                        keyboardType: TextInputType. number,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Average ratings'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: book_id,
                        keyboardType: TextInputType. number,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'BookID'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: language_code,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Language'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: publication_date,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Publication date'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: ratings_count,
                        keyboardType: TextInputType. number,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Rating count'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right:18, top:2, bottom: 18),
                      child:     TextFormField(
                        controller: text_reviews_count,
                        keyboardType: TextInputType. number,
                        decoration:  InputDecoration(
                            prefixIcon: Icon(
                              Icons.book_outlined,
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius: BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            hintStyle: TextStyle(fontSize:15,color: Colors.black54,fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Text review count'),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w,bottom: 5.h),
                        child: InkWell(
                          onTap: () {},
                          child: GestureDetector(
                              onTap: () {
                                addBooktoDB(title.text.toString(), authors.text.toString(),isbn.text.toString(), isbn13.text.toString(),
                                publisher.text.toString(),numpagess.text.toString(),average_ratings.text.toString(),book_id.text.toString(),language_code.text.toString(),
                                publication_date.text.toString(),ratings_count.text.toString(),text_reviews_count.text.toString());
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
                                      child: Text('Add',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                              fontWeight:
                                              FontWeight.bold))),
                                ),
                              )),
                        )),
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

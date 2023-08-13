import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shelf_ease/HomePage/NavPages/ProfilePageUser.dart';
import 'package:shelf_ease/HomePage/memberBooksDetail.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../global_var.dart';
import '../../../../main.dart';
import '../../../../models/UserModel.dart';

class AllUsers extends StatefulWidget {
  static const String routeName = '/AllUsers';

  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  final List<UserModel> entries = [];
  Future<List<UserModel>>? _future;
  int totaldues=0;

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
    _future = getUserData();
  }

  @override
  Future<List<UserModel>> getUserData() async {
    setState(() {
      entries.clear();
    });
    try {
      final uri = Uri.parse(GlobalVar.link + "/members/all");
      final headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
      };

      Response response = await post(uri, headers: headers);
      var data = jsonDecode(response.body.toString());

      print(data["data"].toString());

      if (response.statusCode == 200) {
        var data1 = data["data"];
        for (int i = 0; i < data1.length; i++) {
          entries.add(UserModel(
              data1[i]["id"].toString(),
              data1[i]["name"].toString(),
              data1[i]["email"].toString(),
              data1[i]["phone"].toString(),
              "Active",
              List<int>.from(data1[i]["books_id"]),
              data1[i]["due_amt"].toString()
          ));
          setState(() {
            totaldues= totaldues + int.parse(data1[i]["due_amt"].toString());

          });
        }
      } else {
        toast("Server Error");
      }
    } catch (e) {
      print(e);
    }
    return entries;
  }

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          // bottomNavigationBar: const NavBar(),
          //backgroundColor: Colors.grey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10,
                    ),
                    child: Text(
                      "All Members",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    
                  ),
                  Spacer(),
                  Text("Total: Rs."+"${totaldues}", style: TextStyle(color: Colors.red, fontSize: 17),)
                ],
              ),
              elevation: 1,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black, size: 22.0),
              actions: const <Widget>[],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 8, right: 10, left: 10),
            child: RefreshIndicator(
                onRefresh: () async {
                  _future = getUserData();
                },
                color: Colors.indigo[900],
                child: FutureBuilder(
                    future: _future, // function where you call your api
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserModel>> snapshot) {
                      // AsyncSnapshot<Your object type>
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: Text('No data or Sever response error'));
                        }
                        if (entries.isEmpty || entries == null)
                          return Center(child: Text("No such data!"));
                        return ListView.builder(
                          itemCount: entries.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 12.0, bottom: 12, right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                 dothis(index);
                                 },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[200],
                                  ),
                                  //color: Colors.grey[100],
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height: 0.5.h),
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://www.shareicon.net/download/128x128//2016/08/18/810199_user_512x512.png",
                                                  scale: 2),
                                              backgroundColor: Colors.blueGrey,
                                              radius: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: SizedBox(
                                                width: 40.w,
                                                child: Text(
                                                  '${entries[index].name}',
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: SizedBox(
                                                width: 50,
                                                child: Text(
                                                  'Books : ${entries[index].bookList.length}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.5.h),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5.0),
                                                child: Text(
                                                  '${entries[index].mem_status}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: CupertinoColors
                                                          .systemGreen),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: InkWell(
                                            onTap: () async => {
                                              if (await launchUrl(Uri.parse(
                                                  'tel:' +
                                                      entries[index].phone)))
                                                {
                                                  //dialer opened
                                                }
                                              else
                                                {
                                                  //dailer is not opened
                                                }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    '${entries[index].phone}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 0.5.h),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.store_outlined,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5.0),
                                                child: Text(
                                                  '${entries[index].email} ',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding:
                                                EdgeInsets.only(left: 5.0),
                                                child: Text(
                                                  'Due: Rs.'+'${entries[index].dues}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 1.5.h),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: ClipOval(
                                            child: Material(
                                              color: Colors.blue, // Button color
                                              child: InkWell(
                                                splashColor: Colors.red, // Splash color
                                                onTap: () {
                                                  deleteuser(index);
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
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    })),
          ));
    });
  }

  void dothis(int index) {
    if (entries[index].bookList.length > 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              memberBooksDetailScreen(
                  entries[index].bookList, entries[index].id)));
    }
    else{
      toast("No books currently issued to this member");
    }
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

  Future<void> deleteuser(int index) async {
    if (entries[index].bookList.length == 0 ) {
      try {
        showProgressDialog(context);
        final uri = Uri.parse(GlobalVar.link + "/memberdelete");
        final headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        };

        Map<String, String> body = {"member_id": entries[index].id.toString()};

        String jsonBody = json.encode(body);
        print(jsonBody);
        Response response = await post(uri, headers: headers, body: jsonBody);

        var data = jsonDecode(response.body.toString());
        toast(data["message"]);
        if (response.statusCode == 200) {
          Navigator.of(context).pop();
          Navigator.of(context)..pop();

         
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
      toast("Books are issued");
  }
}

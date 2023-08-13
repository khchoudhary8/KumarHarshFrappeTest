import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sizer/sizer.dart';

class reportScreen extends StatefulWidget {
  const reportScreen({super.key});

  @override
  _reportScreenClassState createState() => _reportScreenClassState();
}

class _reportScreenClassState extends State<reportScreen> {
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
  void dispose() {
    super.dispose();
  }
  Map<String, double> dataMap = {
    "Total Revenue": 4400,
    "Membership": 3900,
    "Dues": 4000,

  };


  final colorList = <Color>[
    Colors.greenAccent,
    Colors.redAccent,
    Colors.blueAccent
  ];
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(

              onTap: (){ Navigator.of(context).pop();},
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/shelfease.png'),
                            radius: 40,
                          ),
                          Spacer(),
                          Text(
                            "Report - (August 2023)",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.deepOrange),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 20),
                      child: Text(
                        "Brief :",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Table(
                        border: TableBorder.all(
                            color: Colors.black87,
                            style: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('Total Books in Stock',
                                    style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('16', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [Text('Total Members')]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('4', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [Text('Books issued')]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('12', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [Text('Books returned')]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('4', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 20),
                      child: Text(
                        "Costs :",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Table(
                        border: TableBorder.all(
                            color: Colors.black87,
                            style: BorderStyle.solid,
                            width: 1),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('Memebership Collected',
                                    style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('Rs. 3900', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [Text('Total Overdue')]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('Rs.4000', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [Text('Members with dues')]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('8', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [Text('Total Revenue')]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(children: [
                                Text('Rs.4400', style: TextStyle(fontSize: 14.0))
                              ]),
                            ),
                          ]),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 32,
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,

                          legendTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: true,
                          showChartValues: true,
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: false,
                          decimalPlaces: 1,
                        ),
                        // gradientList: ---To add gradient colors---
                        // emptyColorGradient: ---Empty Color gradient---
                      ),
                    )
                  ]),
            ),
          ));
    });
  }
}

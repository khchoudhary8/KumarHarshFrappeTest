import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../../global_var.dart';
import 'HomeUser.dart';
import 'ProfilePageUser.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'dashboardPage.dart';
import 'searchPage.dart';

class firstScreen extends StatefulWidget {
  static const String routeName = '/firstScreen';

  const firstScreen({super.key});

  @override
  _FirstScreenClassState createState() => _FirstScreenClassState();
}

class _FirstScreenClassState extends State<firstScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  double bottomBarWidth = 45;
  final _controller = NotchBottomBarController(index: 0);
  final _pageController = PageController(initialPage: 0);

  double borderWidth = 5;

  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      // toast(currentIndex.toString());
    });
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

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    DashboardPage(),
    homeUser(),
    searchPage(""),
    ProfilePageUser()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.blueGrey,
              removeMargins: false,
              bottomBarWidth: 400,
              durationInMilliSeconds: 300,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.black54,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.local_library,
                    color: Colors.black54,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.add_box,
                    color: Colors.black54,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.black54,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}

//
// import 'package:flutter/material.dart';
//
// import 'package:badges/badges.dart' as badges;
//
// import '../global_var.dart';
//
// class NavBar extends StatefulWidget {
//   const NavBar({super.key});
//
//   @override
//   State<NavBar> createState() => _NavBarState();
// }
//
// class _NavBarState extends State<NavBar> {
//   int _page = 0;
//   double bottomBarWidth = 45;
//   double borderWidth = 5;
//
//   List<Widget> pages = [
//     const firstScreen(),
//     const ComplaintRegistrationPage(),
//     const StatusPageUpdated(),
//   ];
//   void updatePage(int page) {
//     setState(() {
//       _page = page;
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => pages[_page]));
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         currentIndex: _page,
//         selectedItemColor: GlobalVar.selectedNavBarColor,
//         unselectedItemColor: GlobalVar.unselectedNavBarColor,
//         backgroundColor: GlobalVar.backgroundColor,
//         onTap: updatePage,
//         iconSize: 30,
//         items: [
//           BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                     border: Border(
//                         top: BorderSide(
//                             color: _page == 0
//                                 ? GlobalVar.selectedNavBarColor
//                                 : GlobalVar.backgroundColor,
//                             width: borderWidth))),
//                 child: const Icon(Icons.home_outlined),
//               ),
//               label: ''),
//           BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                     border: Border(
//                         top: BorderSide(
//                             color: _page == 1
//                                 ? GlobalVar.selectedNavBarColor
//                                 : GlobalVar.backgroundColor,
//                             width: borderWidth))),
//                 child: const Icon(Icons.app_registration_outlined),
//               ),
//               label: ''),
//           BottomNavigationBarItem(
//               icon: Container(
//                 width: bottomBarWidth,
//                 decoration: BoxDecoration(
//                     border: Border(
//                         top: BorderSide(
//                             color: _page == 2
//                                 ? GlobalVar.selectedNavBarColor
//                                 : GlobalVar.backgroundColor,
//                             width: borderWidth))),
//                 child: const badges.Badge(
//                     badgeContent: const Text('3'),
//                     badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
//                     child: const Icon(Icons.track_changes_outlined)),
//               ),
//               label: '')
//         ]);
//   }
// }

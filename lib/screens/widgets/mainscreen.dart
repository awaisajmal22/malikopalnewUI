// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
// import 'package:malikopal/screens/dashboard/dashboard.screens/dashboard.dart';
// import 'package:malikopal/screens/setting/setting.dart';
// import 'package:malikopal/screens/widgets/back_alert.dart';

// class NewBottomNav extends StatelessWidget {
//   NewBottomNav({Key? key}) : super(key: key);

//   ListQueue<int> _navigationQueue = ListQueue(0);
//   int selectedIndex = 0;
//   List<Widget> screens = <Widget>[
//     // Logout(),
//     DashBoardScreen(),
//     SettingScreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     // Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: screens[selectedIndex],
//         bottomNavigationBar: SizedBox(
//           height: 100,
//           child: ,
//         ));
//   }

//   // BottomNavigationBar(
//   //         currentIndex: selectedIndex,
//   //         type: BottomNavigationBarType.fixed,
//   //         onTap: _selectPage,
//   //         items: [
//   //           BottomNavigationBarItem(icon: Logout(), label: ""),
//   //           BottomNavigationBarItem(icon: dashBoard(), label: ""),
//   //           BottomNavigationBarItem(icon: setting(), label: "")
//   //         ])

//   // Widget Logout() {
//   //   double width = MediaQuery.of(context).size.width;

//   //   return Transform(
//   //     transform:
//   //         Matrix4.translationValues(_animateleft.value * width, 0.0, 0.0),
//   //     child: AnimatedOpacity(
//   //       duration: _duration,
//   //       opacity: _animopacity.value,
//   //       child: GestureDetector(
//   //         onTap: () {
//   //           print(" go to Hide Capital Screen");
//   //           OnBackToLogout().Logout(
//   //               ctx: context,
//   //               title: "Confirmation Dialog",
//   //               content: "Do You Want to Logout?");
//   //         },
//   //         child: AnimatedCircularButton(
//   //             color: [Theme.of(context).cardColor, Theme.of(context).cardColor],
//   //             Icon: Center(
//   //               child: SizedBox(
//   //                 height: 35,
//   //                 width: 35,
//   //                 child: SvgPicture.asset("assets/svg/logout.svg",
//   //                     color: Theme.of(context).indicatorColor),
//   //               ),
//   //             ),
//   //             text: "Logout"),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget dashBoard() => Opacity(
//   //       opacity: _animopacity.value,
//   //       child: GestureDetector(
//   //         onTap: () {
//   //           Navigator.pushNamed(context, DashBoardScreen.routeName);

//   //           // Navigator.of(context).pushNamedAndRemoveUntil(
//   //           //     DashBoardScreen.routeName, (Route route) => route.isFirst);
//   //         },
//   //         child: AnimatedCircularButton(
//   //             color: [Theme.of(context).cardColor, Theme.of(context).cardColor],
//   //             Icon: Center(
//   //               child: SizedBox(
//   //                 height: 35,
//   //                 width: 35,
//   //                 child: SvgPicture.asset("assets/svg/dashboard_icon.svg",
//   //                     color: Theme.of(context).indicatorColor),
//   //               ),
//   //             ),
//   //             text: "Dashboard"),
//   //       ),
//   //     );
//   // Widget setting() {
//   //   double width = MediaQuery.of(context).size.width;

//   //   return Transform(
//   //     transform:
//   //         Matrix4.translationValues(_animateright.value * width, 0.0, 0.0),
//   //     child: AnimatedOpacity(
//   //       duration: _duration,
//   //       opacity: _animopacity.value,
//   //       child: GestureDetector(
//   //         onTap: () {
//   //           print("----Pressed.. go to Setting");
//   //           Navigator.push(
//   //             context,
//   //             MaterialPageRoute(
//   //               builder: (context) => SettingScreen(),
//   //             ),
//   //           );
//   //           // Navigator.of(context).pushNamedAndRemoveUntil(
//   //           //     SettingScreen.routeName, (Route route) => true);
//   //         },
//   //         child: AnimatedCircularButton(
//   //             color: [Theme.of(context).cardColor, Theme.of(context).cardColor],
//   //             Icon: Center(
//   //               child: SizedBox(
//   //                 height: 35,
//   //                 width: 35,
//   //                 child: SvgPicture.asset("assets/svg/setting.svg",
//   //                     color: Theme.of(context).indicatorColor),
//   //               ),
//   //             ),
//   //             text: "Setting"),
//   //       ),
//   //     ),
//   //   );
//   // }
// }

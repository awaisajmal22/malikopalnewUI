import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/screens/setting/profile_screen.dart';
import 'package:malikopal/screens/setting/update_profile.dart';
import 'package:malikopal/utils/utility.dart';
import 'package:page_transition/page_transition.dart';

import '../dashboard/custom.widgets/custom_widgets.dart';
import '../dashboard/dashboard.screens/dashboard.dart';
import '../setting/payment_history.dart';
import '../setting/referenceIn_screen.dart';
import '../setting/setting.dart';
import '../setting/subreference/sub_reference_sub.dart';
import 'back_alert.dart';

customDrawer({
  required BuildContext context,
  required List<DrawerModel> drawerList,
  required GlobalKey<ScaffoldState> key,
}) {
  return Drawer(
    backgroundColor: Colors.transparent,
    width: MediaQuery.of(context).size.width.w * 0.6,
    child: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
          color: isDarkThemeEnabled(context) ? Color(0xFF2A2D2E) : Colors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.close,
                  color:
                      isDarkThemeEnabled(context) ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height.h * 0.05,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/svg/ic_launcher.png',
                  height: MediaQuery.of(context).size.width.h * 0.20,
                ),
                Image.asset(
                  "assets/svg/splashtitle.png",
                  width: MediaQuery.of(context).size.width.h * 0.20,
                  color: Color(0xff1F5FA2),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black.withOpacity(0.25),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20),
              children: List.generate(
                  drawerList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            key.currentState?.closeDrawer();
                            if (drawerList[index].title.toLowerCase() ==
                                "dashboard".toLowerCase()) {
                              currentScreen.add(screen.dashboard);

                              Navigator.pushNamed(
                                      context, DashBoardView.routeName)
                                  .then((value) {
                                currentScreen.add(screen.home);
                              });
                            } else if (drawerList[index].title.toLowerCase() ==
                                "Payment History".toLowerCase()) {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: Duration(milliseconds: 300),
                                    child: PaymentHistoryView()),
                              );
                            } else if (drawerList[index].title.toLowerCase() ==
                                "Update Profile".toLowerCase()) {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: Duration(milliseconds: 300),
                                    child: UpdateProfileView(
                                      isBankDetailUpdate: false,
                                      isProfileUpdate: false,
                                    )),
                              );
                            } else if (drawerList[index].title.toLowerCase() ==
                                "Reference In".toLowerCase()) {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: Duration(milliseconds: 300),
                                    child: ReferenceInScreen()),
                              );
                            } else if (drawerList[index].title.toLowerCase() ==
                                "Sub Reference".toLowerCase()) {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    duration: Duration(milliseconds: 300),
                                    child: SubRefenceSubUserScreen()),
                              );
                            } else if (drawerList[index].title.toLowerCase() ==
                                "View Profile".toLowerCase()) {
                              currentScreen.add(screen.profile);

                              Navigator.pushNamed(
                                      context, ProfileView.routeName)
                                  .then((value) {
                                currentScreen.add(screen.home);
                              });
                            } else if (drawerList[index].title.toLowerCase() ==
                                "Settings".toLowerCase()) {
                              currentScreen.add(screen.setting);

                              Navigator.pushNamed(
                                      context, SettingScreen.routeName)
                                  .then((value) {
                                currentScreen.add(screen.home);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/newassets/${drawerList[index].icon}.png',
                                height: 14,
                                width: 14,
                                color: Color(0xffACBBF3),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                drawerList[index].title,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isDarkThemeEnabled(context)
                                        ? Colors.white
                                        : Color(0xff15141F)),
                              )
                            ],
                          ),
                        ),
                      )),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  OnBackToLogout().Logout(
                      ctx: context,
                      title: "Confirmation Dialog",
                      content: "Do You Want to Logout?");
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/newassets/login.png',
                      height: 14,
                      width: 14,
                      color: Color(0xffACBBF3),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDarkThemeEnabled(context)
                              ? Colors.white
                              : Color(0xff15141F)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class DrawerModel {
  final String title;
  final String icon;
  final Widget widget;
  DrawerModel({required this.title, required this.icon, required this.widget});
}

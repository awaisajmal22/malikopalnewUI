import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/setting/bimonthly_ratio.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/closingPayment.dart';
import 'package:malikopal/screens/setting/change_password.dart';
import 'package:malikopal/screens/setting/image_galleryscreen.dart';
import 'package:malikopal/screens/setting/profile_screen.dart';
import 'package:malikopal/screens/setting/subreference/sub_refence_user.dart';
import 'package:malikopal/screens/setting/subreference/sub_reference_sub.dart';
import 'package:malikopal/screens/setting/update_bank_details.dart';
import 'package:malikopal/screens/setting/update_profile.dart';
import 'package:malikopal/screens/setting/capital_history.dart';
import 'package:malikopal/screens/setting/last_deposite.dart';
import 'package:malikopal/screens/setting/payment_history.dart';
import 'package:malikopal/screens/setting/recieved_amount.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/utils/utility.dart';

import '../../../utils/fcm_notifcatin_utils.dart';
import '../../setting/referenceIn_screen.dart';

class DashBoardView extends StatefulWidget {
  DashBoardView({Key? key}) : super(key: key);

  static const routeName = '/Dashboard-view';

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  //

  List<String> grid_menu_name = [
    "Capital \nHistory",
    "Payment \History",
    "Received Amount",
    "Closing \nPayment",
    "Bimonthly \nRatio",
    "Image\nGallery",
    "Update \nProfile",
    "Update Bank Details",
    "Last Deposit",
    "View Profile ",
    // "Password",
  ];

  List<String> grid_menu_icons = [
    "assets/newassets/capital_history.png",
    "assets/newassets/closing_payment_history.png",
    "assets/newassets/received_amount.png",
    "assets/newassets/closing_payment.png",
    "assets/newassets/ratio.png",
    "assets/newassets/image_gallery.png",
    "assets/newassets/update_profile.png",
    "assets/newassets/update_bank_details.png",
    "assets/newassets/lastamount.png",
    "assets/newassets/personal_profile.png",
    // "assets/svg/change_pass.svg",
  ];

  List<Widget> views = [
    CapitalHistoryView(), //0
    PaymentHistoryView(), //1
    RecievedAmountView(), //2
    ClosingPaymentView(), //3
    BimonthlyRatioScreen(), //4
    ImageGalleryView(),
    UpdateProfileView(
      isProfileUpdate: false,
      isBankDetailUpdate: false,
    ),
    UpdateBankDetailsView(
      bankDetailUpdate: false,
    ),
    LastDepositeView(),
    ProfileView(),
    // ChangePassword(),
  ];

  NotificationUtils notificationUtils = NotificationUtils();

  Size size({required BuildContext context}) {
    return MediaQuery.of(context).size;
  }

  bool isDarkEnable = false;
  bool isRefrenceAllowed = false;
  bool IsSubReferenceAllowed = false;
  int selectedIndex = 0;

  @override
  void initState() {
    //

    SessionData().getUserProfile().then((value) {
      // ,
      //

      isRefrenceAllowed = kReleaseMode ? value.IsRefrenceInAllowed : true;

      IsSubReferenceAllowed =
          kReleaseMode ? value.IsSubReferenceAllowed ?? false : true;

      if (isRefrenceAllowed) {
        //

        grid_menu_name.insert(10, 'Reference \nIn');

        grid_menu_icons.insert(
          10,
          // 'assets/svg/ref_in.png'
          "assets/newassets/reference_in.png",
        );
        ReferenceInScreen.showData = value.IsShowDataAllowed ?? false;

        views.insert(10, ReferenceInScreen());
      }

      if (IsSubReferenceAllowed) {
        grid_menu_name.insert(11, 'Sub Reference');

        grid_menu_icons.insert(
          11,
          // 'assets/svg/subRefenceIn.png'
          "assets/newassets/sub_reference.png",
        );

        views.insert(11, SubRefenceSubUserScreen());
      }

      setState(() {});
    });

    //

    notificationUtils.initMessaging();

    super.initState();
  }

  fc() async {
    dp(msg: "Fcm= ", arg: await FirebaseMessaging.instance.getToken());
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    fc();

    return WillPopScope(
      onWillPop: () async {
        currentScreen.add(screen.home);

        Navigator.pushNamed(context, HideCapitalView.routeName).then((value) {
          currentScreen.add(screen.home);
        });

        return true;
      },
      child: Scaffold(
        bottomNavigationBar: AnimatedBottomNavBar(),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff1F5FA2),
            Color(0xff272E6D),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          alignment: Alignment.center,
          height: size(context: context).height,
          width: size(context: context).width,
          child: dashboardbody(context),
        ),
      ),
    );
  }

  Widget dashboardbody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 40.h,
        ),
        Flexible(
          flex: 2,
          child: CustomTopBar(
            isNavBar: true,
            topbartitle: 'Dashboard',
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Flexible(
          flex: 12,
          child: Padding(
            padding: EdgeInsets.all(0),
            //  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                  color: isDarkThemeEnabled(context)
                      ? Color(0xff585959)
                      : Color(0xFFFFFFFF),
                  //  Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(28),
                    topLeft: Radius.circular(28),
                  ),
                  // BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.2),
                        blurRadius: 34.h,
                        spreadRadius: 8.w,
                        offset: Offset(2, 5)),
                  ]),
              alignment: Alignment.center,
              child: ShowUpAnimation(
                delayStart: Duration(milliseconds: 0),
                animationDuration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                direction: Direction.horizontal,
                offset: 0.7,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // mainAxisExtent: 100,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: grid_menu_name.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRight,
                              duration: Duration(milliseconds: 300),
                              child: views[index]),
                        );
                      },
                      child: Container(
                        // height: size(context: context).height / 9,
                        // width: size(context: context).width / 9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xff205598),
                            )
                            // color: Theme.of(context).cardColor,
                            // shape: BoxShape.circle
                            // borderRadius: BorderRadius.circular(12),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Theme.of(context)
                            //           .shadowColor
                            //           .withOpacity(0.4),
                            //       blurRadius: 0.7.h,
                            //       spreadRadius: 0.8.w,
                            //       // offset: Offset(0.2, 0.3),
                            //       blurStyle: BlurStyle.outer),
                            // ],
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              grid_menu_icons[index],
                              height: (index == 10 || index == 11 || index == 8)
                                  ? 40.h
                                  // 30.h
                                  : 35.h,
                              // 25.h,
                              width: (index == 10 || index == 11 || index == 8)
                                  ? 40.h
                                  // 30.h
                                  : 35.w,
                              // 25.w,
                              fit: BoxFit.contain,
                              // color: isDarkThemeEnabled(context)
                              //     ? Colors.white
                              //     : Color(0xff1164AA),
                              // color: Color.fromARGB(255, 107, 4, 91),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 08.w, vertical: 0.h),
                              child: FittedBox(
                                child: SizedBox(
                                  width: 90.w,
                                  child: Text(
                                    grid_menu_name[index],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        // Spacer(),
        // SizedBox(
        //   height: 30.h,
        // ),
      ],
    );
  }
}

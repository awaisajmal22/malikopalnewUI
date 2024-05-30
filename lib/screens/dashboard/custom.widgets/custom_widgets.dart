import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malikopal/model/DashboardResponse_model.dart';
import 'package:malikopal/model/SendNotificationResponse_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/dashboard.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/notifications.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/setting/setting.dart';
import 'package:malikopal/screens/widgets/back_alert.dart';
import 'package:ionicons/ionicons.dart';

import '../../../ScopedModelWrapper.dart';

enum screen { home, dashboard, setting, logout }

var currentScreen = BehaviorSubject<screen>.seeded(screen.home);

//Animated bottomBar
class AnimatedBottomNavBar extends StatefulWidget {
  //

  AnimatedBottomNavBar({Key? key}) : super(key: key);

  static const routeName = '/animatedBottomNavBar';

  @override
  State<AnimatedBottomNavBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<AnimatedBottomNavBar> {
  //

  // final _duration = Duration(milliseconds: 1500);

  // late AnimationController _controller;
  // late Animation<double> _animopacity;

  // late Animation<double> _animateleft, _animateright;

  // @override
  // void initState() {
  //   //
  //   _controller = AnimationController(vsync: this, duration: _duration);

  //   _animopacity = Tween<double>(begin: 0.0, end: 1.0).animate(
  //       CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

  //   _animateleft = Tween<double>(begin: -1.0, end: 0.0).animate(
  //       CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

  //   _animateright = Tween<double>(begin: 1.0, end: 0.0).animate(
  //       CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

  //   _controller.forward();

  //   super.initState();
  // }

  // @override
  // Future<void> dispose() async {
  //   _controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    AppModel model = ScopedModel.of<AppModel>(context);

    return Container(
      height: isTablet() ? 170 : size.height * 0.12.h,
      width: size.width,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          color: model.isDarkTheme ? Color(0xff585959) : Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
                color: Color(0xff022964).withOpacity(0.08),
                blurRadius: 80,
                spreadRadius: 0,
                offset: Offset(0, -4))
          ]),
      padding: EdgeInsets.only(
        top: isTablet() ? 0 : 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              //
              currentScreen.add(screen.home);

              Navigator.pushNamed(context, HideCapitalView.routeName)
                  .then((value) {
                currentScreen.add(screen.home);
              });

              //
            },
            child: AnimatedCircularButton(
                color: [
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor
                ],
                textColor: currentScreen.value == screen.home
                    ? null
                    : Color(0xffACBBF3),
                Icon: Center(
                  child: SvgPicture.asset(
                    currentScreen.value == screen.home
                        ? "assets/newassets/homeSelected.svg"
                        : "assets/newassets/homeUnselected.svg",
                    color: currentScreen.value == screen.home
                        ? Color(0xff1164AA)
                        : null,
                  ),
                ),
                text: "Home"),
          ),
          GestureDetector(
            onTap: () {
              currentScreen.add(screen.dashboard);

              Navigator.pushNamed(context, DashBoardView.routeName)
                  .then((value) {
                currentScreen.add(screen.home);
              });
              ;
            },
            child: AnimatedCircularButton(
                color: [
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor
                ],
                textColor: currentScreen.value == screen.dashboard
                    ? null
                    : Color(0xffACBBF3),
                Icon: Center(
                  child: SvgPicture.asset(
                    currentScreen.value == screen.dashboard
                        ? "assets/newassets/dashbordSelected.svg"
                        : "assets/newassets/dashBordUnselected.svg",
                    color: currentScreen.value == screen.dashboard
                        ? Color(0xff1164AA)
                        : null,
                  ),
                ),
                text: "Dashboard"),
          ),
          GestureDetector(
            onTap: () {
              //

              currentScreen.add(screen.setting);

              Navigator.pushNamed(context, SettingScreen.routeName)
                  .then((value) {
                currentScreen.add(screen.home);
              });
            },
            child: AnimatedCircularButton(
                textColor: currentScreen.value == screen.setting
                    ? null
                    : Color(0xffACBBF3),
                color: [
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor
                ],
                Icon: Center(
                  child: SvgPicture.asset(
                    "assets/newassets/logout.svg",
                    color: currentScreen.value == screen.setting
                        ? Color(0xff1164AA)
                        //  Color(0xff912C8C)
                        : null,
                  ),
                ),
                text: "Setting"),
          ),
          GestureDetector(
            onTap: () {
              print("Log out");

              currentScreen.add(screen.logout);

              OnBackToLogout().Logout(
                  ctx: context,
                  title: "Confirmation Dialog",
                  content: "Do You Want to Logout?");
            },
            child: AnimatedCircularButton(
                color: [
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor
                ],
                textColor: currentScreen.value == screen.logout
                    ? null
                    : Color(0xffACBBF3),
                Icon: Center(
                  child: SvgPicture.asset(
                    "assets/newassets/setting.svg",
                    color: currentScreen.value == screen.logout
                        ? Color(0xff1164AA)
                        // Color(0xff912C8C)
                        : null,
                  ),
                ),
                text: "Logout"),
          ),
        ],
      ),
    );
  }
}

//Animated circular bar

class AnimatedCircularBar extends StatefulWidget {
  AnimatedCircularBar({
    this.radius,
    this.color1,
    this.offsetx,
    this.offsety,
    this.negativeOffsetx,
    this.negativeOffsety,
    this.child,
    this.color,
    this.blurradius,
    this.spreadradius,
    this.border,
    Key? key,
  }) : super(key: key);

  final double? radius;

  final Color? color, color1;
  final Widget? child;
  final BoxBorder? border;
  final double? offsetx, offsety;
  final double? negativeOffsetx, negativeOffsety;
  final double? blurradius, spreadradius;

  @override
  State<AnimatedCircularBar> createState() => _AnimatedCircularBarState();
}

class _AnimatedCircularBarState extends State<AnimatedCircularBar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.radius ?? 190.h,
      width: widget.radius ?? 190.w,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        shape: BoxShape.circle,
        border: widget.border ??
            Border.all(
              color: Theme.of(context).shadowColor,
              style: BorderStyle.solid,
              width: 1.5,
            ),
        boxShadow: [
          BoxShadow(
            // color: Colors.purple,
            color:
                widget.color ?? Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: widget.blurradius ?? 03.0.w, // soften the shadow
            spreadRadius: widget.spreadradius ?? 04.0.h,
            offset: Offset(
              widget.negativeOffsetx ?? -02.0.h,
              widget.negativeOffsety ?? -03.0.w,
            ),
          ),
          BoxShadow(
            // color: Colors.blue,
            color:
                widget.color1 ?? Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: widget.blurradius ?? 04.0, // soften the shadow
            spreadRadius: widget.spreadradius ?? 0.40,
            offset: Offset(
              widget.offsetx ?? 12.0.h,
              widget.offsety ?? 10.0.w,
            ),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}

class CustomCaledner extends StatefulWidget {
  const CustomCaledner({Key? key}) : super(key: key);

  @override
  State<CustomCaledner> createState() => _CustomCalednerState();
}

class _CustomCalednerState extends State<CustomCaledner> {
  @override
  void initState() {
    super.initState();
  }

  var myFormat = DateFormat('dd-MM-yyyy');
  DateTime selectedDate = DateTime.now();

  Future<void> showDateTimePicker() async {
    DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (datePicked != null) {
      setState(() {
        selectedDate = datePicked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          child: Text(
            selectedDate == ""
                ? "Select Date"
                : "${myFormat.format(selectedDate)}",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 13.41, fontWeight: FontWeight.w300),
          ),
          onPressed: () {
            setState(() {
              showDateTimePicker();
              print("$showDateTimePicker");
            });
            ;
          }),
    );
  }
}

class AnimatedTopBarTile extends StatefulWidget {
  const AnimatedTopBarTile({required this.notificationCount, Key? key})
      : super(key: key);
  final int notificationCount;
  @override
  State<AnimatedTopBarTile> createState() => _AnimatedTopBarTileState();
}

class _AnimatedTopBarTileState extends State<AnimatedTopBarTile>
    with SingleTickerProviderStateMixin {
  final _duration = Duration(milliseconds: 1500);
  late AnimationController _topBarController;
  late Animation<double> _intervaltween, _animateleft;

  @override
  void initState() {
    _topBarController = AnimationController(vsync: this, duration: _duration);
    _animateleft = Tween<double>(begin: -2.0, end: 0.0).animate(
        CurvedAnimation(parent: _topBarController, curve: Curves.easeInBack));
    _intervaltween = Tween<double>(begin: 2.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _topBarController,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    _topBarController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _topBarController.dispose();
    super.dispose();
  }

  ApiResponse<List<SendNotificationResponseDataModel>>? data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _topBarController.view,
      builder: (context, child) {
        return Padding(
          padding:
              EdgeInsets.only(left: 18.0.h, right: 08, bottom: 10, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScopedModelDescendant<AppModel>(builder: (context, _, model) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(
                          _animateleft.value * size.width, 0.0, 0.0),
                      child: SizedBox(
                        child: Image.asset(
                          'assets/images/opal-logo.png',
                          height: 80.h,
                        ),
                      ),
                      // FittedBox(
                      //   child: Container(
                      //     alignment: Alignment.centerLeft,
                      //     height: 15.h,
                      //     margin: EdgeInsets.only(top: 8.h, left: 04.w),
                      //     child: Image.asset(
                      //      model.isDarkTheme ? "assets/images/text4xdark.png" :  "assets/images/text4x.png",
                      //     ),
                      //   ),
                    ),
                  ],
                );
              }),
              Transform(
                transform: Matrix4.translationValues(
                    _intervaltween.value * size.width, 0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    // margin: EdgeInsets.only(right: 12, left: 12, top: 08),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, NotificationView.routeName);
                      },
                      child: Stack(
                        children: [
                          widget.notificationCount == 0
                              ? Positioned(
                                  child: Container(height: 18.h, width: 18.h))
                              : Positioned(
                                  top: 0.h,
                                  right: 0.h,
                                  child: Container(
                                    height: 18.h,
                                    width: 18.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.purple,
                                    ),
                                    child: Center(
                                        child: Text(
                                            widget.notificationCount.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    fontSize: 12.sp,
                                                    color: Colors.white))),
                                    // child: ListView.builder(
                                    //     itemCount: data?.data?.length ?? 0,
                                    //     itemBuilder: (context, index) {
                                    //       return Text(
                                    //         data?.data?[index].newMsgs.toString() ??
                                    //             "",
                                    //         style: Theme.of(context)
                                    //             .textTheme
                                    //             .bodyText2!
                                    //             .copyWith(fontSize: 10.sp),
                                    //       );
                                    //     }),
                                  ),
                                ),
                          FittedBox(
                            child: SvgPicture.asset(
                              "assets/svg/notification.svg",
                              height: 26.h,
                              width: 26.h,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AnimatedLongButton extends StatefulWidget {
  AnimatedLongButton(
      {this.text,
      this.fontsize,
      this.Prefixtext,
      this.borderRadius = 19,
      this.color,
      this.width,
      this.textColor,
      required this.onPressed,
      this.fontWeight = FontWeight.w400,
      this.child,
      this.topPadding = 5.0,
      this.bottomPadding = 5.0,
      this.leftPadding = 5.0,
      this.rightPadding = 5.0,
      this.height,
      Key? key,
      required this.isBgColorWhite})
      : super(key: key);
  final FontWeight fontWeight;
  final double topPadding;
  final double bottomPadding;
  final String? text;
  final List<Color>? color;
  final bool isBgColorWhite;
  final double? fontsize, width;
  final String? Prefixtext;
  final Color? textColor;
  final Widget? child;
  final double? borderRadius;
  final VoidCallback onPressed;
  final double? height;
  final double leftPadding;
  final double rightPadding;
  @override
  State<AnimatedLongButton> createState() => _AnimatedLongButtonState();
}

class _AnimatedLongButtonState extends State<AnimatedLongButton>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 1000);
  late AnimationController _animationcontroller;

  //  _animateright;
  @override
  void initState() {
    _animationcontroller =
        AnimationController(vsync: this, duration: _duration);

    _animationcontroller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animationcontroller.view,
        builder: (context, child) {
          return SizedBox(
            height: widget.height == null
                ? isTablet()
                    ? 110.h
                    : 70.h
                : widget.height,
            width: widget.width ?? width * 0.78.w,
            // alignment: Alignment.center,
            // padding: EdgeInsets.only(
            //     top: widget.topPadding, bottom: widget.bottomPadding),
            // margin: EdgeInsets.symmetric(horizontal: 08.w),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(widget.borderRadius!),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.grey.withOpacity(0.2),
            //       blurStyle: BlurStyle.outer,
            //       blurRadius: 40.w,
            //       spreadRadius: 0.7.h,
            //       offset: Offset(3.h, 4.w),
            //     ),
            //   ],
            //   gradient: LinearGradient(
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight,
            //     colors: widget.color ??
            //         [Theme.of(context).cardColor, Theme.of(context).cardColor],
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.only(
                left: widget.leftPadding,
                right: widget.rightPadding,
                bottom: widget.bottomPadding,
                top: widget.topPadding,
              ),
              child: GestureDetector(
                onTap: widget.onPressed,
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: widget.isBgColorWhite == true
                //       ? Colors.white
                //       : Color(0xff254180),
                //   //  Color(0xff1164AA),
                //   foregroundColor: widget.isBgColorWhite == false
                //       ? Colors.white
                //       : Color(0xFF58595B),
                //   textStyle: TextStyle(
                //     fontFamily: 'Montserrat',
                //     fontWeight: FontWeight.w400,
                //     fontSize: 20,
                //   ),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(widget.borderRadius!),
                //   ),
                //   elevation: 20,
                // ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.h),
                      gradient: LinearGradient(
                        colors: widget.color ??
                            [Color(0xff1F5FA2), Color(0xff272E6D)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: widget.child ??
                      Text(
                        widget.text ?? "".toUpperCase(),
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: widget.fontsize ?? 18.sp,
                              fontFamily: "Montserrat",
                              fontWeight: widget.fontWeight,
                              color: widget.isBgColorWhite
                                  ? widget.textColor ?? Colors.black
                                  : Colors.white,
                            ),
                      ),
                ),
              ),
            ),
          );
        });
  }
}

class AnimatedAlertDialog extends StatefulWidget {
  AnimatedAlertDialog(
      {this.begin,
      this.end,
      this.isCloseOption,
      this.btn_begin,
      this.btn_end,
      this.color,
      this.color_v2,
      this.description,
      this.textcolor,
      this.iconcolor,
      // this.title,
      Key? key})
      : super(key: key);
  bool? isCloseOption = false;
  final List<Color>? color, color_v2;
  final String? description;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final AlignmentGeometry? btn_begin;
  final AlignmentGeometry? btn_end;
  final Color? textcolor;
  final Color? iconcolor;
  // final String? title;

  @override
  State<AnimatedAlertDialog> createState() => _AnimatedAlertDialogState();
}

class _AnimatedAlertDialogState extends State<AnimatedAlertDialog> {
  bool isWithdraw = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.h, right: 8.0.h, top: 8.0.h),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 100,
            // height: isTablet() ? 400.h : 320.h,
            decoration: BoxDecoration(
              // color: Color(0xFF7F3F97),
              gradient: LinearGradient(
                begin: widget.begin ?? Alignment.topRight,
                end: widget.end ?? Alignment.bottomLeft,
                colors: widget.color ??
                    [
                      Color(0xffACBBF3),
                      Color(0xffACBBF3),
                      // Color(0xFF2C7FFF),
                      // Color(0xFF6EFF98),
                    ],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(23.h),
                  topRight: Radius.circular(23.h)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Divider(
                //   height: 3.h,
                //   color: Colors.white.withOpacity(0.9),
                //   endIndent: 170.h,
                //   indent: 170.h,
                //   thickness: 4,
                // ),

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       // GestureDetector(
                //       //   onTap: () {
                //       //     Navigator.pop(context);
                //       //   },
                //       //   child: Center(
                //       //     child: Container(
                //       //       height: 20.h,
                //       //       width: 20.w,
                //       //       child: Image.asset(
                //       //         "assets/images/cross.png",
                //       //         color: Colors.white,
                //       //       ),
                //       //     ),
                //       //   ),
                //       // ),
                //       SizedBox(
                //         height: 15,
                //       )
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 28.h,
                ),
                // Text(
                //   widget.title ?? 'Alert',
                //   style: Theme.of(context).textTheme.headline6!.copyWith(
                //         fontSize: 18.5.sp,
                //         fontFamily: "Montserrat",
                //         fontWeight: FontWeight.bold,
                //         color: widget.textcolor ?? Colors.white,
                //       ),
                // ),

                SizedBox(
                  height: 18.h,
                ),
                // widget.title == 'CLOSING PAYMENT'
                //     ?
                Image.asset(
                  'assets/newassets/ic_question.png',
                  height: 68.h,
                  width: 68.w,
                  // color: Theme.of(context).dividerColor,
                ),
                // : AnimatedCircularButton(
                //     color: widget.color_v2 ??
                //         [
                //           Theme.of(context).cardColor,
                //           Theme.of(context).cardColor
                //         ],
                //     iconColor: Colors.white,
                //     Icon: Center(
                //       child: SvgPicture.asset(
                //         "assets/svg/exclamation.svg",
                //         color: widget.iconcolor ?? Color(0xFF7F3F97),
                //       ),
                //     ),
                //   ),
                SizedBox(
                  height: 18.h,
                ),
                SizedBox(
                  // width: 300.w,
                  height: isTablet() ? 75.h : 60.h,
                  child: Text(
                    widget.description ?? "",
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 14.8.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff343434),
                        ),
                  ),
                ),
                // SizedBox(
                //   height: 10.sp,
                // ),
                AnimatedLongButton(
                  color: [Color(0xff1F5FA2), Color(0xff272E6D)],
                  width: MediaQuery.of(context).size.width * 100,
                  height: isTablet() ? 56.6.h : 47.h,
                  topPadding: 0,
                  bottomPadding: 0,
                  leftPadding: 28.h,
                  rightPadding: 28.h,
                  borderRadius: 14,
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HideCapitalView(),
                      ),
                    );
                  },
                  text: "CLOSE",
                  textColor: Colors.white,
                  isBgColorWhite: true,
                ),

                SizedBox(
                  height: 28.h,
                ),
              ],
            ),
          ),
          widget.isCloseOption == true
              ? InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HideCapitalView(),
                      ),
                    );
                  },
                  child: Container(
                    width: 47.h,
                    height: 47.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.h),
                      child: SvgPicture.asset(
                        'assets/svg/ic_close.svg',
                        color: Color(0xff205598),
                        // color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class AnimatedPendingAlertDailog extends StatefulWidget {
  AnimatedPendingAlertDailog(
      {this.begin,
      this.end,
      this.btn_begin,
      this.btn_end,
      this.color,
      this.color_v2,
      this.description,
      this.textcolor,
      this.iconcolor,
      this.title,
      this.urduDescription1,
      this.dateforUrdu,
      this.urduDescription2,
      this.daterich,
      this.description2,
      Key? key})
      : super(key: key);

  final List<Color>? color, color_v2;
  final String? description;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final AlignmentGeometry? btn_begin;
  final AlignmentGeometry? btn_end;
  final Color? textcolor;
  final Color? iconcolor;
  final String? title;
  final String? urduDescription1;
  final String? description2;

  final String? daterich;

  final String? urduDescription2;
  final String? dateforUrdu;

  @override
  State<AnimatedPendingAlertDailog> createState() =>
      _AnimatedPendingAlertDailogState();
}

class _AnimatedPendingAlertDailogState
    extends State<AnimatedPendingAlertDailog> {
  bool isWithdraw = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0.h, right: 8.0.h, left: 8.0.h),
      child: Container(
        // height: isTablet() ? 495.h : 480.h,
        decoration: BoxDecoration(
            // color: Color(0xFF7F3F97),
            gradient: LinearGradient(
              begin: widget.begin ?? Alignment.topRight,
              end: widget.end ?? Alignment.bottomLeft,
              colors: widget.color ??
                  [
                    Color(0xffACBBF3),
                    Color(0xffACBBF3),
                    // Color(0xFF2C7FFF),
                    // Color(0xFF6EFF98),
                  ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            )
            // BorderRadius.circular(28),
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Divider(
            //   height: 3.h,
            //   color: Colors.white.withOpacity(0.9),
            //   endIndent: 170.h,
            //   indent: 170.h,
            //   thickness: 4,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 18.0.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       // GestureDetector(
            //       //   onTap: () {
            //       //     Navigator.pop(context);
            //       //   },
            //       //   child: Center(
            //       //     child: Container(
            //       //       height: 20.h,
            //       //       width: 20.w,
            //       //       child: Image.asset(
            //       //         "assets/images/cross.png",
            //       //         color: Colors.white,
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //       // SizedBox(
            //       //   height: 15,
            //       // )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 56.6.h,
              //   child: Center(
              //     child: Text(
              //       widget.title ?? 'Alert',
              //       style: Theme.of(context).textTheme.headline6!.copyWith(
              //             fontSize: 18.5.sp,
              //             fontFamily: "Montserrat",
              //             fontWeight: FontWeight.bold,
              //             color: widget.textcolor ?? Colors.white,
              //           ),
              //     ),
              //   ),
            ),

            // Container(
            //   height: 3,
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: Colors.white,
            //         width: 1,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 18.h,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // AnimatedCircularButton(
                //   isAlertBorder: true,
                //   color: widget.color_v2 ??
                //       [
                //         Theme.of(context).cardColor,
                //         Theme.of(context).cardColor
                //       ],
                //   iconColor: Colors.white,
                //   Icon: Center(
                //     child: Container(
                //       height: 28.h,
                //       width: 28.w,
                //       child: SvgPicture.asset(
                //         "assets/svg/exclamation.svg",
                //         color: widget.iconcolor ?? Color(0xFF7F3F97),
                //       ),
                //     ),
                //   ),
                // ),
                Image.asset(
                  'assets/newassets/ic_question.png',
                  width: 65.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 28.h,
                    bottom: 28.h,
                    left: 9.5.h,
                    right: 9.5.h,
                  ),
                  child: Text(
                    '${widget.description}${widget.daterich}${widget.description2}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       left: 9.5.h, right: 9.5.h, top: 28.h, bottom: 28.h),
                //   child: RichText(
                //     // softWrap: true,
                //     textAlign: TextAlign.center,
                //     overflow: TextOverflow.visible,
                //     text: TextSpan(
                //       // style: Theme.of(context).textTheme.headline6!.copyWith(
                //       //       fontSize: 19,
                //       //       fontWeight: FontWeight.bold,
                //       //       color: Color(0xFFFFF100),
                //       //     ),
                //       children: [
                //         TextSpan(
                //           text: widget.description ?? "",
                //           style: TextStyle(
                //             fontSize:
                //                 19, // Adjust the font size of the superscript
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "Montserrat",
                //             color: Color(0xFFFFF100),
                //             // textBaseline: TextBaseline.alphabetic,
                //           ),
                //         ),
                //         TextSpan(
                //           text: widget.daterich ?? "",
                //           style: TextStyle(
                //             fontFamily: "Montserrat",
                //             fontSize:
                //                 19, // Adjust the font size of the superscript
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xFFFFF100),
                //             // textBaseline: TextBaseline.alphabetic,
                //           ),
                //         ),
                //         TextSpan(
                //           text: widget.description2 ?? "",
                //           style: TextStyle(
                //             fontSize: 19,
                //             fontFamily: "Montserrat",
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xFFFFF100),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20.h, right: 20.h),
                  child: SvgPicture.asset(
                    'assets/svg/ic_urdu_2.svg',
                    color: Colors.white,
                    //  Theme.of(context).dividerColor,
                    height: 65.5.h,
                  ),
                ),
                // SizedBox(
                //   height: 48.h,
                // ),
                // SizedBox(
                //     width: 310.w,
                //     height: isTablet() ? 75.h : 63.h,
                //     child: Column(
                //       children: [
                //         Text(
                //           widget.urduDescription1 ?? '',
                //           textAlign: TextAlign.center,
                //           style:
                //               Theme.of(context).textTheme.headline6!.copyWith(
                //                     fontSize: 16.sp,
                //                     fontWeight: FontWeight.w400,
                //                     fontFamily: "Montserrat",
                //                     color: Colors.white,
                //                   ),
                //         ),
                //         Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 widget.urduDescription2 ?? '',
                //                 textAlign: TextAlign.center,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .headline6!
                //                     .copyWith(
                //                       fontSize: 16.sp,
                //                       fontFamily: "Montserrat",
                //                       fontWeight: FontWeight.w400,
                //                       color: Colors.white,
                //                     ),
                //               ),
                //               Text(
                //                 widget.dateforUrdu ?? '',
                //                 textAlign: TextAlign.center,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .headline6!
                //                     .copyWith(
                //                       fontSize: 16.sp,
                //                       fontWeight: FontWeight.w400,
                //                       fontFamily: "Montserrat",
                //                       color: Colors.white,
                //                     ),
                //               ),
                //             ]),
                //       ],
                //     )
                //     // Text(
                //     //   widget.urduDescription ?? "",
                //     //   // maxLines: 2,
                //     //   softWrap: true,
                //     //   textAlign: TextAlign.center,
                //     //   overflow: TextOverflow.visible,
                //     //   style: Theme.of(context).textTheme.headline6!.copyWith(
                //     //         fontSize: 18.sp,
                //     //         fontWeight: FontWeight.w400,
                //     //         color: Colors.white,
                //     //       ),
                //     // ),
                //     ),
                SizedBox(
                  height: 47.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  height: isTablet() ? 62.h : 47.h,
                  // child:
                  //  InkWell(
                  //   onTap: () {
                  //     Navigator.pop(context);

                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => HideCapitalView(),
                  //       ),
                  //     );
                  //   },

                  child: AnimatedLongButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HideCapitalView(),
                        ),
                      );
                    },
                    borderRadius: 18,
                    topPadding: 0,
                    bottomPadding: 0,
                    leftPadding: 0,
                    rightPadding: 0,
                    text: "CLOSE",
                    textColor: Colors.white,
                    isBgColorWhite: true,
                    fontsize: 18.4.sp,
                  ),
                ),
                // ),
                SizedBox(
                  height: 28.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewMenuButton extends StatelessWidget {
  NewMenuButton(
      {Key? key,
      required this.asssetsName,
      required this.bgColor,
      required this.text,
      this.onPress})
      : super(key: key);

  String asssetsName;
  Color bgColor;
  void Function()? onPress;
  String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: asssetsName.contains(".png")
                      ? Image.asset(
                          asssetsName,
                        )
                      : SvgPicture.asset(
                          asssetsName,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: isTablet() ? 8.sp : 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

//small circular animaated button
class AnimatedCircularButton extends StatefulWidget {
  AnimatedCircularButton(
      {this.begin,
      this.end,
      this.text,
      this.textColor,
      this.isAlertBorder,
      required this.Icon,
      this.radius = 15,
      this.color,
      this.iconColor,
      Key? key})
      : super(key: key);
  bool? isAlertBorder = false;
  final String? text;
  final Widget Icon;
  final List<Color>? color;
  Color? textColor;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final Color? iconColor;

  double radius;
  @override
  State<AnimatedCircularButton> createState() => _AnimatedCircularButtonState();
}

class _AnimatedCircularButtonState extends State<AnimatedCircularButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: Column(
        children: [
          Container(
            width: size.height <= 640 ? 40.h : 60.h,
            height: size.height <= 640 ? 40.h : 60.h,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: widget.iconColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: widget.Icon,
          ),
          SizedBox(
            width: 95.w,
            child: Text(
              widget.text ?? "",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: widget.textColor,
                  overflow: TextOverflow.visible,
                  height: 1.3,
                  fontSize: 13.sp),
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 22.h)
        ],
      ),
    );
  }
}

//Animated title tile
class AnimatedTitle extends StatefulWidget {
  AnimatedTitle({this.trailing, Key? key, this.data}) : super(key: key);

  final Widget? trailing;
  final DashboardResponseDataModel? data;
  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 1500);

  late AnimationController _controller;
  late Animation<double> _animateleft, _animateopacity;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);

    _animateleft = Tween<double>(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
    _animateopacity = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    AppModel model = ScopedModel.of<AppModel>(context);
    return Container(
      width: size,
      child: AnimatedBuilder(
          animation: _controller.view,
          builder: (context, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Transform(
                    transform: Matrix4.translationValues(
                        _animateleft.value * size, 0.0, 0.0),
                    child: AnimatedOpacity(
                      duration: _duration,
                      opacity: _animateopacity.value,
                      child: Text(
                        "Greetings!",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  subtitle: Transform(
                    transform: Matrix4.translationValues(
                        _animateleft.value * size, 0.0, 0.0),
                    child: AnimatedOpacity(
                      duration: _duration,
                      opacity: _animateopacity.value,
                      child: Text(
                        widget.data?.fullName ?? "",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: model.isDarkTheme
                                ? Colors.white
                                : Color(0xff606161)),
                      ),
                    ),
                  ),
                  trailing: widget.trailing ?? null),
            );
          }),
    );
  }
}

//dashboard button
class DashboardBtn extends StatefulWidget {
  DashboardBtn(
      {this.begin,
      this.end,
      this.text,
      required this.Icon,
      this.color,
      Key? key})
      : super(key: key);

  final String? text;
  final Widget Icon;
  final List<Color>? color;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  @override
  State<DashboardBtn> createState() => _DashboardBtnState();
}

class _DashboardBtnState extends State<DashboardBtn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: Column(
        children: [
          Container(
            width: size.height <= 640 ? 65 : 70.h,
            height: size.height <= 640 ? 65 : 70.h,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(),
            child: widget.Icon,
          ),
          SizedBox(
            height: 9.h,
          ),
          FittedBox(
            child: SizedBox(
              width: 95.w,
              child: Text(
                widget.text ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(overflow: TextOverflow.visible, height: 1.3),
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}

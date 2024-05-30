import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:new_version_plus/new_version_plus.dart';
import 'package:malikopal/ScopedModelWrapper.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Auth_Service.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Login_Screen.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/utils/utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = 'splash_Screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  //

  final _duration = Duration(milliseconds: 2500);

  late AnimationController _controller, _repeatcontroller, _colorController;

  late Animation<Size> growAnimation;

  late Animation<Offset> offset;

  late Animation<double> animateup,
      _intervaltween,
      animateuprepeat,
      animateright,
      animateleft;

  bool isSlide = true;

  bool turnBiometricSetting = false;

  bool isTouchIDEnable = false;

  AppModel modal = AppModel();

  checkVersion() async {
    //

    await Future.delayed(Duration(seconds: 2));

    var version = await NewVersionPlus(
      iOSId: 'com.malikopal.mobileappios',
      androidId: 'com.malikopal.app',
    ).showAlertIfNecessary(
        context: context,
        launchModeVersion: Platform.isAndroid
            ? LaunchModeVersion.external
            : LaunchModeVersion.normal);

    dp(msg: "Version", arg: version);
  }

  @override
  void initState() {
    //

    prepareSessionData()
        .whenComplete(() => print('session data has been completed'));
    _repeatcontroller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    animateuprepeat = Tween<double>(begin: 0.3, end: 0.7).animate(
        CurvedAnimation(
            parent: _repeatcontroller, curve: Curves.easeInOutExpo));
    _intervaltween = Tween<double>(begin: 0.4, end: 0.7).animate(
      CurvedAnimation(
        parent: _repeatcontroller,
        curve: Interval(
          0.7,
          1.0,
          curve: Curves.bounceIn,
        ),
      ),
    );
    //controller forword
    _controller = AnimationController(vsync: this, duration: _duration);
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(_controller);
    animateup = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
    animateleft = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
    animateright = Tween<double>(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));

    // _controller.forward();
    _colorController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _controller.forward();
    checkVersion();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _colorController.dispose();
    _repeatcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/splash.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SlideableWidget(
            child: builldSlidecntent(context: context),
            onSlided: () {
              //_showModalBottomSheet(context: context);
              SessionData().getTouchID().then((value) {
                if (value == false) {
                  Navigator.pushReplacementNamed(context, MyHomePage.routeName);
                } else {
                  print('touch active');
                  // AuthService(ctx: context).authenticateUser(
                  //     path: 'splash',
                  //     message: "Scan your Finger to Login App");
                  //_showModalBottomSheet(context: context);
                  var selectedTab = 0;
                  AuthenticationService(ctx: context)
                      .authenticateUser(
                          path: 'splash',
                          type: selectedTab == 0 ? 'thumb' : 'face',
                          message: "Scan your " +
                              (selectedTab == 0 ? 'Thumb' : 'Face') +
                              " to Login App")
                      .then((value1) {
                    print('value received after anuthenticate');
                    print(value1);
                    if (value1 != "True") {}
                    if (value1 ==
                        "Please Enroll your biomatrics form setting to continue.")
                      Navigator.pushReplacementNamed(
                          context, MyHomePage.routeName);
                  });
                }
              });
            }),
      ),
    );
  }

  Widget builldSlidecntent({required BuildContext context}) {
    Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
        animation: _controller.view,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: spacer(),
              ),
              SizedBox(
                height: 60.h,
              ),
              Flexible(
                fit: FlexFit.tight,
                // flex: 03,
                child: Container(
                  // height: size.height.h * 0.33,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        animateleft.value * size.height / 2, 0.0, 0.0),
                    child: Image.asset(
                      "assets/svg/splashtitle.png",
                      width: size.width.h * 0.50,
                    ),
                    // Text(
                  
                    //   style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: "Hussar Nova",
                    //       color: Colors.white,
                    //       fontSize: 16.0.sp),
                    // )
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Flexible(
                fit: FlexFit.tight,
                // flex: 05,
                child: Transform(
                  transform: Matrix4.translationValues(
                      animateright.value * size.height / 2, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 25.h),
                    // height: size.height.h * 0.34,
                    // width: size.height.h * 0.34,
                    child: Image.asset(
                      "assets/svg/splashlogo.png",
                      width: size.height.h * 0.34,
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: spacer(),
              ),
              Flexible(
                fit: FlexFit.tight,
                // flex: 04,
                child: Container(
                  // height: size.height * 0.33,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, animateup.value * size.height / 2, 0.0),
                    child: AnimatedBuilder(
                        animation: _repeatcontroller.view,
                        builder: (context, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      0.0, animateuprepeat.value * 10, 0.0),
                                  child: Container(
                                    height: 32.h,
                                    width: 32.h,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Color(0xffFFFFFF),
                                          Color(0xffFFFFFF),
                                          // Color.fromARGB(255, 128, 36, 121),
                                          // Color(0xffAC30A3),
                                        ]),
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.arrow_upward,
                                        color: Color(0xff1164AA)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              Transform(
                                transform: Matrix4.translationValues(
                                    0.0, _intervaltween.value * 10, 0.0),
                                child: FittedBox(
                                  child: Text(
                                    "Swipe up to Login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: spacer(),
              ),
            ],
          );
        });
  }

  SizedBox spacer({double? size}) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size ?? height / 5.4,
    );
  }

  // _showModalBottomSheet({required BuildContext context}) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) {
  //       Size size = MediaQuery.of(context).size;
  //       return Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             SizedBox(
  //               height: 05,
  //             ),
  //             Flexible(
  //               child: Container(
  //                 height: size.height * 0.35,
  //                 child: AuthenticationTab(),
  //               ),
  //             ),
  //             SizedBox(height: 14),
  //             Container(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(14.0),
  //                 child: Image.asset(
  //                   "assets/images/fin_print.png",
  //                   // height: 10,
  //                   // width: 10,
  //                 ),
  //               ),
  //               width: 65,
  //               height: 70,
  //               decoration: BoxDecoration(
  //                 color: Color(0xFF929497),
  //                 borderRadius: BorderRadius.circular(17),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

//
}

class SlideableWidget extends StatefulWidget {
  const SlideableWidget({required this.onSlided, this.child, Key? key})
      : super(key: key);

  final VoidCallback onSlided;
  final Widget? child;

  @override
  State<SlideableWidget> createState() => _SlideableWidgetState();
}

class _SlideableWidgetState extends State<SlideableWidget>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 1500);
  late AnimationController _controller, _repeatcontroller;
  late Animation<Size> growAnimation;
  late Animation<Offset> offset;
  late Animation<double> animateup, animateuprepeat;

  @override
  void initState() {
    //controller repeat
    _repeatcontroller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    animateuprepeat = Tween<double>(begin: 0.3, end: 0.7).animate(
        CurvedAnimation(
            parent: _repeatcontroller, curve: Curves.easeInOutExpo));

    _controller = AnimationController(vsync: this, duration: _duration);
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(_controller);
    animateup = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));

    // _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _repeatcontroller.dispose();

    super.dispose();
  }

  double _dragExtent = 0;
  Size size = Size(0, 0);

  bool isSlideup = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onVerticalDragStart: onDragStart,
      onVerticalDragUpdate: onDragUpdate,
      onVerticalDragEnd: onDragEnd,
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.transparent,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Visibility(
                visible: isSlideup,
                child: isSlideup
                    ? SlideTransition(
                        position: AlwaysStoppedAnimation(
                          Offset(0.0, -_controller.value),
                        ),
                        child: widget.child,
                      )
                    : Container(),
              );
            }),
      ),
    );
  }

  onDragStart(DragStartDetails details) {
    setState(() {
      size = context.size!;
      _dragExtent = 0;
      _controller.reset();
    });
  }

  onDragUpdate(DragUpdateDetails details) {
    _dragExtent += details.primaryDelta!;
    if (_dragExtent >= 0) {
      return;
    }

    setState(() {
      _controller.value = _dragExtent.abs() / context.size!.width;
    });
  }

  onDragEnd(DragEndDetails details) {
    if (_controller.value > 0.1) {
      setState(() {
        isSlideup = !isSlideup;
      });
      widget.onSlided();
    }
    _controller.fling(velocity: -1);
  }
}

class AuthenticationTab extends StatefulWidget {
  const AuthenticationTab({
    Key? key,
  }) : super(key: key);
  @override
  State<AuthenticationTab> createState() => _AuthenticationTabState();
}

class _AuthenticationTabState extends State<AuthenticationTab>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  @override
  void initState() {
    _tabController =
        TabController(length: _tabs.length, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List _tabs = ["Finger Print", "Face"];
  String FaceResponse = "";
  String ThumbResponse = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 02,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 16),
              child: Container(
                height: 30.h,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TabBar(
                    controller: _tabController,
                    // padding: EdgeInsets.symmetric(horizontal: 30),
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorWeight: 0.1,
                    onTap: (selectedTab) {
                      SessionData().getTouchID().then((value) {
                        if (value == false) {
                          Navigator.pushReplacementNamed(
                              context, MyHomePage.routeName);
                        } else {
                          AuthenticationService(ctx: context)
                              .authenticateUser(
                                  path: 'splash',
                                  type: selectedTab == 0 ? 'thumb' : 'face',
                                  message: "Scan your " +
                                      (selectedTab == 0 ? 'Thumb' : 'Face') +
                                      " to Login App")
                              .then((value) {
                            ThumbResponse = "";
                            FaceResponse = "";
                            // if (selectedTab == 0) {
                            //   setState(() {
                            //     FaceResponse = value;
                            //     ThumbResponse = "";
                            //   });
                            // } else {
                            //   setState(() {
                            //     ThumbResponse = value;
                            //     FaceResponse = "";
                            //   });
                            // }
                          });
                        }
                      });
                    },
                    tabs: [
                      for (int i = 0; i < _tabs.length; i++)
                        Container(
                          width: size.width * 0.4,
                          alignment: Alignment.center,
                          child: Text(
                            _tabs[i],
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: _selectedIndex == i
                                          ? Colors.white.withOpacity(1)
                                          : Colors.black.withOpacity(0.6),
                                    ),
                          ),
                          decoration: BoxDecoration(
                            gradient: _selectedIndex == i
                                ? LinearGradient(colors: [
                                    Color(0xFF8DF098),
                                    Color(0xFF2CA6FF),
                                  ])
                                : LinearGradient(colors: [
                                    Colors.white,
                                    Colors.white,
                                  ]),
                            borderRadius: BorderRadius.circular(36),
                          ),
                        ),
                    ]),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 14),
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Finger Authentication",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 05),
                      Text(
                        "Please login to get Access",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(height: 05),
                      Text(
                        "Scan your Finger Print",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        // height: size.height / 11.5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SmallRadiusButton(
                              text: "Cancel",
                              width: 115,
                              height: 25,
                              textcolor: Colors.purple,
                              color: [Colors.white, Colors.white],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        (FaceResponse == "NotSupported"
                            ? "Face not supported."
                            : "Face Authentication"),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 05),
                      Text(
                        (FaceResponse == "NotSupported"
                            ? "Your device does not support face ID."
                            : "Please login to get access."),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(height: 05),
                      Text(
                        (FaceResponse == "NotSupported"
                            ? ""
                            : "Scan your Face"),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        // height: size.height / 11.5,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SmallRadiusButton(
                              text: "Cancel",
                              width: 115,
                              height: 25,
                              textcolor: Colors.purple,
                              color: [Colors.white, Colors.white],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

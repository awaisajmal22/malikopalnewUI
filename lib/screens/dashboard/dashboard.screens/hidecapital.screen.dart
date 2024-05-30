import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malikopal/ScopedModelWrapper.dart';
import 'package:malikopal/model/DashboardResponse_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/networking/Endpoints.dart';
import 'package:malikopal/screens/autorollerover/auto_rollover_status.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/closingPayment.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/rollover.screen.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/withdrawbotttomsheet.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/back_alert.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/utils/utility.dart';
import '../custom.widgets/custom_widgets.dart';
import 'notifications.dart';

class HideCapitalView extends StatefulWidget {
  HideCapitalView({Key? key, this.isLogin = false}) : super(key: key);
  static const routeName = '/hidecapital-view';
  final bool isLogin;

  @override
  State<HideCapitalView> createState() => _HideCapitalViewState();
}

class _HideCapitalViewState extends State<HideCapitalView>
    with TickerProviderStateMixin {
  //

  final _duration = Duration(milliseconds: 500);

  final _d2 = Duration(milliseconds: 3500);

  late AnimationController _animController, _animationController;

  late AnimationController _revController;
  late Animation<double> _animleft, _revanimleft;
  late Animation<double> _opacity, _revopacity;

  late Image imagefromPref;

  // bool showIcon = false;

  loadImageFromPref() {
    SessionData().Loadimage().then((img) {
      setState(() {
        imagefromPref = SessionData().imagefrombase64String(img);
        CircleAvatar(
          radius: 40,
          child: imagefromPref,
        );
      });
    });
  }

  UpdateAniamtion() {
    setState(() {
      //

      _animController = AnimationController(vsync: this, duration: _duration);

      _opacity = Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeIn));
      _animleft = Tween<double>(begin: -0.6, end: 0.0).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeIn));

      _animController.forward();
    });
  }

  reverseAniamtion() {
    //

    _revController = AnimationController(vsync: this, duration: _duration);

    _revopacity = Tween<double>(begin: 0.5, end: 0.0)
        .animate(CurvedAnimation(parent: _revController, curve: Curves.easeIn));
    _revanimleft = Tween<double>(begin: 0.0, end: -1.0)
        .animate(CurvedAnimation(parent: _revController, curve: Curves.easeIn));

    _revController.forward();

    setState(() {});
  }

  late DashBoardBloc _bloc;

  DashboardResponseDataModel? data;

  bool isShowCapital = false;

  bool firstload = true;

  @override
  void initState() {
    _bloc = DashBoardBloc();

    _bloc.dashboardResponseStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        setState(() {
          data = event.data;
          if (!firstload) isShowCapital = !isShowCapital;
          firstload = false;
        });

        print('from hide capital');

        // print(data?.toJson());

        SessionData().setUserProfile(data);
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();

        //

        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showIndicator();
      }
    });

    _bloc.getDashboardData();

    _animController = AnimationController(vsync: this, duration: _duration);

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _animationController.repeat(reverse: true);

    //_animController.reverse();
    _animController.forward();
    loadImageFromPref();

    UpdateAniamtion();
    reverseAniamtion();
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    _revController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool isGlowOn = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppModel model = ScopedModel.of<AppModel>(context);

    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavBar(),
      body: WillPopScope(
        onWillPop: () async {
          OnBackToLogout().Logout(
            ctx: context,
            title: "Confirmation Dialog",
            content: "Do You Want to Logout?",
          );
          return true;
        },
        child: AnimatedBuilder(
          animation: _animController.view,
          builder: (context, child) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 50.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Flexible(
                    //     flex: 6,
                    //     child: Container(
                    //         child: AnimatedTopBarTile(
                    //             notificationCount:
                    //                 data?.NotificationCount ?? 0))),
                    Flexible(
                      flex: 04,
                      child: Container(
                        // height: size.height * 0.14,
                        child: Padding(
                          padding: EdgeInsets.only(top: 06.0.h),
                          child: AnimatedTitle(
                              data: data,
                              trailing: AnimatedOpacity(
                                duration: _duration,
                                opacity: 1, //_opacity.value,
                                child: SizedBox(
                                  width: 150.w,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 60.h,
                                          height: 60.h,
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(

                                              // color: Color(0xFFAAA7A7),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Color(0xff1F5FA2))),
                                          child: Visibility(
                                              visible: true, // isShowCapital,
                                              child: FittedBox(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        NotificationView
                                                            .routeName);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 60.h,
                                                    backgroundColor:
                                                        Color(0xffD0D8F5),
                                                    child: Image.asset(
                                                      "assets/images/notification.png",
                                                      height: 50.h,
                                                      width: 50.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Positioned(
                                        right: 40,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 80.h,
                                          height: 80.h,
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                              // color: Color(0xFFAAA7A7),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Visibility(
                                              visible: true, // isShowCapital,
                                              child: FittedBox(
                                                child: CircleAvatar(
                                                  radius: 60.h,
                                                  backgroundImage: NetworkImage(
                                                      // Endpoints.profilePicUrl +
                                                      //     (data?.image ?? "")
                                                      data?.image == null
                                                          ? Endpoints
                                                              .noProfilePicUrl
                                                          : (Endpoints
                                                                  .profilePicUrl +
                                                              (data?.image ??
                                                                  ""))),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 20,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 12,
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.25),
                                    )),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isShowCapital = !isShowCapital;
                                          // showIcon = true;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xff272E6D))),
                                        child: Icon(
                                          isShowCapital
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_up,
                                          // Image.asset(
                                          // isShowCapital
                                          //     ? "assets/svg/arrowDown.png"
                                          //     : "assets/svg/arrowUp.png",
                                          // width: MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.25),
                                    )),
                                  ],
                                ),
                                Spacer(
                                  flex: 5,
                                ),
                                AnimatedOpacity(
                                  opacity: isShowCapital ? 1.0 : 0.0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.linear,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding:
                                        EdgeInsets.only(top: 20.h, left: 20.h),
                                    width: 345.w,
                                    height: 180.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.h),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/images/Base.png'))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Capital",
                                          // textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16.sp,
                                              // height: 19.6.h,
                                              color: Colors.white,

                                              //  model.isDarkTheme
                                              //     ? Colors.white
                                              //     : Color(0xff606161),
                                              fontFamily: "Montserrat"),
                                        ),
                                        Spacer(
                                          flex: 10,
                                        ),

                                        capitalAmountWidget(
                                          context,
                                          size,
                                        ),
                                        // Text(
                                        //   "Total ",
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.w400,
                                        //       fontSize: 16.sp,
                                        //       color: model.isDarkTheme
                                        //           ? Colors.white
                                        //           : Color(0xff606161),
                                        //       fontFamily: "Montserrat"),
                                        // ),
                                        // SizedBox(
                                        //   width: 12,
                                        // ),
                                        // SvgPicture.asset(
                                        //   "assets/newassets/homeIson.svg",
                                        //   color: Color(0xff1164AA),
                                        //   width: 50,
                                        //   height: 50,
                                        // ),
                                        // SizedBox(
                                        //   width: 12,
                                        // ),
                                        // Text(
                                        //   "Capital",
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.w400,
                                        //       color: model.isDarkTheme
                                        //           ? Colors.white
                                        //           : Color(0xff606161),
                                        //       fontSize: 16.sp,
                                        //       fontFamily: "Montserrat"),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 4,
                                // ),
                                // AnimatedOpacity(
                                //   opacity: isShowCapital ? 1.0 : 0.0,
                                //   duration: Duration(seconds: 1),
                                //   curve: Curves.linear,
                                //   child: Padding(
                                //     padding:
                                //         EdgeInsets.symmetric(vertical: 10.0.h),
                                //     child: FittedBox(
                                //         child: Container(
                                //             width: size.width.w,
                                //             child:

                                //             capitalAmountWidget(
                                //               context,
                                //               size,
                                //             ))),
                                //   ),
                                // ),
                                Spacer(
                                  flex: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomAnimationsWidgets(
                      isLogin: widget.isLogin,
                      isreverse: !isShowCapital,
                      data: data,
                    ),
                    SizedBox(height: 25)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget capitalAmountWidget(
    BuildContext context,
    Size size,
  ) {
    // double width = MediaQuery.of(context).size.width;
    AppModel model = ScopedModel.of<AppModel>(context);

    return SizedBox(
      height: isTablet() ? 120 : 60,
      child:

          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(bottom: 8.h),
          //       child: Text(
          //         "Rs.\t",
          //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
          //             fontSize: isTablet() ? 25.sp : 18.sp,
          //             fontWeight: FontWeight.w500,
          //             color: model.isDarkTheme ? Colors.white : Color(0xff606161),
          //             fontFamily: "Montserrat"),
          //       ),

          //     ),
          //     Flexible(
          //       child:
          Text(
              Constant.currencyFormatWithoutDecimal
                  .format(data?.totalCapital ?? 0),
              maxLines: 2,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Manrope",
                    color: Colors.white,
                  )

              //  model.isDarkTheme ? Colors.white : Colors.black),
              ),

      //     ),
      //   ],
      // ),
    );
  }
}

class CustomAnimationsWidgets extends StatefulWidget {
  CustomAnimationsWidgets(
      {Key? key, this.data, required this.isreverse, required this.isLogin})
      : super(key: key);
  final DashboardResponseDataModel? data;
  final bool isLogin;
  final bool isreverse;
  @override
  State<CustomAnimationsWidgets> createState() =>
      _CustomAnimationsWidgetsState(data);
}

class _CustomAnimationsWidgetsState extends State<CustomAnimationsWidgets>
    with TickerProviderStateMixin {
  _CustomAnimationsWidgetsState(this.data);
  DashboardResponseDataModel? data;
  final _duration = Duration(milliseconds: 1500);
  late AnimationController _animController, _revController;
  late Animation<double> _opacity; //, _revopacity;

  UpdateAniamtion() {
    setState(() {
      _animController = AnimationController(vsync: this, duration: _duration);

      _opacity = Tween<double>(begin: 0.5, end: 1.0).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeIn));

      _animController.forward();
    });
  }

  reverseAniamtion() {
    setState(() {
      _revController = AnimationController(vsync: this, duration: _duration);

      //_revopacity = Tween<double>(begin: 0.5, end: 0.0).animate(
      //        CurvedAnimation(parent: _revController, curve: Curves.easeIn));
//
      _revController.forward();
    });
  }

  @override
  void initState() {
    UpdateAniamtion();
    reverseAniamtion();
    print(data?.toJson());
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    _revController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animController.view,
        builder: (context, child) {
          return SizedBox(
            width: width,
            height: isTablet() ? 135 : 125,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child:
                        closingPaymentWidget(context, isLogin: widget.isLogin)),
                Expanded(child: rolloverWidget(width, context)),
                Expanded(child: autoRollOver(width, context)),
                Expanded(child: withdrawWidget(width, context)),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          );
        });
  }

  Widget rolloverWidget(double width, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              duration: Duration(milliseconds: 300),
              child: RollOverView()),
        );
      },
      child: NewMenuButton(
          asssetsName: "assets/newassets/all_rollover.svg",
          text: "All\n Rollover",
          // bgColor: Color(0xff912C8C)
          bgColor: Color(0xffE3E7F7)),
    );
  }

  Widget closingPaymentWidget(BuildContext context, {required bool isLogin}) {
    //
    return isLogin == true
        ? AnimatedOpacity(
            duration: _duration,
            opacity: _opacity.value,
            child: GestureDetector(
              onTap: () {
                print("Pressesed.. Go to Transection Screen");
                // Navigator.of(context)
                //     .popUntil(ModalRoute.withName(HideCapitalView.routeName));
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 300),
                    child: ClosingPaymentView(),
                  ),
                );

                //
              },
              child: NewMenuButton(
                  asssetsName: "assets/newassets/closing_payment.svg",
                  text: "Closing \n Payment",
                  bgColor: widget.data?.isClosingDays == true
                      ? Color(0xffF27224)
                      : Color(0xffE3E7F7)
                  // Color(0xff912C8C)
                  ),
            ),
          )
        : GestureDetector(
            onTap: () {
              print("Pressesed.. Go to Transection Screen");
              // Navigator.of(context)
              //     .popUntil(ModalRoute.withName(HideCapitalView.routeName));
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  duration: Duration(milliseconds: 300),
                  child: ClosingPaymentView(),
                ),
              );

              //
            },
            child: NewMenuButton(
                asssetsName: "assets/newassets/closing_payment.svg",
                text: "Closing \n Payment",
                bgColor: widget.data?.isClosingDays == true
                    ? Color(0xffF27224)
                    : Color(0xffE3E7F7)
                // Color(0xff912C8C)
                ),
          );
  }

  Widget autoRollOver(double width, BuildContext context) {
    return NewMenuButton(
      onPress: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              duration: Duration(milliseconds: 300),
              child: AutoRollOverStatus()),
        );
      },
      asssetsName: "assets/newassets/auto_roller_over.svg",
      // bgColor: Color(0xff912C8C),
      bgColor: Color(0xffE3E7F7),
      text: 'Auto \n Rollover',
    );
  }

  Widget withdrawWidget(double width, BuildContext context) {
    return NewMenuButton(
        onPress: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 300),
                child: WithDrawalHoverLayerView()),
          );
        },
        asssetsName: "assets/newassets/capital_width.svg",
        text: "Withdraw\n Capital",
        // bgColor: Color(0xff912C8C)
        bgColor: Color(0xffE3E7F7));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:malikopal/ScopedModelWrapper.dart';
import 'package:malikopal/model/requestbody/ReceivePaymentReqBody_model.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/alerts.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/transection_sheet.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/utility.dart';
import '../../../model/rollerover_status_model.dart';
import '../custom.widgets/custom_widgets.dart';

class RollOverView extends StatefulWidget {
  const RollOverView({Key? key}) : super(key: key);
  static const routeName = '/rollover-view';

  @override
  State<RollOverView> createState() => _RollOverViewState();
}

class _RollOverViewState extends State<RollOverView> {
  @override
  void initState() {
    //  ScaffoldMessenger.of(context).hideCurrentSnackBar();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        // bottomNavigationBar: widgets.bottombar(context: context),
        // backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: () async {
            ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                .hideCurrentSnackBar();
            return Future.value(true);
          },
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Flexible(flex: 01, child: CustomTopBar(topbartitle: "")),
                  Flexible(flex: 09, child: RollOverBottomSheet())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//bottom sheet
class RollOverBottomSheet extends StatefulWidget {
  const RollOverBottomSheet({Key? key}) : super(key: key);
  @override
  State<RollOverBottomSheet> createState() => _RollOverBottomSheetState();
}

class _RollOverBottomSheetState extends State<RollOverBottomSheet>
    with TickerProviderStateMixin {
  //

  final _duration = Duration(milliseconds: 800);

  late AnimationController _animationcontroller;

  late Animation<double> _animateopacity;

  late Animation<double> _animateleft, _animatebottom;

  bool loaded = false;

  late TextEditingController _rolloveramounttextcontroller;

  // late DashboardBloc _bloc;

  // ClosingPaymentResponseData? data;
  // DashboardResponseData Userdata =
  //     DashboardResponseData(IsRefrenceInAllowed: false);

  RollerOverStatusModel? data;

  DashboardRepository dashboardRepository = DashboardRepository();

  getRolloverStatus() {
    // DialogBuilder(context).showLoader();

    dashboardRepository.getRollerOverStatus().then((event) {
      // DialogBuilder(context).hideLoader();

      setState(() {
        data = event;
        print(data?.toJson());
      });

      if ((data?.data?.status ?? false)) {
        _rolloveramounttextcontroller.text =
            data!.data!.closingPayment?.toInt().toString() ?? '';
        setState(() {
          loaded = true;
        });
      } else if (!(data?.data?.status ?? true) &&
          data?.data?.rolloverRequest?.status == null) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom,
                duration: Duration(milliseconds: 300),
                child: RolloverPaymentAlert(
                    title: "Rollover Closed!",
                    message: "Rollover request window\nhas been closed!")));
      } else if (data?.data?.rolloverRequest != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RollOverTransectionSheet(
                    message: event.message ?? '',
                    DateStr:
                        data!.data!.rolloverRequest?.requestDate.toString(),
                    title:
                        'Rollover request is in ${data!.data!.rolloverRequest!.status}',
                    // "Your previous rollover request is  ${data!.data!.rolloverRequest!.status}",
                    response: data!.data!.rolloverRequest!,
                    closing: data!.data!.closingPayment)));
      } else {
        // DialogBuilder(context).hideLoader();
        //showSnackBar(context, event.message, true);

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom,
                duration: Duration(milliseconds: 300),
                child: RolloverPaymentAlert(
                    title: "Rollover Error!", message: event.message)));
        setState(() {
          loaded = true;
        });
      }
    }).catchError((e) {
      // DialogBuilder(context).hideLoader();
      dp(msg: "Errro", arg: e);

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              duration: Duration(milliseconds: 300),
              child: RolloverPaymentAlert(
                  title: "Rollover Error!",
                  message: "Error please try again")));
    });
  }

  @override
  void initState() {
    getRolloverStatus();
    // loaded = true;

    _rolloveramounttextcontroller = TextEditingController();

    _rolloveramounttextcontroller.addListener(getLatestvalue);

    _animationcontroller =
        AnimationController(vsync: this, duration: _duration);

    _animateopacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationcontroller, curve: Curves.fastOutSlowIn));
    _animateleft = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationcontroller, curve: Curves.fastOutSlowIn));

    _animatebottom = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _animationcontroller, curve: Curves.fastOutSlowIn));
    _animationcontroller.forward();

    super.initState();
  }

  getLatestvalue() {
    setState(() {
      //_rollover_amount = data?.ClosingPayment ?? 0.0;
    });
  }

  @override
  void dispose() {
    // _rolloveramounttextcontroller.dispose();
    _animationcontroller.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (loaded == true)
          CustomTopBar(
            topbartitle: 'All Rollover',
            backButtonColor:
                isDarkThemeEnabled(context) ? Colors.white : Colors.black,
          ),
        AnimatedBuilder(
            animation: _animationcontroller.view,
            builder: (context, _) {
              if (!loaded)
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()),
                );
              return Transform(
                transform: Matrix4.translationValues(
                    0.0, _animatebottom.value * width, 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    height: height * 0.55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffACBBF3),
                          Color(0xffACBBF3),
                          // Color(0xff1164AA),
                          //  Color(0xff1164AA)
                          // Color(0xff1164AA),
                          // Color(0xff1164AA)
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        // Divider(
                        //   height: 4,
                        //   color: Colors.white,
                        //   endIndent: 150.w,
                        //   indent: 150.w,
                        //   thickness: 3.5,
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              0.0, _animateleft.value * width, 0.0),
                          child: AnimatedOpacity(
                            duration: _duration,
                            opacity: _animateopacity.value,
                            child: Text("All Rollover",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 18.sp,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )
                                // Color(0xFFFFF100)),
                                ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(
                                    0.0, _animateleft.value * width, 0.0),
                                child: AnimatedOpacity(
                                  duration: _duration,
                                  opacity: _animateopacity.value,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Rs.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                              fontSize: 20.sp,
                                              height: 2.0.h,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                      ),
                                      Text(
                                        Constant.currencyFormatWithoutDecimal
                                            .format(
                                                data?.data?.closingPayment ??
                                                    0),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontSize: 36.sp,
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 08.0.h),
                                    child: Transform(
                                      transform: Matrix4.translationValues(
                                          _animateleft.value * width, 0.0, 0.0),
                                      child: AnimatedOpacity(
                                        duration: _duration,
                                        opacity: _animateopacity.value,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  height: 22.h,
                                                  width: 22.w,
                                                  child: Image.asset(
                                                    "assets/images/amount.png",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 08.w,
                                              ),
                                              Text(
                                                "Amount",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 20.sp,
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      // .withOpacity(0.8),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 04.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 23.h, right: 23.h),
                                    child: AmountInputField(
                                      Prefixtext: "Rs",
                                      isBgColorWhite: true,
                                      isenable: false,
                                      textcontroller:
                                          _rolloveramounttextcontroller,
                                      hint: data?.data?.rolloverRequest?.amount
                                              .toString() ??
                                          "0.0",
                                      fontsize: 25.sp,
                                      textColor: Colors.black,
                                      color: [Colors.white, Colors.white],
                                    ),
                                  ),
                                ],
                              ),
                              isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : AnimatedLongButton(
                                      // GestureDetector(
                                      onPressed: () {
                                        if (_rolloveramounttextcontroller
                                            .text.isEmpty) {
                                          showSnackBar(
                                              context,
                                              'Please enter a valid number.',
                                              true);
                                          return;
                                        }
                                        // var isValid = Fzregex.hasMatch(
                                        //     _rolloveramounttextcontroller.text,
                                        //     FzPattern.numericOnly);

                                        // dp(msg: "isValid");

                                        // if (!isValid) {
                                        //   showSnackBar(context,
                                        //       'Please enter a valid number.', true);
                                        //   return;
                                        // }

                                        if (_rolloveramounttextcontroller
                                                .text.isEmpty &&
                                            double.tryParse(
                                                    _rolloveramounttextcontroller
                                                        .text)!
                                                .isNegative) {
                                          //

                                          showSnackBar(
                                              context,
                                              'Rollover amount must be a valid digit.',
                                              true);
                                          return;
                                        }
                                        var reqdata = ReceivePaymentReqDataModel(
                                            transferAmount: 0,
                                            rolloverAmount: int.parse(
                                                _rolloveramounttextcontroller
                                                    .text));

                                        if (reqdata.rolloverAmount == 0.0 ||
                                            reqdata.rolloverAmount?.isFinite ==
                                                false) {
                                          showSnackBar(
                                              context,
                                              'Rollover amount must be a valid digit.',
                                              true);
                                          return;
                                        }
                                        reqdata.source = AppModel().deviceID();

                                        ReceivePaymentReqBodyModel reqBody =
                                            ReceivePaymentReqBodyModel(
                                                data: reqdata);

                                        // _bloc.SaveRollover(reqdata);

                                        setState(() {
                                          isLoading = true;
                                        });

                                        dashboardRepository
                                                .SavePaymentRolloverAll(reqBody)
                                            .then((value) {
                                          setState(() {
                                            isLoading = false;
                                          });

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RollOverTransectionSheet(
                                                        message: value.message,
                                                        DateStr: DateTime.now()
                                                            .toString(),
                                                        closing: data?.data
                                                                ?.closingPayment ??
                                                            0,
                                                        response: value.data
                                                            ?.rolloverRequest,
                                                        title:
                                                            // "Your Payment Request has accepted"
                                                            "Rollover request is in ${data?.data?.rolloverRequest?.status ?? ''}")),
                                            //  "Your previous rollover request is in ${data?.data?.rolloverRequest?.status ?? ''}")),
                                          );

                                          //
                                        }).then((value) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      },
                                      // child: AnimatedLongButton(
                                      text: "Send".toUpperCase(),
                                      textColor: Colors.white,
                                      isBgColorWhite: true,
                                      color: [
                                        Color(0xff1F5FA2),
                                        Color(0xff272E6D)
                                      ],
                                    ),
                              // ),
                              // AnimatedBottomBar()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }

  RollOverTransectionSheet(
      {required String message,
      String? title,
      RolloverRequest? response,
      DateStr,
      num? closing}) {
    return TransactionDetailWidget(
      // userID: Userdata.UserName,
      // date: DateTime.now().toString(),
      DateStr: DateStr ?? "",
      description1: 'Once the request is accepted, the Rollover ',
      // description2: 'Bank Account ',
      description3: 'Amount will be added to your Capital.',
      urduDescription1: 'assets/svg/ic_urdu_3.svg',
      Title: title ?? 'Your Payment request has accepted',
      // "Rollover Request has been Processed",
      amountTitle: "Rollover Amount",
      paymentTypekey: "Closing Payment",
      amountTypevalue:
          Constant.currencyFormatWithoutDecimal.format(response?.amount ?? 0),
      paymentTypevalue:
          Constant.currencyFormatWithoutDecimal.format(closing ?? 0),
      // _rollover_amount.toString(),

      // amountTypevalue:
      //     Const.currencyFormatWithoutDecimal.format(closing ?? 0),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HideCapitalView(),
          ),
        );
      },
      color2: Color(0xff1F5FA2),
      //  Color(0xff1164AA),
      color1: Color(0xff272E6D),
      //  Color(0xff1164AA)
    );
  }
}

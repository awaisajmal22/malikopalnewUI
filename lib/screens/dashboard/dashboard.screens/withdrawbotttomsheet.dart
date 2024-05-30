import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:intl/intl.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:malikopal/ScopedModelWrapper.dart';

import 'package:malikopal/model/WithdrawResponse_model.dart';
import 'package:malikopal/model/requestbody/WithdrawReqBody_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/utility.dart';
import '../../../model/widthfrawdata_model.dart';
import '../../../repositories/dashboard_repo.dart';
import 'alerts.dart';
import 'transection_sheet.dart';

class WithDrawalHoverLayerView extends StatefulWidget {
  WithDrawalHoverLayerView({Key? key}) : super(key: key);
  static const routeName = '/withdraw-view';

  @override
  State<WithDrawalHoverLayerView> createState() =>
      _WithDrawalHoverLayerViewState();
}

class _WithDrawalHoverLayerViewState extends State<WithDrawalHoverLayerView> {
  @override
  void initState() {
    dp(msg: "call widthdraw ");
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   WithDrawBottomSheet();
    // });
  }

  FocusNode focusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(_scaffoldKey.currentContext!)
              .hideCurrentSnackBar();
          return Future.value(true);
        },
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flexible(flex: 01, child: CustomTopBar(topbartitle: "")),
                Flexible(
                  flex: 09,
                  child: KeyboardVisibilityBuilder(builder: (context, visible) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: visible ? 200 : 0.0.h),
                      child: WithDrawBottomSheet(),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WithDrawBottomSheet extends StatefulWidget {
  const WithDrawBottomSheet({Key? key}) : super(key: key);

  @override
  State<WithDrawBottomSheet> createState() => _WithDrawBottomSheetState();
}

class _WithDrawBottomSheetState extends State<WithDrawBottomSheet>
    with SingleTickerProviderStateMixin {
  //

  final _duration = Duration(milliseconds: 800);

  late AnimationController _animationController;

  late Animation _animatebottom, _opacity;

  late TextEditingController _withdrawamounttextcontroller;

  late DashBoardBloc _bloc;

  WidthDrawStatusModel? data;
  DashboardRepository repository = DashboardRepository();

  bool isLoading = true;

  var isLoadinData = false;

  getStatus() async {
    dp(msg: "Data status call");
    try {
      var data = await repository.getWidrawStatus();

      dp(msg: "message", arg: data?.toJson());

      if (data != null) {
        // DialogBuilder(context).hideLoader();

        this.data = data;

        setState(() {
          isLoading = false;
        });

        if (data.data?.status ?? false) {
          setState(() {
            loaded = true;
          });
        } else if (!(data.data?.status ?? false) &&
            data.data?.withdrawRequest == null) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.topToBottom,
              duration: Duration(milliseconds: 300),
              child: CapitalWithDrawPendingDateAlert(
                title: "WITHDRAW STATUS",
                message:
                    "Capital withdrawal\nrequest can be submitted\nduring the closing period on\n9",
                daterich: "th",
                description2: " till midnight.",
              ),
            ),
          );
        } else if (data.data?.withdrawRequest != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WithDrawTransectionSheet(
                  message: data.message ?? '',
                  DateStr: data.data?.withdrawRequest?.requestDate.toString(),
                  amountTitle: "Withdraw Amount",
                  title: 'WITHDRAWAL RECEIPT',
                  urduDescription1: 'assets/svg/ic_urdu_1.svg',
                  description2: 'Bank Account',
                  description1:
                      'The withdrawal amount, will be deposited into your ',
                  description3: ' in the upcoming closing period.',
                  // "Your previous withdraw request is ${data.data!.withdrawRequest!.status}",
                  response: data.data!.withdrawRequest!,
                  capitalAmount: data.data?.capitalAmount),
            ),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });

        // DialogBuilder(context).hideLoader();
        //showSnackBar(context, event.message, true);

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom,
                duration: Duration(milliseconds: 300),
                child: WithDrawPaymentAlert(
                    title: "Withdraw Error!",
                    message: "Error please try again")));
      }
    } catch (e) {
      dp(msg: "Error in ", arg: e.runtimeType);
      // DialogBuilder(context).hideLoader();
      //showSnackBar(context, event.message, true);

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              duration: Duration(milliseconds: 300),
              child: WithDrawPaymentAlert(
                  title: "Withdraw Error!",
                  message: "Error please try again")));
    }
  }

  @override
  void initState() {
    getStatus();
    // loaded = true;

    _withdrawamounttextcontroller = TextEditingController();

    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _animatebottom = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Curves.fastLinearToSlowEaseIn));

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    // _bloc.dispose();

    _withdrawamounttextcontroller.dispose();

    _animationController.dispose();
    super.dispose();
  }

  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("height is : " + height.toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (loaded == true)
          CustomTopBar(
            topbartitle: 'Total Captital',
            backButtonColor:
                isDarkThemeEnabled(context) ? Colors.white : Colors.black,
          ),
        AnimatedBuilder(
          animation: _animationController.view,
          builder: (context, child) {
            if (!loaded)
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              );

            return Transform(
              // alignment: Alignment.bottomCenter,
              transform: Matrix4.translationValues(
                  0.0, _animatebottom.value * width, 0.0),
              child: Padding(
                padding: EdgeInsets.only(bottom: 0, left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffACBBF3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28))),
                  //  Color(0xff1164AA),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(28.0),
                  // ),
                  // height: height * 0.65,
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topRight,
                  //     end: Alignment.bottomLeft,
                  //     colors: [Color(0xff1164AA), Color(0xff1164AA)],
                  //   ),
                  //   borderRadius: BorderRadius.circular(28),
                  // ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 47.h, left: 20.h, right: 20.h, bottom: 92.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // SizedBox(
                        //   height: 50.h,
                        // ),
                        // Divider(
                        //   height: 4,
                        //   color: Colors.white,
                        //   endIndent: 150.w,
                        //   indent: 150.w,
                        //   thickness: 4.h,
                        // ),
                        // SizedBox(
                        //   height: 15.h,
                        // ),
                        AnimatedOpacity(
                          duration: _duration,
                          opacity: _opacity.value,
                          child: Text(
                            "TOTAL CAPITAL",
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 18.5.sp,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      // Color(0xFFFFF100),
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 37.h,
                        ),
                        AnimatedOpacity(
                          duration: _duration,
                          opacity: _opacity.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 2.5.h),
                                child: Text(
                                  "Rs.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        // height: 2.0.h,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat",
                                        color: Colors.black,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              Text(
                                Constant.currencyFormatWithoutDecimal
                                    .format(data?.data?.capitalAmount ?? 0),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 29.5.sp,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 47.h,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 08.h, left: 28.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: 23.h,
                                      child: Image.asset(
                                        "assets/images/amount.png",
                                        color: Colors.black,
                                        // color: Colors.white.withOpacity(0.85),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 9.5.h,
                                  ),
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.8.sp,
                                      fontFamily: "Montserrat",
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AmountInputField(
                              borderRadius: 19,
                              isBgColorWhite: true,
                              textcontroller: _withdrawamounttextcontroller,
                              color: [Colors.white, Colors.white],
                              hint: " 20,000,000",
                              Prefixtext: 'Rs.',

                              // prefix: true,
                              //  data?.TotalCapital.toString() ?? "0",
                              fontsize: 26.sp,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        isLoadinData
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            :
                            //  GestureDetector(
                            // onTap:
                            // child:
                            Padding(
                                padding: EdgeInsets.all(0),
                                child: AnimatedLongButton(
                                  onPressed: () {
                                    if (_withdrawamounttextcontroller
                                        .text.isEmpty) {
                                      showSnackBar(context,
                                          'Please enter a valid number.', true);
                                      return;
                                    }
                                    var isValid = Fzregex.hasMatch(
                                        _withdrawamounttextcontroller.text,
                                        FzPattern.currency);

                                    dp(msg: "IValid", arg: isValid);
                                    if (!isValid) {
                                      showSnackBar(context,
                                          'Please enter a valid number.', true);
                                      return;
                                    }

                                    String source = AppModel().deviceID();

                                    double totalamount =
                                        data?.data?.capitalAmount?.toDouble() ??
                                            0.0;

                                    var amount =
                                        _withdrawamounttextcontroller.text;

                                    if (source == "" ||
                                        double.tryParse(amount)?.isFinite ==
                                            false ||
                                        (double.tryParse(amount)?.isNegative ??
                                            true)) {
                                      showSnackBar(
                                          context,
                                          'Withdraw amount must be greater than zero',
                                          true);
                                      return;
                                    } else if (double.parse(amount) >
                                            totalamount ||
                                        amount == '0' ||
                                        totalamount == 0) {
                                      showSnackBar(
                                          context,
                                          'Withdraw amount must be greater than zero',
                                          true);
                                      return;
                                    }

                                    setState(() {
                                      isLoadinData = true;
                                    });

                                    // Navigation.pushName(context,)

                                    var dataa = WithdrawReqDataModel(
                                      withdrawAmount: int.tryParse(amount) ?? 0,
                                      source: AppModel().deviceID(),
                                    );

                                    // _bloc.SaveWithdrawalData(dataa);

                                    WithdrawReqBodyModel reqBody =
                                        WithdrawReqBodyModel(data: dataa);

                                    repository
                                        .withDrawPOst(reqBody)
                                        .then((value) {
                                      setState(() {
                                        isLoadinData = true;
                                      });

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WithDrawTransectionSheet(
                                                  urduDescription1:
                                                      'assets/svg/ic_urdu_1.svg',
                                                  description2: 'Bank Account',
                                                  description1:
                                                      'The withdrawal amount, will be deposited into your ',
                                                  description3:
                                                      ' in the upcoming closing period.',
                                                  amountTitle:
                                                      'Withdraw Amount',
                                                  message: value.message,
                                                  DateStr:
                                                      DateTime.now().toString(),
                                                  title:
                                                      "Your withdraw request is ${value.data!.withdrawRequest!.status}",
                                                  response: value
                                                      .data!.withdrawRequest!,
                                                  capitalAmount: value.data
                                                          ?.capitalAmount ??
                                                      0)));
                                    }).catchError((e) {
                                      setState(() {
                                        isLoadinData = true;
                                      });
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .topToBottom,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: WithDrawPaymentAlert(
                                                  title: "Withdraw Error!",
                                                  message:
                                                      "Please try again")));
                                    });
                                  },

                                  fontWeight: FontWeight.w400,
                                  // textColor: Color(0xFF58595B),
                                  text: "Send Request",
                                  isBgColorWhite: true,
                                  fontsize: 18.5.sp,
                                  borderRadius: 19,
                                  textColor: Colors.white,
                                  // bottomPadding: 6.h,
                                  color: [Color(0xff1F5FA2), Color(0xff272E6D)],
                                ),
                              ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  WithDrawTransectionSheet(
      {required String message,
      String? title,
      DateStr,
      String? description1,
      String? description2,
      String? description3,
      String? urduDescription1,
      String? urduDescription2,
      String? urduDescription3,
      required WithdrawRequest response,
      String? amountTitle,
      num? capitalAmount}) {
    return TransactionDetailWidget(
      // userID: Userdata?.UserName ?? "",
      // date: DateTime.now().toString(),
      DateStr: DateStr.toString(),
      urduDescription1: urduDescription1,
      urduDescription2: urduDescription2,
      urduDescription3: urduDescription3,
      // urduDescription4: 'منتقل کردی جاۓ گی',
      description2: description2,
      description3: description3,
      description1: description1,
      Title: title ?? 'CAPITAL WITHDRAW',
      amountTitle: amountTitle ?? '',
      paymentTypekey: "Capital",
      paymentTypevalue: null,

      // Const.currencyFormatWithoutDecimal.format(capitalAmount ?? 0),
      amountTypevalue: Constant.currencyFormatWithoutDecimal
          .format(response.withdrawAmount ?? 0),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HideCapitalView(),
          ),
        );
      },
      color2: Color(0xff1164AA),
      // Color(0xff1164AA),
      color1: Color(0xff1164AA),
      // Color(0xff1164AA),
    );
  }
}

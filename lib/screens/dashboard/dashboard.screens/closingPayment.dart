import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malikopal/ScopedModelWrapper.dart';
import 'package:malikopal/model/requestbody/ReceivePaymentReqBody_model.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/alerts.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/utility.dart';
import '../../../model/tranfer_rolll_over_model.dart';
import 'transection_sheet.dart';

class ClosingPaymentView extends StatelessWidget {
  ClosingPaymentView({Key? key}) : super(key: key);
  static const routeName = '/closing_payment-view';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(_scaffoldKey.currentContext!)
              .hideCurrentSnackBar();
          return Future.value(true);
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 01, child: CustomTopBar(topbartitle: "")),
                  Flexible(
                    flex: 09,
                    child:
                        KeyboardVisibilityBuilder(builder: (context, visible) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: visible ? 200 : 0.0.h),
                        child: ClosingPaymentBottomSheet(),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClosingPaymentBottomSheet extends StatefulWidget {
  const ClosingPaymentBottomSheet({Key? key}) : super(key: key);

  @override
  State<ClosingPaymentBottomSheet> createState() =>
      _ClosingPaymentBottomSheetState();
}

class _ClosingPaymentBottomSheetState extends State<ClosingPaymentBottomSheet>
    with TickerProviderStateMixin {
  //

  final _duration = Duration(milliseconds: 600);

  late AnimationController _animationcontroller;
  late Animation _animateopacity;
  late Animation<double> _animateleft;

  int total_amount = 0;
  int transfer_amount = 0;
  int rollover_amt = 0;

  bool isLaoding = false;

  late TextEditingController _transfertextcontroller;

  late TextEditingController _rollovertextcontroller;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // late DashboardBloc _bloc;

  TransferRolloverModel? data;

  // DashboardResponseData Userdata =
  //     DashboardResponseData(IsRefrenceInAllowed: false);

  bool loaded = false;

  // var samplejson = {
  //   "Data": {
  //     "Status": true,
  //     "ClosingPayment": 1500,
  //     "RemaingTime": {"Days": 1, "Hours": 12, "Minutes": 30, "Seconds": 45},
  //     "TransferRolloverRequest": {
  //       "ClosingPayment": 1500,
  //       "Transfer": 100,
  //       "Rollover": 50,
  //       "RequestDate": "2023-08-11T14:30:00Z",
  //       "Status": "Pending"
  //     }
  //   },
  //   "Message": "Sample message",
  //   "ErrorList": ["Error 1", "Error 2"]
  // };

  DashboardRepository repository = DashboardRepository();

  getTranferData() {
    repository.getTransferData().then((event) async {
      print(" Data " + jsonEncode(event.data));

      setState(() {
        data = event;
        print(data?.toJson());
      });

      await Future.delayed(Duration(milliseconds: 200));

      if (data?.data?.status ?? false) {
        total_amount = data?.data?.closingPayment?.toInt() ?? 0;
        setState(() {
          loaded = true;
        });
      } else if (!(data?.data?.status ?? false) &&
          data?.data?.transferRolloverRequest == null) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.topToBottom,
            duration: Duration(milliseconds: 300),
            child: ClosingPaymentAlert(
                isClosingOption: true,
                title: "Closing Payment".toUpperCase(),
                message: "Closing Payment request window\nhas been closed!"),
          ),
        );
      } else if (data?.data?.transferRolloverRequest != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => closingTransactionSheet(
                    DateStr: data?.data?.transferRolloverRequest?.requestDate,
                    message: event.message ?? '',
                    title:
                        "Your payment request is ${data?.data?.transferRolloverRequest?.status}",
                    description1: "The funds will be deposited into your ",
                    description2: "Bank Account",
                    description3: " prior to the 10",
                    description4: "of the month",

                    // "Your payment request is ${data?.data?.transferRolloverRequest?.status}",
                    response: data?.data?.transferRolloverRequest)));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 300),
                child: ClosingPaymentAlert(
                    title: "Payment Error", message: "Error in geting data")));
      }
    }).catchError((e) {
      dp(msg: "Error in t", arg: e);

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              duration: Duration(milliseconds: 300),
              child: ClosingPaymentAlert(
                  title: "Payment Error", message: "Error in geting data")));
    });
  }

  @override
  void initState() {
    getTranferData();
    // loaded = true;

    // data = TransferRolloverModel.fromJson(samplejson);

    _transfertextcontroller = TextEditingController();

    _rollovertextcontroller = TextEditingController();

    _animationcontroller =
        AnimationController(vsync: this, duration: _duration);

    _animateopacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationcontroller, curve: Curves.fastOutSlowIn));
    _animateleft = Tween<double>(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationcontroller, curve: Curves.fastOutSlowIn));

    _animationcontroller.forward();

    // _transfertextcontroller.addListener(getLatestvalue);

    // _rollovertextcontroller.addListener(getRollervalue);

    super.initState();
  }

  @override
  void dispose() {
    _animationcontroller.dispose();
    _transfertextcontroller.dispose();
    _rollovertextcontroller.dispose();
    super.dispose();
  }

  getLatestvalue() {
    setState(() {
      if (_transfertextcontroller.text.isNotEmpty) {
        rollover_amt =
            (total_amount) - (int.tryParse(_transfertextcontroller.text) ?? 0);
        transfer_amount = total_amount - rollover_amt;
        _rollovertextcontroller.clear();
      } else {}
    });
  }

  getRollervalue() {
    setState(() {
      if (_rollovertextcontroller.text.isNotEmpty) {
        transfer_amount =
            (total_amount) - (int.tryParse(_rollovertextcontroller.text) ?? 0);
        rollover_amt = total_amount - transfer_amount;
        _transfertextcontroller.clear();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    // transfer_amount = double.tryParse(_transfertextcontroller.text) ?? 0.0;
    // var rollover_amount = double.tryParse(_rollovertextcontroller.text);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedBuilder(
        key: _scaffoldKey,
        animation: _animationcontroller.view,
        builder: (context, child) {
          if (!loaded)
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            );
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (data?.data?.remainingTime?.formattedTime.toString() != null)
                  ScopedModelDescendant<AppModel>(
                    builder: (context, _, model) {
                      return Column(
                        children: [
                          Text(
                            "Time Remaining for Request",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 16.7.sp,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                  color: isDarkThemeEnabled(context)
                                      ? Colors.white
                                      : Colors.black,
                                  // color: Theme.of(context).dividerColor,
                                ),
                          ),
                          SizedBox(
                            height: 9.5.h,
                          ),
                          Text(
                            "${data?.data?.remainingTime?.formattedTime} hours",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontSize: 33.sp,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                  color: isDarkThemeEnabled(context)
                                      ? Colors.white
                                      : Colors.black,
                                  // model.isDarkTheme
                                  //     ? Colors.white
                                  //     : Color(0xff1164AA),
                                ),
                          ),
                        ],
                      );
                    },
                  ),
                SizedBox(
                  height: 100.h,
                ),
                // Spacer(),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffACBBF3), Color(0xffACBBF3)],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28))
                      // BorderRadius.circular(28),
                      ),
                  child: SingleChildScrollView(
                    // padding: EdgeInsets.all(0),
                    reverse: true,
                    child: Container(
                      // height: size.height * 0.74,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            child: Center(
                              child: Text(
                                "Closing Payment".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 17.5.sp,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      //  Color(0xFFFFF100),
                                    ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: _duration,
                            opacity: _animateopacity.value,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.5.h),
                                  child: Text(
                                    "Rs. ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontSize: 16.sp,
                                          // height: 2.0.h,
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                          //  Colors.white,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Text(
                                  Constant.currencyFormatWithoutDecimal
                                      .format(data?.data?.closingPayment ?? 0),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontSize: 29.5.sp,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        //  Colors.white
                                      ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 23.h, right: 23.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SvgPicture.asset(
                                //   "assets/svg/ic_transfer.svg",
                                //   color: Colors.white,
                                // ),
                                // SizedBox(
                                //   width: 19.h,
                                // ),
                                Text(
                                  "Transfer",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 16.sp,
                                          //fontWeight: FontWeight.normal,
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                          //  Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 9.5.h),
                          Padding(
                            padding: EdgeInsets.only(left: 23.h, right: 23.h),
                            child: AmountInputField(
                              topPadding: 2.5.h, bottomPadding: 2.5.h,
                              borderRadius: 13,
                              isBgColorWhite: true,
                              Prefixtext: 'Rs',
                              textcontroller: _transfertextcontroller,
                              // hint: "0",
                              fontsize: 28.sp,
                              onChanged: (p0) {
                                //

                                if (p0.isNotEmpty &&
                                    !(int.tryParse(p0)?.isNaN ?? false)) {
                                  //

                                  rollover_amt =
                                      (total_amount) - (int.tryParse(p0) ?? 0);

                                  transfer_amount = total_amount - rollover_amt;

                                  _rollovertextcontroller.text =
                                      rollover_amt.toString();
                                } else {
                                  transfer_amount = 0;
                                  rollover_amt = total_amount;

                                  _rollovertextcontroller.text =
                                      total_amount.toString();
                                }
                              },
                              color: [Colors.white, Colors.white],
                            ),
                          ),
                          // SizedBox(height: 5.h),
                          SizedBox(height: 18.sp),
                          Padding(
                            padding: EdgeInsets.only(left: 23.h, right: 23.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // AnimatedOpacity(
                                //   duration: _duration,
                                //   opacity: _animateopacity.value,
                                //   child: SvgPicture.asset(
                                //     'assets/svg/ic_rollover.svg',
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 19.h,
                                // ),
                                AnimatedOpacity(
                                  duration: _duration,
                                  opacity: _animateopacity.value,
                                  child: Text(
                                    "Rollover",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black,
                                          //  Colors.white,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: EdgeInsets.only(left: 23.h, right: 23.h),
                            child: AmountInputField(
                              topPadding: 2.5.h,
                              bottomPadding: 2.5.h,
                              isBgColorWhite: true,
                              textcontroller: _rollovertextcontroller,
                              // hint: "0",
                              onChanged: (p0) {
                                //

                                if (p0.isNotEmpty &&
                                    !(int.tryParse(p0)?.isNaN ?? false)) {
                                  //

                                  transfer_amount =
                                      (total_amount) - (int.tryParse(p0) ?? 0);

                                  _transfertextcontroller.text =
                                      transfer_amount.toString();

                                  rollover_amt = total_amount - transfer_amount;
                                } else {
                                  rollover_amt = 0;

                                  transfer_amount = total_amount;

                                  _transfertextcontroller.text =
                                      total_amount.toString();
                                }
                              },
                              Prefixtext: "Rs",
                              fontsize: 28.sp,
                              color: [Colors.white, Colors.white],
                            ),
                          ),
                          // SizedBox(
                          //   height: 29.h,
                          // ),
                          SizedBox(height: 28.h),
                          isLaoding
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              // : GestureDetector(
                              : AnimatedLongButton(
                                  height: 51.5.h,
                                  borderRadius: 18,
                                  width:
                                      MediaQuery.of(context).size.width * 100,
                                  leftPadding: 28.h,
                                  rightPadding: 28.h,
                                  topPadding: 0,
                                  bottomPadding: 0,
                                  onPressed: () {
                                    print("$transfer_amount $rollover_amt");

                                    // if (_transfertextcontroller
                                    //         .text.isEmpty ||
                                    //     _rollovertextcontroller
                                    //         .text.isEmpty) {
                                    //   showSnackBar(
                                    //       context,
                                    //       'Please enter a valid number.',
                                    //       true);
                                    //   return;
                                    // }
                                    var isValid = Fzregex.hasMatch(
                                        transfer_amount.toString(),
                                        FzPattern.currency);

                                    var isRoller = Fzregex.hasMatch(
                                        rollover_amt.toString(),
                                        FzPattern.currency);

                                    if (!isValid || !isRoller) {
                                      showSnackBar(context,
                                          'Please enter a valid number', true);
                                      return;
                                    }

                                    if ((transfer_amount.isNegative) ||
                                        (rollover_amt.isNegative)) {
                                      showSnackBar(
                                          context,
                                          'Amount should not be in negative',
                                          true);
                                      return;
                                    }

                                    // if (transfer_amount <= 0.0) {
                                    //   showSnackBar(
                                    //       context,
                                    //       'Transfer amount should not be zero',
                                    //       true);

                                    //   return;
                                    // }
                                    else if (transfer_amount > total_amount) {
                                      showSnackBar(
                                          context,
                                          'Transfer amount must be smaller then Closing Payment.',
                                          true);
                                      return;
                                    }

                                    setState(() {
                                      isLaoding = true;
                                    });

                                    var data = ReceivePaymentReqDataModel(
                                        rolloverAmount: rollover_amt,
                                        source: AppModel().deviceID(),
                                        transferAmount: transfer_amount);

                                    dp(msg: "Data", arg: data.toJson());

                                    dp(msg: "Req body", arg: jsonEncode(data));

                                    ReceivePaymentReqBodyModel reqBody =
                                        ReceivePaymentReqBodyModel(data: data);

                                    repository.SavePaymentRolloverNew(reqBody)
                                        .then((value) {
                                      //

                                      setState(() {
                                        isLaoding = false;
                                      });

                                      if (value != null &&
                                          value.data!.transferRolloverRequest !=
                                              null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => closingTransactionSheet(
                                                  description1:
                                                      "The funds will be deposited into your ",
                                                  description2: "Bank Account",
                                                  description3:
                                                      " prior to the 10",
                                                  description4: "of the month",
                                                  DateStr: DateTime.now(),
                                                  message: value.message,
                                                  response: value.data
                                                      ?.transferRolloverRequest,
                                                  title:
                                                      "Your payment request is ${value.data!.transferRolloverRequest?.status}")),
                                        );
                                      } else {
                                        showSnackBar(context,
                                            "Error please try again", true);
                                      }
                                    }).catchError((e) {
                                      setState(() {
                                        isLaoding = false;
                                      });
                                    });
                                  },
                                  // child: AnimatedLongButton(
                                  text: "Send Request",
                                  isBgColorWhite: true,
                                  textColor: Colors.white,
                                  // Colors.black.withOpacity(0.85),
                                  color: [Color(0xff1F5FA2), Color(0xff272E6D)],
                                ),
                          // ),
                          SizedBox(
                            height: 56.6.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  closingTransactionSheet(
      {required String message,
      String? title,
      DateStr,
      urduDescription,
      description2,
      description1,
      description3,
      description4,
      TransferRolloverRequest? response}) {
    dp(msg: "Rollover ", arg: response?.rollover);
    return TransactionDetailWidget(
        DateStr: DateStr.toString(),
        urduDescription1: 'assets/svg/ic_urdu_4.svg',
        Title: title ?? "Payment Request has been Processed.",
        amountTitle: "Transfer Amount",
        paymentTypekey: "Rollover",
        description1: description1,
        description2: description2,
        description3: description3,
        description4: description4,
        isClosingSheet: true,
        daterich: 'th ',
        //this parameter needs to be removed
        // rolloveramount:
        //     Const.currencyFormatWithoutDecimal.format(response?.rollover ?? 0),
        paymentTypevalue: Constant.currencyFormatWithoutDecimal
            .format(response?.rollover ?? 0),
        //  Const.currencyFormatWithoutDecimal
        // .format(response?.rollover ?? null),
        amountTypevalue: Constant.currencyFormatWithoutDecimal
            .format(response?.transfer ?? 0),

        //  rollover_amt.toString(),
        onPressed: () {
          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HideCapitalView(),
            ),
          );
        },
        color2: Color(0xff272E6D),
        // Color(0xff1164AA),
        //  Color(0xff1164AA),
        color1: Color(0xff1F5FA2)
        //  Color(0xff1164AA)
        //  Color(0xff1164AA),
        );
  }
}

final divider = Divider(
  height: 8,
  color: Colors.white,
  endIndent: 150,
  indent: 150,
  thickness: 3.5,
);

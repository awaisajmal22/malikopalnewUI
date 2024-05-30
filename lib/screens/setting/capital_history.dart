import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:malikopal/model/requestbody/HistoryReqBody_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/utils/utility.dart';

import '../../model/capital_history_responce_model.dart';

class CapitalHistoryView extends StatefulWidget {
  const CapitalHistoryView({Key? key, this.profileId}) : super(key: key);
  static const routeName = '/capital_history-screen';
  final int? profileId;
  @override
  State<CapitalHistoryView> createState() => _CapitalHistoryViewState();
}

class _CapitalHistoryViewState extends State<CapitalHistoryView> {
  //int selected = 0;
  int pno = 0;
  late DashBoardBloc _bloc;
  CapitalHistoryResponseDataModel? data;
  String Filter = "ALL";
  int totalCapital = 0;
  // double totalDebit = 0;
  // double totalCredit = 0;
  @override
  void initState() {
    _bloc = DashBoardBloc();

    // SessionData().getUserProfile().then((value) {
    //   setState(() {
    //     totalCapital = value.totalCapital;
    //   });
    // });

    _bloc.CapitalHistoryStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        data = event.data;
        // for (int i = 0; i < 6; i++) {
        //   var value = data?[0];
        //   value?.Credit = i + 1.0;
        //   data?.add(value!);
        // }
        totalCapital = data?.capitalAmount?.toInt() ?? 0;
        // totalDebit = 0;
        // totalCredit = 0;
        // data?.forEach((element) {
        //   totalCredit += (element.Credit ?? 0);
        //   totalDebit += (element.Debit ?? 0);
        // });
        setState(() {});
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, "Error please try again", true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });

    //

    _bloc.GetCapitalHistoryData(HistoryReqDataModel(
        duration: Filter, pno: pno, profileId: widget.profileId));

    super.initState();
  }

  bool isCaptialShow = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        // bottomNavigationBar: AnimatedBottomBar(),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xff1F5FA2),
              Color(0xff272E6D),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              // color: Theme.of(context).backgroundColor,
                              //Theme.of(context).backgroundColor,
                              shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            "assets/newassets/arrow_back.svg",
                            color: Colors.white,
                            // color: Theme.of(context).dividerColor,
                            height: 17.h,
                            width: 20.w,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Capital History",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 20.sp,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              // Theme.of(context).dividerColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      )),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 20.h, left: 20.h),
                            width: 345.w,
                            height: 180.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.h),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/Base.png'))),
                            // decoration: BoxDecoration(
                            //   color: Color(0xffF6921E),
                            //   borderRadius: BorderRadius.circular(22),
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Theme.of(context)
                            //           .shadowColor
                            //           .withOpacity(0.3),
                            //       blurRadius: 3.h,
                            //       spreadRadius: 2.w,
                            //       offset: Offset(1.h, 3.w),
                            //     ),
                            //   ],
                            // ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    isCaptialShow == true
                                        ? Text(
                                            "Rs. " +
                                                Constant
                                                    .currencyFormatWithoutDecimal
                                                    .format(totalCapital),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontSize: 24.sp,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                          )
                                        : Text(
                                            "*********",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                  fontSize: 24.sp,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                          ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isCaptialShow = !isCaptialShow;
                                        });
                                      },
                                      child: Icon(
                                        isCaptialShow
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer()
                              ],
                            )
                            // CapitalCard(
                            //   title_v1: Text(
                            //     "Total Capital",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyText2!
                            //         .copyWith(
                            //           fontSize: 22.sp,
                            //           fontFamily: 'Montserrat',
                            //           fontWeight: FontWeight.w400,
                            //           color: Colors.white,
                            //         ),
                            //   ),
                            //   // "Total Debit",
                            //   subtitle_v1: Text(
                            //     "Rs. " +
                            //         Constant.currencyFormatWithoutDecimal
                            //             .format(totalCapital),
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .subtitle1!
                            //         .copyWith(
                            //           fontSize: 24.sp,
                            //           fontFamily: 'Montserrat',
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.white,
                            //         ),
                            //   ),

                            //   icon_v1: Center(
                            //     child: Container(
                            //         height: 75.h,
                            //         width: 75.w,
                            //         child: SvgPicture.asset(
                            //             'assets/svg/newcapital.svg')),
                            //   ),
                            //   color_v1: Color(0XFFF6921E),
                            // title_v2: Text(
                            //   "Total Credit",
                            //   style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            //         fontSize: 16.sp,
                            //         fontFamily: 'Montserrat',
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            // ),
                            // // "Total Debit",
                            // subtitle_v2: Text(
                            //   "Rs." + totalCredit.toString(),
                            //   style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            //         fontSize: 20.sp,
                            //         fontFamily: 'Montserrat',
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.black,
                            //       ),
                            // ),
                            // icon_v2: Center(
                            //   child: Container(
                            //       height: 20.h,
                            //       width: 20.w,
                            //       child: SvgPicture.asset('assets/svg/down_arrow.svg')),
                            // ),
                            // color_v2: Color(0xff1164AA),
                            // ),
                            ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SingleChildScrollView(
                        child: NewTabBar(
                          onDateSelected: (date) {
                            _bloc.GetCapitalHistoryData(HistoryReqDataModel(
                                endDate: date,
                                pno: pno,
                                profileId: widget.profileId));
                            setState(() {
                              Filter = "EndDate";
                            });
                          },
                          tab_length: 4,
                          function: (int index) {
                            //

                            var startDate;
                            var endDate;

                            if (index == 0) {
                              Filter = "ALL";
                            } else if (index == 1) {
                              DateTime dateTime = DateTime.now();
                              Filter = "M";
                              startDate =
                                  "01-${dateTime.month}-${dateTime.year}";
                              endDate =
                                  "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                            } else if (index == 2) {
                              DateTime dateTime = DateTime.now();

                              Filter = "Y";

                              startDate = "01-01-${dateTime.year}";

                              endDate =
                                  "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                            }

                            dp(msg: "Start date", arg: startDate);

                            dp(msg: "End date", arg: endDate);

                            setState(() {});

                            _bloc.GetCapitalHistoryData(HistoryReqDataModel(
                              duration: Filter,
                              pno: pno,
                              profileId: widget.profileId,
                              startDate: startDate,
                              endDate: endDate,
                            ));
                          },
                          tabs: ["ALL", "Monthly", "Yearly"],
                          child: [
                            Filter == "ALL" || Filter == "EndDate"
                                ? StreamBuilder<
                                    ApiResponse<
                                        CapitalHistoryResponseDataModel>>(
                                    stream: _bloc.CapitalHistoryStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        switch ((snapshot.data?.status ?? "")) {
                                          case Status.LOADING:
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              //child: Loading(loadingMessage: snapshot.data.message),
                                            );
                                          //break;
                                          case Status.COMPLETED:
                                            if (snapshot.data?.data?.history
                                                    ?.isNotEmpty ??
                                                false)
                                              return ListBuilder(snapshot
                                                      .data?.data?.history ??
                                                  []);
                                            break;
                                          case Status.ERROR:
                                            return SizedBox.shrink();
                                          //break;
                                        }
                                      }
                                      return SizedBox.shrink();
                                    },
                                  )
                                : Container(),
                            Filter == "M" || Filter == "EndDate"
                                ? StreamBuilder<
                                    ApiResponse<
                                        CapitalHistoryResponseDataModel>>(
                                    stream: _bloc.CapitalHistoryStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        switch ((snapshot.data?.status ?? "")) {
                                          case Status.LOADING:
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              //child: Loading(loadingMessage: snapshot.data.message),
                                            );
                                          //break;
                                          case Status.COMPLETED:
                                            if (snapshot.data?.data?.history
                                                    ?.isNotEmpty ??
                                                false)
                                              return ListBuilder(snapshot
                                                      .data?.data?.history ??
                                                  []);
                                            break;
                                          case Status.ERROR:
                                            return SizedBox.shrink();
                                          //break;
                                        }
                                      }
                                      return SizedBox.shrink();
                                    },
                                  )
                                : Container(),
                            Filter == "Y" || Filter == "EndDate"
                                ? StreamBuilder<
                                    ApiResponse<
                                        CapitalHistoryResponseDataModel>>(
                                    stream: _bloc.CapitalHistoryStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        switch ((snapshot.data?.status ?? "")) {
                                          case Status.LOADING:
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              //child: Loading(loadingMessage: snapshot.data.message),
                                            );
                                          //break;
                                          case Status.COMPLETED:
                                            if (snapshot.data?.data?.history
                                                    ?.isNotEmpty ??
                                                false) {
                                              return ListBuilder(snapshot
                                                      .data?.data?.history ??
                                                  []);
                                            }
                                            break;
                                          case Status.ERROR:
                                            return SizedBox.shrink();
                                          //break;
                                        }
                                      }
                                      return SizedBox.shrink();
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ),
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
}

class ListBuilder extends StatelessWidget {
  final List<History> data;

  ListBuilder(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: !isTablet()
          ? const EdgeInsets.only(top: 12, left: 8, right: 8)
          : EdgeInsets.all(0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: ((context, index) {
          if (index >= data.length) return Container();
          return ShowUpAnimation(
            delayStart: Duration(milliseconds: 0),
            animationDuration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            direction: Direction.horizontal,
            offset: 0.7.h,
            child: Column(
              children: [
                CapitalPaymentHistoryCard(
                  fnddata: data[index].fnFDetails,
                  icon: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: ((data[index].type == "Rollover"
                                ? [
                                    Color(0xFFF6921E).withOpacity(0.5),
                                    Color(0xFFF6921E)
                                  ]
                                : (data[index].credit ?? 0) > 0
                                    ? [
                                        Color(0xff1F5FA2),
                                        Color(0xff272E6D),
                                      ]
                                    : [
                                        Color(0xFFF6921E).withOpacity(0.5),
                                        Color(0xFFF6921E)
                                      ])),
                            //  [
                            //   Color(0xff1F5FA2),
                            //   Color(0xff272E6D),
                            // ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                      // radius: 20.h,
                      // backgroundColor: ((data[index].type == "Rollover"
                      //     ? Color(0xFFF6921E)
                      //     : (data[index].credit ?? 0) > 0
                      //         ? Color(0xff254180)
                      //         : Color(0xFFF6921E))),
                      child: Center(
                        child: Container(
                          height: 18.h,
                          width: 18.w,
                          child: (data[index].type == "Add Amount"
                              ? Icon(Icons.add, color: Colors.white, size: 18.h)
                              : (data[index].type == "Rollover"
                                  ? SvgPicture.asset('assets/svg/rollover.svg',
                                      width: 18.h, height: 18.h)
                                  : (data[index].credit! > 0
                                      ? SvgPicture.asset(
                                          'assets/svg/down_arrow.svg',
                                          width: 18.h,
                                          height: 18.h)
                                      : SvgPicture.asset(
                                          'assets/svg/up_arrow.svg')))),
                        ),
                      )),
                  paid_amount: Constant.currencyFormatWithoutDecimal.format(
                      (data[index].credit ?? 0) > 0
                          ? data[index].credit
                          : data[index].debit),
                  pay_date: data[index].dateStr,
                  type: data[index].type,
                  closing_amount: Constant.currencyFormatWithoutDecimal
                      .format(data[index].balance ?? 0),
                  closing: "Balance",
                ),
                if (index == data.length - 1)
                  SizedBox(
                    height: 80,
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NewTabBar extends StatefulWidget {
  const NewTabBar(
      {required this.child,
      required this.tab_length,
      required this.tabs,
      this.function,
      this.onDateSelected,
      Key? key})
      : super(key: key);
  final List<Widget> child;
  final int tab_length;
  final List<String> tabs;
  final Function(int index)? function;
  final Function(String date)? onDateSelected;
  @override
  State<NewTabBar> createState() => _NewTabBarState();
}

class _NewTabBarState extends State<NewTabBar> with TickerProviderStateMixin {
  late TabController _tabControllerV2;
  int _selectedIndex = 0;

  @override
  void initState() {
    _tabControllerV2 =
        TabController(length: widget.tabs.length, vsync: this, initialIndex: 0);
    _tabControllerV2.addListener(() {
      setState(() {
        _selectedIndex = _tabControllerV2.index;
      });
      print("Selected Index: " + _tabControllerV2.index.toString());
      widget.function?.call(_tabControllerV2.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabControllerV2.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  var myFormat = DateFormat('dd/MM/yyyy');

  Future<DateTime?> showDateTimePicker() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.dark(
              primary: Color(0xff254180),
              //  Colors.purple,
              surface: Colors.grey.withOpacity(0.3),
              onPrimary: Colors.white,
              onSurface: Colors.black.withOpacity(0.5),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? Container(),
        );
      },
    );
    if (datePicked != null) {
      setState(() {
        selectedDate = datePicked;
      });
      return selectedDate;
    }
    return datePicked;
  }

  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SessionData().isDarkTheme().then((value) {
      setState(() {
        darkTheme = value;
        //print("Theme State : $darkTheme");
      });
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    //  darkTheme == false
                    //     ? Colors.grey.withOpacity(0.4)
                    //     : Color.fromARGB(255, 120, 121, 121),
                  ),
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                      insets: EdgeInsets.all(1),
                    ),
                    indicatorWeight: 0,
                    indicatorColor: Theme.of(context).shadowColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabControllerV2,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.black.withOpacity(0.32),
                    //  darkTheme ? Colors.white : Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      for (int i = 0; i < widget.tabs.length; i++)
                        Container(
                          height: size.height * 0.057.h,
                          alignment: Alignment.center,
                          child: Text(
                            widget.tabs[i],
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14.sp,
                                      color: _selectedIndex == i
                                          ? Colors.black
                                          : darkTheme == true
                                              ? Colors.black.withOpacity(0.32)
                                              //  Colors.white
                                              : Colors.black.withOpacity(0.32),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.07),
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                )
                              ],
                              borderRadius: BorderRadius.circular(08),
                              color: _selectedIndex == i
                                  ? Color(0xffACBBF3)
                                  //  Colors.white
                                  : Colors.transparent),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
            // Expanded(
            //   flex: 02,
            //   child: GestureDetector(
            //     onTap: () {
            //       showDateTimePicker().then((value) {
            //         if (value != null)
            //           widget.onDateSelected?.call(myFormat.format(value));
            //       });
            //     },
            //     child: Padding(
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 08.0.w, vertical: 10.h),
            //       child: Container(
            //         child: AnimatedContainer(
            //             duration: Duration(milliseconds: 250),
            //             curve: Curves.bounceInOut,
            //             alignment: Alignment.center,
            //             height: size.height * 0.057.h,
            //             // width: 30,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(12),
            //                 color: darkTheme == false
            //                     ? Colors.grey.withOpacity(0.4)
            //                     : Color(0xFF4D5050)),
            //             child: Image.asset("assets/images/slider.png",
            //                 color: darkTheme == true
            //                     ? Colors.white
            //                     : Colors.black)),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        Container(
            //decoration: BoxDecoration(color: Colors.blue),
            height: size.height * 0.68.h,
            width: double.maxFinite,
            child: TabBarView(
                controller: _tabControllerV2, children: widget.child)),
      ],
    );
  }
}

class CapitalCard extends StatelessWidget {
  const CapitalCard(
      {Key? key,
      this.title_v1,
      this.title_v2,
      this.subtitle_v1,
      this.subtitle_v2,
      this.icon_v1,
      this.icon_v2,
      this.color_v1,
      this.color_v2,
      this.trailing_v1,
      this.trailing_v2,
      this.amount_size,
      this.amount_size_v2,
      this.title_size_v1,
      this.titlesize_v2})
      : super(key: key);
  final Widget? title_v1, subtitle_v1;
  final Widget? title_v2, subtitle_v2;
  final Widget? icon_v1, icon_v2;
  final Color? color_v1, color_v2;
  final Widget? trailing_v1, trailing_v2;
  final double? amount_size, amount_size_v2, title_size_v1, titlesize_v2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: size.height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                  radius: 26, backgroundColor: color_v1, child: icon_v1),
            ),
            title: title_v1,
            subtitle: subtitle_v1,
            trailing: trailing_v1,
          ),
          // ListTile(
          //   leading: CircleAvatar(
          //       radius: 20,
          //       backgroundColor: color_v2 ?? Colors.transparent,
          //       child: icon_v2),
          //   subtitle: subtitle_v2,
          //   title: title_v2,
          //   trailing: trailing_v2,
          // )
        ]),
      ),
    );
  }
}
//,---------------

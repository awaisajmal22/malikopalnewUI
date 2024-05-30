import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:malikopal/model/requestbody/HistoryReqBody_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:malikopal/model/CapitalHistoryResponse.dart';
import 'package:malikopal/model/capital_history_responce_model.dart';
import 'package:malikopal/model/requestbody/PaymentHistoryReqBody_model.dart';
import 'package:malikopal/utils/shared_pref.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../utils/utility.dart';

bool isTablet() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? false : true;
}

class CustomShortHistory extends StatelessWidget {
  const CustomShortHistory({
    this.leading,
    this.subtitle,
    this.title,
    this.title_t2,
    this.subtitle_t2,
    this.leading_t2,
    this.trailing,
    Key? key,
  }) : super(key: key);

  final Widget? leading;
  final String? title;
  final String? subtitle;
  final Widget? leading_t2;
  final String? title_t2;
  final String? subtitle_t2;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: size.height * 0.18,
        width: size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(3, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: SizedBox(
                height: 45,
                width: 45,
                child: leading ??
                    CircleAvatar(
                      backgroundColor: Color(0xFFF6921E),
                      // backgroundImage: AssetImage("assets/images/user.png"),
                    ),
              ),
              title: Text(
                title ?? "",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              subtitle: Text(subtitle ?? "",
                  style: Theme.of(context).textTheme.subtitle2),
            ),
            ListTile(
              leading: SizedBox(
                height: 45,
                width: 45,
                child: leading_t2 ??
                    CircleAvatar(backgroundColor: Colors.transparent

                        // backgroundImage: AssetImage("assets/images/user.png"),
                        ),
              ),
              title: Text(title_t2 ?? "",
                  style: Theme.of(context).textTheme.bodyText2),
              subtitle: Text(subtitle_t2 ?? "",
                  style: Theme.of(context).textTheme.subtitle2),
              trailing: Container(
                height: size.height * 0.3,
                width: size.width * 0.3,
                child: trailing ?? Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSingleTile extends StatelessWidget {
  const CustomSingleTile({
    this.leading,
    this.subtitle,
    this.title,
    this.trailing,
    Key? key,
  }) : super(key: key);
  final Widget? leading;
  final Widget? title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(isTablet() ? 16.0 : 12),
      child: Container(
        height: 75,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          // Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xff3629B7).withOpacity(0.07),
              // Theme.of(context).shadowColor,
              blurRadius: 30,
              // 5,
              spreadRadius: 0,
              // 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: SizedBox(
                height: 40,
                width: 40,
                child: leading ??
                    CircleAvatar(
                      backgroundColor: Color(0xff1164AA),
                    ),
              ),
              title: title,
              subtitle: Text(subtitle ?? "",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              trailing: trailing,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileListTile extends StatefulWidget {
  Widget? leading;

  ProfileListTile(
      {Key? key,
      this.textField,
      this.trailinig,
      this.hint,
      this.icon,
      this.keyboardtype,
      this.textcontroller,
      required this.label,
      this.subtitle,
      this.onChanged,
      this.validator,
      this.leading,
      this.maskTextInputFormatter})
      : super(key: key);
  final Widget? textField;
  final Widget? subtitle;
  final Widget? trailinig;
  final TextEditingController? textcontroller;
  final IconData? icon;
  final String? hint;

  final String? label;
  final TextInputType? keyboardtype;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final MaskTextInputFormatter? maskTextInputFormatter;

  @override
  State<ProfileListTile> createState() => _ProfileListTileState();
}

class _ProfileListTileState extends State<ProfileListTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // decoration: BoxDecoration(
        //   color: Theme.of(context).cardColor,
        //   borderRadius: BorderRadius.circular(16),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Theme.of(context).shadowColor.withOpacity(0.3),
        //       blurRadius: 4.h,
        //       spreadRadius: 3.w,
        //       offset: Offset(1.w, 3.h),
        //     ),
        //   ],
        // ),
        child: ListTile(
          // minVerticalPadding: 10.0,
          title: TextFormField(
            inputFormatters: widget.maskTextInputFormatter != null
                ? [
                    widget.maskTextInputFormatter ??
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          return newValue;
                        })
                  ]
                : null,
            keyboardType: widget.keyboardtype ?? TextInputType.text,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.always,
            controller: widget.textcontroller,
            onChanged: (value) => widget.onChanged?.call(value),
            decoration: InputDecoration(
                label: Text(
                  widget.label ?? "",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF05A28)),
                ),
                prefix: widget.leading,
                hintText: widget.hint,
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).cardColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: isDarkThemeEnabled(context)
                            ? Colors.white
                            : Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: isDarkThemeEnabled(context)
                            ? Colors.white
                            : Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: isDarkThemeEnabled(context)
                            ? Colors.white
                            : Colors.black)),
                // InputBorder.none,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.red))),
          ),
          subtitle: widget.subtitle,
          trailing: widget.trailinig,
        ),
      ),
    );
  }
}

class AmountInputField extends StatefulWidget {
  AmountInputField(
      {this.Prefixtext = '',
      this.color,
      this.width,
      this.borderRadius = 16,
      this.textColor,
      this.hint,
      this.prefix,
      this.fontsize,
      this.isenable,
      this.topPadding,
      this.bottomPadding,
      this.onChanged,
      required this.textcontroller,
      this.textInputAction,
      this.focusNode,
      Key? key,
      required this.isBgColorWhite})
      : super(key: key);
  final List<Color>? color;
  final double borderRadius;
  final bool isBgColorWhite;
  final double? width;
  final String Prefixtext;
  final Color? textColor;
  final String? hint;
  final double? fontsize;
  final bool? isenable;
  final TextEditingController textcontroller;
  final TextInputAction? textInputAction;
  final bool? prefix;
  final double? topPadding;
  final double? bottomPadding;

  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  @override
  State<AmountInputField> createState() => _AmountInputFieldState();
}

class _AmountInputFieldState extends State<AmountInputField> {
  late FocusNode focusNode;
  //  _animateright;
  @override
  void initState() {
    focusNode = new FocusNode();

    // listen to focus changes
    focusNode.addListener(
        () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // color:
      //  Colors.white,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(widget.borderRadius),
      // ),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius)),
      // elevation: 20,
      // height: isTablet() ? 183.h : 63.h,
      // width: widget.width ?? width * 0.78.w,
      // alignment: Alignment.center,
      // margin: EdgeInsets.symmetric(horizontal: 08.w),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(widget.borderRadius),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.4),
      //       blurStyle: BlurStyle.outer,
      //       blurRadius: 54.h,
      //       spreadRadius: 3.w,
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
            top: widget.topPadding ?? 2.5.h,
            bottom: widget.bottomPadding ?? 2.5.h,
            right: 10.h,
            left: widget.Prefixtext.isNotEmpty ? 10.h : 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (widget.Prefixtext.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: 15.5.h),
                child: Text(
                  widget.Prefixtext ?? '',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    //  Color(0xFF58595B),
                    fontWeight: FontWeight.w400,
                    fontSize: 16.5.sp,
                  ),
                ),
              )
            else
              SizedBox.shrink(),
            if (widget.Prefixtext.isNotEmpty) SizedBox(width: 10),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: widget.onChanged,
                textAlign: TextAlign.left,
                textInputAction: widget.textInputAction,
                autocorrect: true,
                enabled: widget.isenable ?? true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: widget.fontsize ?? 26.sp,
                      fontWeight: FontWeight.w500,
                      color: widget.isBgColorWhite
                          ? widget.textColor ?? Colors.black
                          : Colors.white,
                    ),
                controller: widget.textcontroller,
                decoration: InputDecoration(
                  // hintText: widget.hint,
                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontFamily: "Montserrat",
                      fontSize: widget.fontsize ?? 26.sp,

                      // color: Color(0xFF858585),
                      color: Color(0xff58595b),
                      fontWeight: FontWeight.w400),
                  // prefixText: '              Rs',
                  // prefixStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  // fontFamily: "Montserrat",
                  // fontSize: 20.sp,
                  // // color: Color(0xFF858585),
                  // color: Color(0xff58595b),
                  // fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSimpleImputField extends StatefulWidget {
  CustomSimpleImputField(
      {required textcontroller,
      this.icon,
      this.hint,
      this.label,
      this.suffixicon,
      this.prefix,
      this.keyboardtype,
      Key? key})
      : super(key: key);

  final TextEditingController textcontroller = TextEditingController();
  final IconData? icon;
  final String? hint;
  final String? label;
  final Widget? prefix;
  final Widget? suffixicon;
  final TextInputType? keyboardtype;

  @override
  State<CustomSimpleImputField> createState() => _CustomSimpleImputFieldState();
}

class _CustomSimpleImputFieldState extends State<CustomSimpleImputField> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return TextFormField(
      keyboardType: widget.keyboardtype ?? TextInputType.text,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400),
      controller: widget.textcontroller,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isCollapsed: true,
        prefix: Padding(
          padding: EdgeInsets.only(right: 8.0.w),
          child: widget.prefix,
        ),
        suffixIcon: widget.suffixicon ?? null,
        label: Text(
          widget.label ?? "",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 14.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400),
        ),
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Color(0xFF858585),
            textBaseline: TextBaseline.alphabetic,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400),
        border: InputBorder.none,
      ),
    );
  }
}

class FilterDropDown extends StatefulWidget {
  FilterDropDown({required this.bloc, this.profileId, Key? key})
      : super(key: key);
  final DashBoardBloc bloc;
  final int? profileId;
  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  // late TextEditingController _userEditTextController;

  late DateTime selectedDate = DateTime.now();
  late DateTime selectedMonth = DateTime.now();

  @override
  void initState() {
    // _userEditTextController = TextEditingController();
    super.initState();
  }

  late bool isField = false;
  // String _selectedMonth = "";
  var myFormat = DateFormat('yyyy');
  var myMonthFormat = DateFormat('MMMM');

  Future pickMonth() async {
    await showMonthYearPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedMonth,
    ).then((new_value) {
      if (new_value != null) {
        setState(() {
          selectedMonth = new_value;
          print("${myMonthFormat.format(selectedMonth)}");
          var data = PaymentHistoryReqDataModel(
              Month: "${myMonthFormat.format(selectedMonth)}",
              Year: selectedMonth.year.toString(),
              profileId: widget.profileId,
              Pno: 0);
          widget.bloc.GetPaymentRolloveHistoryData(data);
        });
      }
      return selectedMonth;
    });
  }

  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    SessionData().isDarkTheme().then((value) {
      setState(() {
        darkTheme = value;
      });
    });
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 08),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: (() => pickMonth()),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 04, vertical: 02),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  color: Color(0xffACBBF3),
                  // Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Theme.of(context).shadowColor.withOpacity(0.3),
                  //     blurRadius: 4.h,
                  //     spreadRadius: 3.w,
                  //     offset: Offset(1.w, 3.h),
                  //   ),
                  // ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${DateFormat('MMMM yyyy').format(selectedMonth)}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat'),
                      ),
                      SvgPicture.asset('assets/svg/calendar.svg')
                      // Icon(Icons.calendar_month)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                var data = PaymentHistoryReqDataModel(
                    Month: '', Year: '0', profileId: widget.profileId, Pno: 0);

                widget.bloc.GetPaymentRolloveHistoryData(data);
              },
              child: Container(
                height: 46.h,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withOpacity(0.23),
                    width: 1,
                  ),
                  color: Colors.black.withOpacity(0.09),
                  // Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Theme.of(context).shadowColor.withOpacity(0.3),
                  //     blurRadius: 4.h,
                  //     spreadRadius: 3.w,
                  //     offset: Offset(1.w, 3.h),
                  //   ),
                  // ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    "ALL",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Colors.black.withOpacity(0.54)
                        // color:
                        //     darkTheme == true ? Colors.white : Colors.black,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  const CustomTabBar(
      {required this.child,
      required this.tab_length,
      required this.tabs,
      this.function,
      this.OnDateChanged,
      Key? key})
      : super(key: key);
  final List<Widget> child;
  final int tab_length;
  final List<String> tabs;
  final Function(int index)? function;
  final Function(DateTime? selectedDate, String formatedDate)? OnDateChanged;
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController =
        TabController(length: widget.tabs.length, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
      widget.function?.call(_tabController.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();

  var myFormat = DateFormat('dd-MM-yyyy');

  Future<void> showDateTimePicker() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.dark(
              primary: Colors.purple,
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
      widget.OnDateChanged?.call(datePicked, myFormat.format(datePicked));
    }
  }

  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    SessionData().isDarkTheme().then((value) {
      setState(() {
        darkTheme = value;
        print("Themee State : $darkTheme");
      });
    });
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 09,
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white
                      // darkTheme == false
                      //     ? Colors.grey.withOpacity(0.4)
                      //     : Color(0xFF4D5050),
                      ),
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                      insets: EdgeInsets.all(3),
                    ),
                    indicatorWeight: 0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelColor: darkTheme ? Colors.white : Colors.black,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: [
                      for (int i = 0; i < widget.tabs.length; i++)
                        Container(
                          height: size.height * 0.057.h,
                          alignment: Alignment.center,
                          child: Text(
                            widget.tabs[i],
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 13.sp,
                                      fontFamily: 'Montserrat',
                                      color: _selectedIndex == i
                                          ? Colors.black
                                          : Colors.black.withOpacity(0.32),
                                      //  darkTheme == true
                                      //     ? Colors.white
                                      //     : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 06.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(08),
                              color: _selectedIndex == i
                                  ? Color(0xffACBBF3)
                                  // Colors.white
                                  : Colors.transparent),
                        )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            )
            // Expanded(
            //   flex: 02,
            //   child: GestureDetector(
            //     onTap: () {
            //       showDateTimePicker();
            //     },
            //     child: Padding(
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 08.0.w, vertical: 10.h),
            //       child: Container(
            //           child: AnimatedContainer(
            //               duration: Duration(milliseconds: 250),
            //               curve: Curves.bounceInOut,
            //               alignment: Alignment.center,
            //               height: size.height * 0.057.h,
            //               // width: 30,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: darkTheme == false
            //                       ? Colors.grey.withOpacity(0.4)
            //                       : Color(0xFF4D5050)),
            //               child: Image.asset("assets/images/slider.png",
            //                   color: darkTheme == true
            //                       ? Colors.white
            //                       : Colors.black))),
            //     ),
            //   ),
            // ),
          ],
        ),
        Container(
            height: size.height * 0.9.h,
            width: double.maxFinite,
            child:
                TabBarView(controller: _tabController, children: widget.child)),
      ],
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
    this.bloc,
    required TextEditingController searchtextcontroller,
  })  : _searchtextcontroller = searchtextcontroller,
        super(key: key);

  final DashBoardBloc? bloc;
  final TextEditingController _searchtextcontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.4),
              blurRadius: 4,
              spreadRadius: 3,
              offset: Offset(2, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 24.0.w, right: 06.w),
          child: TextField(
            style: TextStyle(fontSize: 14.sp),
            controller: _searchtextcontroller,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  var resq = bloc!.GetReferenceIn(HistoryReqDataModel(
                      Keyword: _searchtextcontroller.toString()));
                  print("Request Done : $resq + $_searchtextcontroller");
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 04.0.w, vertical: 04.w),
                  child: Container(
                    width: 18.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        // size: 24,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomHorizontalListView extends StatefulWidget {
  CustomHorizontalListView({
    required this.title,
    required this.child,
    required this.Imagepath,
    Key? key,
  }) : super(key: key);

  final String title;

  final ImageProvider child;
  final String Imagepath;

  @override
  State<CustomHorizontalListView> createState() =>
      _CustomHorizontalListViewState();
}

class _CustomHorizontalListViewState extends State<CustomHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    double box = isTablet() ? 130 : 60;
    return Container(
      height: box + 90,
      width: box + 30,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: box,
            width: box,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14),
              image:
                  // widget.Imagepath.isNotEmpty
                  //     ? DecorationImage(
                  //         image: NetworkImage(
                  //             Endpoints.GetGalleryUrl(widget.Imagepath)),
                  //         fit: BoxFit.cover,
                  //       )
                  //     :

                  DecorationImage(
                image:
                    AssetImage(widget.Imagepath), //'assets/gallery/noimg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.visible,
            softWrap: true,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontSize: 10.sp),
          )
        ],
      ),
    );
  }
}

class CustomTopBar extends StatelessWidget {
  const CustomTopBar(
      {Key? key,
      this.backButtonColor = Colors.white,
      required this.topbartitle,
      this.action,
      this.fontSize = 20,
      this.onPressed,
      this.isBottomSheet = false,
      this.mainAlignment = MainAxisAlignment.spaceBetween,
      this.isProfileUpdate})
      : super(key: key);
  final Color backButtonColor;
  final String topbartitle;
  final Widget? action;
  final bool? isProfileUpdate;
  final double fontSize;
  final bool isBottomSheet;
  final MainAxisAlignment mainAlignment;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: mainAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isProfileUpdate == true
              ? SizedBox.shrink()
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: InkWell(
                      onTap: isBottomSheet == true
                          ? onPressed
                          : () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              Navigator.pop(context);
                            },
                      child: Container(
                        width: 40,
                        height: 40,
                        // decoration: BoxDecoration(
                        //     color: Theme.of(context).backgroundColor,
                        //     //Theme.of(context).backgroundColor,
                        //     shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          'assets/newassets/arrow_back.svg',
                          color: backButtonColor,
                          //  Theme.of(context).dividerColor,
                          height: 17.h,
                          width: 20.w,
                        ),
                      ),
                    ),
                  ),
                ),
          if (mainAlignment == MainAxisAlignment.start)
            SizedBox(
              width: 10.w,
            ),
          Flexible(
            child: Text(
              topbartitle,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize.sp,
                  fontFamily: "Montserrat",
                  color: backButtonColor ?? Colors.white,
                  // Theme.of(context).cardColor,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          action ??
              SizedBox(
                width: 40,
              ),
        ],
      ),
    );
  }
}

class CustomBriefCard extends StatelessWidget {
  const CustomBriefCard(
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
  final String? title_v1, subtitle_v1;
  final String? title_v2, subtitle_v2;
  final Widget? icon_v1, icon_v2;
  final List<Color>? color_v1, color_v2;
  final Widget? trailing_v1, trailing_v2;
  final double? amount_size, amount_size_v2, title_size_v1, titlesize_v2;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.w),
      child: Container(
        height: isTablet() ? size.height * 0.10.h : null,
        decoration: BoxDecoration(
          color: Colors.white,
          // Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Color(0xff3629B7).withOpacity(0.07),
              // Theme.of(context).shadowColor.withOpacity(0.4),
              blurRadius: 30,
              //  5.h,
              spreadRadius: 0,
              // 3.w,
              offset: Offset(0, 4),
              //  Offset(1.h, 4.w),
            ),
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListTile(
            leading: Container(
                height: 35.h,
                width: 35.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: color_v1!,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                // radius: 20.h, backgroundColor: color_v1,
                child: icon_v1),
            title: Text(
              title_v1 ?? "",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: title_size_v1 ?? 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
            ),
            subtitle: Text(
              subtitle_v1 ?? "",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: amount_size ?? 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
            trailing: trailing_v1,
          ),
          ListTile(
            leading: Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors:
                          color_v2 ?? [Colors.transparent, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                // radius: 20.h,
                // backgroundColor: color_v2 ?? Colors.transparent,
                child: icon_v2),
            subtitle: Text(
              subtitle_v2 ?? "",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: amount_size_v2 ?? 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
            title: Text(
              title_v2 ?? "",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: titlesize_v2 ?? 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
            ),
            trailing: trailing_v2,
          )
        ]),
      ),
    );
  }
}

class PaymentHistoryCard extends StatefulWidget {
  const PaymentHistoryCard({
    Key? key,
    this.amount,
    required this.imagePath,
    this.color,
    this.type,
    this.date,
    this.expandable,
  }) : super(key: key);
  final String? amount;
  final String? type;
  final String? date;
  final String imagePath;
  final List<Color>? color;
  final Widget? expandable;
  @override
  State<PaymentHistoryCard> createState() => _PaymentHistoryCardState();
}

class _PaymentHistoryCardState extends State<PaymentHistoryCard> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isvisible = !isvisible;
          });
        },
        child: Column(
          children: [
            ShowUpAnimation(
              delayStart: Duration(milliseconds: 0),
              animationDuration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              direction: Direction.horizontal,
              offset: 0.7,
              child: Container(
                height: isTablet() ? size.height * 0.05.h : size.height * 0.1.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff3629B7).withOpacity(0.07),
                      // Theme.of(context).shadowColor.withOpacity(0.3),
                      blurRadius: 4.h,
                      spreadRadius: 0,
                      //  3.w,
                      offset: Offset(
                          // 1.w,
                          0,
                          4.h),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 82.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15)),
                              color: Color(0xffFFAF2A)),
                          child: Center(
                              child: Text(
                            widget.type != "Add Amount"
                                ? widget.type ?? ""
                                : "Added",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 12.sp,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontWeight: isvisible
                                          ? FontWeight.bold
                                          : FontWeight.w700,
                                    ),
                          )),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          colors: widget.color!)),

                                  // radius: 20.h,
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      child: Center(
                                          child: Container(
                                              height: 18.h,
                                              width: 18.w,
                                              child: SvgPicture.asset(
                                                  widget.imagePath))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 14.w,
                                ),
                                SizedBox(
                                  width: 120.w,
                                  child: Text(
                                    widget.amount ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 16.sp,
                                          color: Color(0xff2B2B2B),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   child: Text(
                          //     widget.type ?? "",
                          //     style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          //           fontSize: 14.sp,
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //   ),
                          // ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 20.h,
                            child: Container(
                              height: 35.h,
                              width: 35.w,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                child: RotatedBox(
                                  quarterTurns: 0,
                                  child: Center(
                                      child: Image.asset(
                                    'assets/images/arrow_bottom.png',
                                    // color:
                                    //  Theme.of(context).dividerColor,
                                    height: 17.h,
                                    width: 20.w,
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.sp),
                            child: FittedBox(
                              child: Text(
                                widget.date ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 13.sp,
                                      color: Color(0xff989898),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 06.h,
            ),
            Container(
              child: Visibility(
                  visible: isvisible, child: widget.expandable ?? Container()),
            )
          ],
        ),
      ),
    );
  }
}

class CapitalPaymentHistoryCard extends StatefulWidget {
  const CapitalPaymentHistoryCard(
      {Key? key,
      this.closing_amount,
      this.paid_amount,
      this.pay_date,
      this.icon,
      this.color,
      this.type,
      this.closing,
      this.fnddata})
      : super(key: key);

  final String? paid_amount, closing_amount;
  final String? type;
  final FnfDetailsData? fnddata;
  final String? pay_date, closing;

  final Widget? icon;
  final Color? color;

  @override
  State<CapitalPaymentHistoryCard> createState() =>
      _CapitalPaymentHistoryCardState();
}

class _CapitalPaymentHistoryCardState extends State<CapitalPaymentHistoryCard> {
  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          top: isTablet() ? 18.0.w : 4.w,
          left: isTablet() ? 18.0.w : 4.w,
          right: isTablet() ? 18.0.w : 4.w),
      child: GestureDetector(
        onTap: () {
          if (widget.type != 'F & F') return;
          setState(() {
            this.isvisible = !isvisible;
          });
        },
        child: Column(
          children: [
            Container(
              height: size.height * 0.1.h,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.1),
                    blurRadius: 3.h,
                    spreadRadius: 2.w,
                    offset: Offset(1.h, 3.w),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 82.w,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(15)),
                            color: Color(0xffFFAF2A)),
                        child: Center(
                            child: Text(
                          widget.type != "Add Amount"
                              ? widget.type ?? ""
                              : "Added",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 12.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: isvisible
                                        ? FontWeight.bold
                                        : FontWeight.w700,
                                  ),
                        )),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, bottom: 08.h, top: 08.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          // flex: 06,
                          child: Container(
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: widget.icon,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.0.w,
                                  ),
                                  child: Container(
                                    // width: size.width / 3.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.paid_amount ?? "",
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 16.sp,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          widget.pay_date ?? "",
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 12.sp,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 10.w),
                        //   child: FittedBox(
                        //     child: Container(
                        //       alignment: Alignment.centerRight,
                        //       child: Text(
                        //         widget.type != "Add Amount"
                        //             ? widget.type ?? ""
                        //             : "Added",
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyText2!
                        //             .copyWith(
                        //               fontSize: 12.sp,
                        //               fontFamily: 'Montserrat',
                        //               fontWeight: isvisible
                        //                   ? FontWeight.bold
                        //                   : FontWeight.w400,
                        //             ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  // width: size.width / 2.8,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget.closing_amount ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 14.sp,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: isvisible
                                                        ? FontWeight.bold
                                                        : FontWeight.w500,
                                                    color: Color(0xff2B2B2B)
                                                    // Color(0xff254180),
                                                    //  Color(0xff1164AA),
                                                    ),
                                          ),
                                          Text(
                                            widget.closing ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 12.sp,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Visibility(
                  visible: isvisible,
                  child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.1),
                            blurRadius: 3.h,
                            spreadRadius: 2.w,
                            offset: Offset(1.h, 3.w),
                          ),
                        ],
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: CircleAvatar(
                                backgroundColor:
                                    Colors.red, //Color(0xff1164AA),
                                backgroundImage: AssetImage(
                                  "assets/images/FandF.png",
                                ),
                                child: Center(
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Transaction Summary',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 14.sp,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff254180),
                                            //  Color(0xff1164AA),
                                          ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rs. ' +
                                              (widget.fnddata == null
                                                  ? ""
                                                  : widget.fnddata!.amount
                                                          .toString() +
                                                      ' '),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          widget.fnddata == null
                                              ? ""
                                              : widget.fnddata!.type.toString(),
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (widget.fnddata == null
                                              ? ""
                                              : widget.fnddata!.fullName
                                                      .toString()
                                                      .trim() +
                                                  ' - '),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          widget.fnddata == null
                                              ? ""
                                              : widget.fnddata!.userID
                                                  .toString(),
                                          style: TextStyle(),
                                        )
                                      ],
                                    )
                                  ]),
                            )
                          ]))),
            ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        ),
      ),
    );
  }
}
//---------------------

//-------------------Reference in tile custom widget

class CustomReferenceInCard extends StatelessWidget {
  const CustomReferenceInCard(
      {Key? key, this.name, this.token_no, this.icon, this.color, this.amount})
      : super(key: key);
  final String? name, token_no, amount;
  final Color? color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(12.0.w),
      child: Container(
        height: size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 3,
              spreadRadius: 2,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0.w),
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 08.h,
                      child: Icon(
                        icon,
                        color: color ?? null,
                        size: 08.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name ?? "",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        token_no ?? "",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    amount ?? "",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//---------------------

class SmallRadiusButton extends StatefulWidget {
  const SmallRadiusButton({
    required this.text,
    this.textcolor,
    this.color,
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color? textcolor;
  final List<Color>? color;
  final double? height, width;

  @override
  State<SmallRadiusButton> createState() => _SmallRadiusButtonState();
}

class _SmallRadiusButtonState extends State<SmallRadiusButton> {
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    SessionData().isDarkTheme().then((value) {
      setState(() {
        darkTheme = value;
      });
    });
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 00),
      height: widget.height ?? 30.h,
      width: widget.width ?? 125.w,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: widget.color ??
              [
                Theme.of(context).shadowColor,
                Theme.of(context).shadowColor,
              ],
        ),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14.sp,
                color: widget.textcolor ?? Colors.black,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

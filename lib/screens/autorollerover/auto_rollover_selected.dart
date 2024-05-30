import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/autorollerover/auto_rollover_feedback.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/dashboard.dart';
import 'package:malikopal/utils/globles.dart';
import 'package:malikopal/utils/utility.dart';

import '../../ScopedModelWrapper.dart';
import 'auto_rollover_status.dart';
import 'auto_rollover_tile.dart';
import 'model/auto_roller_list_model.dart';

class AutoRollOveSelected extends StatefulWidget {
  const AutoRollOveSelected(
      {Key? key,
      required this.fistNum,
      required this.secondNum,
      required this.id})
      : super(key: key);
  final String fistNum;
  final String secondNum;
  final int id;

  @override
  State<AutoRollOveSelected> createState() => _AutoRollOveSelectedState();
}

class _AutoRollOveSelectedState extends State<AutoRollOveSelected> {
  screenState curentState = screenState.loaded;

  DashboardRepository dashBoardScreen = DashboardRepository();

  AutoRollerOverListModel? responce;

  postAutoRollover() async {
    try {
      setState(() {
        curentState = screenState.loading;
      });

      responce = await dashBoardScreen.postAutoRollOver(widget.id);

      if (responce != null) {
        toNext(AutoRollOverFeedBack(
          upcomingClosing: widget.fistNum,
        ));
      } else {
        showSnackBar(context, "Error please try again", false);
        setState(() {
          curentState = screenState.loaded;
        });
      }
    } catch (e, s) {
      //
      showSnackBar(context, "Error please try again", false);

      setState(() {
        curentState = screenState.loaded;
      });

      dp(msg: "Error", arg: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppModel model = ScopedModel.of<AppModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          "Auto Rollover",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xff1164AA),
          ),
        ),
        elevation: 0,
        backgroundColor: model.isDarkTheme ? Color(0xff6A6B6B) : Colors.white,
        leadingWidth: 1,
        actions: [
          InkWell(
            enableFeedback: false,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 35),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 185,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      Color(0xff3A0638),
                      Color(0xffF535EC),
                    ], tileMode: TileMode.repeated)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You Have selected  ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AutoRollOverTile(
                      onPress: () {},
                      subTitle: widget.secondNum,
                      textNum: widget.fistNum,
                      titleText: 'Upcoming Closing',
                      isSelected: false,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  "Are you sure you have selected the correct option",
                  style: TextStyle(
                      fontSize: 22,
                      color:
                          model.isDarkTheme ? Colors.white : Color(0xff606161),
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
                "assets/newassets/questionMark.svg",
                color: Color(0xffBABCBE),
                height: 126,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: RichText(
                    text: TextSpan(
                        text: "NOTE:",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color(0xff1164AA),
                            //  Color(0xff912C8C),
                            fontWeight: FontWeight.w700),
                        children: [
                      TextSpan(
                          text:
                              "This request will be processed immediately and irreversible",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Montserrat",
                              color: model.isDarkTheme
                                  ? Colors.white
                                  : Color(0xff606161),
                              fontWeight: FontWeight.w400))
                    ])),
              ),
              SizedBox(
                height: 50,
              ),
              curentState == screenState.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      onTap: () {
                        postAutoRollover();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width - 50,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff010101).withOpacity(0.5))
                            ],
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffB44297),
                                  Color(0xffAD4297),
                                  Color(0xff9B4297),
                                  Color(0xff7E4298),
                                  Color(0xff754399),
                                ],
                                tileMode: TileMode.repeated,
                                transform: GradientRotation(12))),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
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

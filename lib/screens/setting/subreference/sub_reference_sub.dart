import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/setting/capital_history.dart';
import 'package:malikopal/screens/setting/payment_history.dart';
import 'package:malikopal/screens/setting/profile_screen.dart';
import 'package:malikopal/screens/setting/recieved_amount.dart';
import 'package:malikopal/screens/setting/subreference/sub_reference_post.dart';
import 'package:malikopal/screens/setting/subreference/sub_reference_user_model.dart';
import 'package:malikopal/utils/utility.dart';

import '../../../ScopedModelWrapper.dart';
import '../../../utils/Const.dart';
import '../components/setting.widgets.dart';
import '../referenceIn_screen.dart';

class SubRefenceSubUserScreen extends StatefulWidget {
  const SubRefenceSubUserScreen({Key? key}) : super(key: key);

  @override
  State<SubRefenceSubUserScreen> createState() =>
      _SubRefenceSubUserScreenState();
}

class _SubRefenceSubUserScreenState extends State<SubRefenceSubUserScreen> {
  int totalCapital = 0;
  num totalClosing = 0;
  int totalMember = 0;

  List<ReferenceNode>? referenceData;

  DashboardRepository dashboardRepository = DashboardRepository();

  SubRefenceUserData? data;

  bool isLoading = false;

  var Filter = 'ALL';

  @override
  void initState() {
    super.initState();
    getData(SubRefencePostData(
        data: SubRefeData(
            duration: "All",
            endDate: '',
            keyword: '',
            profileId: 0,
            startDate: '')));
  }

  Future<SubRefenceUserData?> getData(SubRefencePostData dataPost) async {
    //
    isLoading = true;
    if (mounted) setState(() {});

    referenceData?.clear();

    var subReference = await dashboardRepository.getSubRefenceSub(dataPost);

    dp(msg: "Member Subrefence", arg: subReference?.toJson());
    if (subReference != null) {
      //

      data = subReference;

      var newData = data!.data;

      dp(msg: "Member count", arg: newData);

      totalCapital = newData?.totalCapital?.toInt() ?? 0;
      totalClosing = data?.data?.referenceNodes?.fold(
              0,
              (previousValue, element) =>
                  previousValue! + element.recentClosingAmount!) ??
          0;
      totalMember = newData?.memberCount?.toInt() ?? 0;

      referenceData = newData?.referenceNodes;

      isLoading = false;
      if (mounted) setState(() {});

      print(data?.toJson());
      return subReference;
    } else {
      showSnackBar(context, "Error in getting data please try again", true);
      isLoading = false;
      if (mounted) setState(() {});
      return null;
    }
  }

  TextEditingController searchBox = new TextEditingController();

  @override
  void dispose() {
    searchBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //

    AppModel model = ScopedModel.of<AppModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            CustomTopBar(
              // leading: SizedBox(),
              topbartitle:
                  // Text(
                  "Sub Reference",
              // style: TextStyle(
              backButtonColor: model.isDarkTheme ? Colors.white : Colors.black,
              // fontWeight: FontWeight.w700),
              // ),
              // elevation: 0.0,
              // leadingWidth: 0,
              // backgroundColor: Colors.transparent,
              // actions: [
              //   InkWell(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: Container(
              //       width: 35,
              //       height: 35,
              //       decoration: BoxDecoration(
              //           // color: Color(0xff189694),
              //           //Theme.of(context).backgroundColor,
              //           shape: BoxShape.circle),
              //       child: Image.asset(
              //         'assets/images/arrow_back.png',
              //         color:
              //             model.isDarkTheme ? Colors.white : Color(0xff8E8E8E),
              //         // Colors.white,
              //         height: 17.h,
              //         width: 20.w,
              //       ),
              //     ),
              //   ),
              //   SizedBox(
              //     width: 20,
              //   )
              // ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              height: isTablet() ? 250 : null,
              child: Referencein(
                title_v1: "Sub Reference Capital",
                subtitle_v2: "Sub Ref Closing Payment",
                bgColor: Color(0xff8E8E8E),
                //  Color(0xff0094D5),
                color2: Color(0xff8E8E8E),
                icon_v1: Center(
                  child: Container(
                      height: 30.h,
                      width: 30.w,
                      child: SvgPicture.asset(
                        'assets/svg/newcapital.svg',
                        // color:
                        //  model.isDarkTheme
                        // ?
                        // Colors.white,
                        // : Color(0XFF8E8E8E),
                      )),
                ),
                color_v1: Colors.white,
                //  Color(0xffF6921E),
                //  Colors.white,
                subtitle_v1: "Rs. " +
                    Constant.currencyFormatWithoutDecimal.format(totalCapital),
                trailing_v1: Flexible(
                  child: Container(
                    width: 110,
                    height: 70,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.white,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [Color(0xff1F5FA2), Color(0xff272E6D)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                          height: 35,
                          width: 1,
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Flexible(
                          child: FittedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Members',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 13.sp,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        //  Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  totalMember.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        //  Colors.white,
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
                amount_size_v2: totalClosing.toInt(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12, bottom: 15, top: 24),
              child: Container(
                height: isTablet() ? 64 : 45,
                width: size.width * 0.83.w,
                //decoration: BoxDecoration(color: Colors.red),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    lightSource: LightSource.left,
                    disableDepth: false,
                    shadowLightColorEmboss: Theme.of(context).cardColor,
                    shadowDarkColorEmboss: Color.fromARGB(255, 182, 182, 182),
                    depth: -1,
                    color: Theme.of(context).cardColor,
                    intensity: 0.9,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
                  ),
                  child: TextFormField(
                    //cursorHeight: 40,

                    keyboardType: TextInputType.text,
                    controller: searchBox,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),

                    onFieldSubmitted: (String value) {
                      var data = getData(SubRefencePostData(
                          data: SubRefeData(
                              duration: "ALL",
                              endDate: '',
                              keyword: value,
                              profileId: 0,
                              startDate: '')));

                      // _bloc.GetReferenceIn(data);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 8),
                      hintText: "Name & ID",

                      hintStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: GestureDetector(
                          onTap: () {
                            print(searchBox.text);
                            //
                            getData(SubRefencePostData(
                                data: SubRefeData(
                                    duration: "ALL",
                                    endDate: '',
                                    keyword: searchBox.text,
                                    profileId: 0,
                                    startDate: '')));
                          },
                          child: Container(
                            height: 22.h,
                            width: 22.w,
                            child: SvgPicture.asset(
                              "assets/svg/search.svg",
                              color: model.isDarkTheme
                                  ? Colors.white
                                  : Color(0xff8E8E8E),
                              // Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                      // border: OutlineInputBorder(
                      //   borderSide:
                      //       const BorderSide(color: Colors.green, width: 2.0),
                      //   borderRadius: BorderRadius.circular(5.0),
                      // ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            SingleChildScrollView(
              child: ReferenceInTabBar(
                onDateSelected: (date) {
                  // _bloc.GetPaymentHistoryViewData(
                  //    HistoryReqData(endDate: date, pno: pno));

                  // _bloc.GetReferenceIn(

                  //     HistoryReqData(Keyword: "", profileId: 0, endDate: date));
                  // setState(() {
                  //   Filter = "EndDate";
                  // });
                },
                tab_length: 4,
                function: (int index) {
                  if (index == 0)
                    Filter = "ALL";
                  else if (index == 1)
                    Filter = "CM";
                  else if (index == 2) Filter = "TY";

                  getData(SubRefencePostData(
                      data: SubRefeData(
                          duration: Filter,
                          endDate: '',
                          keyword: '',
                          profileId: 0,
                          startDate: '')));

                  if (mounted) setState(() {});
                },
                tabs: ["ALL", "CM", "TY"],
                child: [
                  Filter == "ALL" || Filter == "EndDate"
                      ? isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: referenceData?.length,
                              padding: EdgeInsets.only(top: 16, bottom: 35),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SubRefenceSubUserCard(
                                  capital: referenceData?[index]
                                          .userCapitalAmount
                                          ?.toInt() ??
                                      0,
                                  acd: getFormattedDate(
                                    referenceData?[index].acd ?? DateTime.now(),
                                  ),
                                  userid:
                                      referenceData?[index].userId.toString() ??
                                          "",
                                  username:
                                      referenceData?[index].fullName ?? "",
                                  profileid: referenceData?[index]
                                          .profileId
                                          ?.toInt() ??
                                      0,
                                );
                              })
                      : Container(),
                  Filter == "CM" || Filter == "EndDate"
                      ? isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: referenceData?.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 16, bottom: 35),
                              itemBuilder: (context, index) {
                                return SubRefenceSubUserCard(
                                  capital: referenceData?[index]
                                          .userCapitalAmount
                                          ?.toInt() ??
                                      0,
                                  acd: getFormattedDate(
                                    referenceData?[index].acd ?? DateTime.now(),
                                  ),
                                  userid:
                                      referenceData?[index].userId.toString() ??
                                          "",
                                  username:
                                      referenceData?[index].fullName ?? "",
                                  profileid: referenceData?[index]
                                          .profileId
                                          ?.toInt() ??
                                      0,
                                );
                              })
                      : Container(),
                  Filter == "TY" || Filter == "EndDate"
                      ? isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: referenceData?.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 16, bottom: 35),
                              itemBuilder: (context, index) {
                                return SubRefenceSubUserCard(
                                  capital: referenceData?[index]
                                          .userCapitalAmount
                                          ?.toInt() ??
                                      0,
                                  acd: getFormattedDate(
                                    referenceData?[index].acd ?? DateTime.now(),
                                  ),
                                  userid:
                                      referenceData?[index].userId.toString() ??
                                          "",
                                  username:
                                      referenceData?[index].fullName ?? "",
                                  profileid: referenceData?[index]
                                          .profileId
                                          ?.toInt() ??
                                      0,
                                );
                              })
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubRefenceSubUserCard extends StatefulWidget {
  const SubRefenceSubUserCard(
      {Key? key,
      required this.username,
      required this.userid,
      required this.acd,
      required this.capital,
      required this.profileid})
      : super(key: key);

  final String username;
  final String userid;
  final int profileid;
  final String acd;
  final int capital;

  @override
  State<SubRefenceSubUserCard> createState() => _SubReferenceInCardsState();
}

class _SubReferenceInCardsState extends State<SubRefenceSubUserCard> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppModel model = ScopedModel.of<AppModel>(context);

    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isvisible = !isvisible;
          });
        },
        child: Column(
          children: [
            Container(
              height: 110.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.4),
                    blurRadius: 5.h,
                    spreadRadius: 3.w,
                    offset: Offset(1.h, 4.w),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: model.isDarkTheme
                          ? Color(0xff8E8E8E)
                          : Color(0xffFFAF2A),
                      // Color(0xff189694),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12.0),
                        topRight: const Radius.circular(12.0),
                        bottomLeft: const Radius.circular(0.0),
                        bottomRight: const Radius.circular(0.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: isTablet() ? 6 : 3,
                          child: Container(
                            height: isTablet() ? 50 : 20,
                            width: isTablet() ? 150 : 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(12.0),
                                bottomLeft: const Radius.circular(0.0),
                                bottomRight: const Radius.circular(0.0),
                              ),

                              //contentPadding: EdgeInsets.only(right:5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Container(
                                height: isTablet() ? 50 : 20,
                                width: isTablet() ? 150 : 50,
                                decoration: BoxDecoration(
                                  color: model.isDarkTheme
                                      ? Colors.grey
                                      : Color(0xffFFAF2A),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(12.0),
                                    bottomLeft: const Radius.circular(0.0),
                                    bottomRight: const Radius.circular(0.0),
                                  ),
                                ),
                                child: Center(
                                  //padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    widget.userid,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: model.isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 12.sp,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: isTablet() ? 25 : 9,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Container(
                              height: isTablet() ? 50 : 20,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: model.isDarkTheme
                                    ? Color(0xff8E8E8E)
                                    : Color(0xffFFAF2A),
                                //  Color(0xff0094D5),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(0.0),
                                  topRight: const Radius.circular(12.0),
                                  bottomLeft: const Radius.circular(0.0),
                                  bottomRight: const Radius.circular(0.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      widget.username,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12.sp,
                                            color: model.isDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Capital",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Rs. ",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14.sp,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                Text(
                                  Constant.currencyFormatWithoutDecimal
                                      .format(widget.capital),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 20.sp,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Theme.of(context).cardColor,
                          //  Color(0xFF8E8E8E),
                          radius: 15.h,
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              child: Center(
                                child: Container(
                                  height: 18.h,
                                  width: 18.w,
                                  child: SvgPicture.asset(
                                    "assets/svg/down_arrow.svg",
                                    color: model.isDarkTheme
                                        ? 
                                        Colors.white
                                        : Color(0xff272E6D),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 11.sp,
                                    fontFamily: 'Montserrat',
                                    color: model.isDarkTheme
                                        ? Colors.white
                                        : Color(0xff8E8E8E),
                                    // Color(0xff189694),
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.acd,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                fontSize: 11.sp,
                                fontFamily: 'Montserrat',
                                color: model.isDarkTheme ? null : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(
                          width: 70,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              child: Visibility(
                  visible: isvisible,
                  child: SubReferenceInUserCard(profileid: widget.profileid)),
            )
          ],
        ),
      ),
    );
  }
}

class SubReferenceInUserCard extends StatelessWidget {
  const SubReferenceInUserCard({Key? key, required this.profileid})
      : super(key: key);
  final int profileid;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppModel model = ScopedModel.of<AppModel>(context);

    return Container(
      height: isTablet() ? 150 : 95,
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.4),
            blurRadius: 5.h,
            spreadRadius: 3.w,
            offset: Offset(1.h, 4.w),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: InkWell(
              onTap: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentHistoryView(
                      profileId: this.profileid,
                    ),
                  ),
                );
                //
              },
              child: SubRefeTile(
                textFiled: "Closing\nPayment",
                url: "assets/newassets/colsingPayment.svg",
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileView(
                    profileId: this.profileid,
                  ),
                ),
              );
            },
            child: SubRefeTile(
              textFiled: "View\nProfile",
              url: "assets/newassets/viewProfile.svg",
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentHistoryView(
                    profileId: this.profileid,
                  ),
                ),
              );
            },
            child: SubRefeTile(
              textFiled: "Capital\nHistory",
              url: "assets/svg/newcapital.svg",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecievedAmountView(
                      profileId: this.profileid,
                    ),
                  ),
                );
              },
              child: SubRefeTile(
                textFiled: "Total\nReceived",
                url: "assets/newassets/totalRecived.svg",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubRefeTile extends StatelessWidget {
  SubRefeTile({Key? key, required this.textFiled, required this.url})
      : super(key: key);

  String url;

  String textFiled;

  @override
  Widget build(BuildContext context) {
    AppModel model = ScopedModel.of<AppModel>(context);

    return SizedBox(
      height: isTablet() ? 100 : 65,
      child: Column(
        children: [
          SvgPicture.asset(
            url,
            color: model.isDarkTheme ? Colors.white : Color(0xff8E8E8E),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            textFiled,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: model.isDarkTheme ? Colors.white : Color(0xff404041),
            ),
          )
        ],
      ),
    );
  }
}

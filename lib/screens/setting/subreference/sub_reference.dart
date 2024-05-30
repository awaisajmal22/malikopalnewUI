import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/setting/referenceIn_screen.dart';
import 'package:malikopal/screens/setting/subreference/sub_refence_user.dart';
import 'package:malikopal/screens/setting/subreference/sub_reference_model.dart';
import 'package:malikopal/screens/setting/subreference/sub_reference_post.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/globles.dart';
import 'package:malikopal/utils/shared_pref.dart';
import '../../../ScopedModelWrapper.dart';

import '../../../utils/utility.dart';

class SubReferenceInScreen extends StatefulWidget {
  int profileId;

  SubReferenceInScreen({Key? key, required this.profileId}) : super(key: key);

  @override
  State<SubReferenceInScreen> createState() => _SubReferenceInScreenState();
}

class _SubReferenceInScreenState extends State<SubReferenceInScreen> {
  //int selected = 0;
  int pno = 0;

  late DashBoardBloc _bloc;

  SubRefenceModel? data;

  List<ReferenceNode>? referenceData;

  DashboardRepository dashboardRepository = DashboardRepository();

  String Filter = "ALL";
  int totalCapital = 0;
  num totalClosing = 0;
  int totalMember = 0;

  @override
  void initState() {
    super.initState();
    getData(SubRefencePostData(
        data: SubRefeData(
            duration: Filter,
            endDate: '',
            keyword: '',
            profileId: widget.profileId,
            startDate: '')));
  }

  Future<SubRefenceModel?> getData(SubRefencePostData dataPost) async {
    //
    referenceData?.clear();
    var subReference = await dashboardRepository.getSubRefence(dataPost);

    if (subReference != null) {
      //

      data = subReference;

      var newData = data!.data;

      totalCapital = newData?.totalCapital?.toInt() ?? 0;
      totalClosing = data?.data?.referenceNodes?.fold(
              0,
              (previousValue, element) =>
                  previousValue! + element.recentClosingAmount!) ??
          0;
      totalMember = newData?.memberCount?.toInt() ?? 0;

      referenceData = newData?.referenceNodes;

      setState(() {});

      print(data?.toJson());
      return subReference;
    } else {
      showSnackBar(context, "Error in getting data please try again", true);
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
    AppModel model = ScopedModel.of<AppModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AppBar(
              leading: SizedBox(),
              title: Text(
                "Sub Reference",
                style: TextStyle(
                    color: model.isDarkTheme ? Colors.white : Color(0xff404041),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              elevation: 0.0,
              leadingWidth: 0,
              backgroundColor: Colors.transparent,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xff189694),
                        //Theme.of(context).backgroundColor,
                        shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/images/arrow_back.png',
                      color: Colors.white,
                      height: 17.h,
                      width: 20.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              height: isTablet() ? 250 : null,
              child: SubReferenceIn(
                title_v1: "Sub Reference Capital",
                icon_v1: Center(
                  child: Container(
                      height: 40.h,
                      width: 40.w,
                      child: SvgPicture.asset(
                        'assets/svg/newcapital.svg',
                        color: Colors.grey,
                      )),
                ),
                color_v1: Colors.white,
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
                          color: Colors.white,
                          height: 35,
                          width: 1,
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Flexible(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
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
                                          color: Colors.white,
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
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
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
                ),
                amount_size_v2: totalClosing.toInt(),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 5),
              child: Container(
                height: isTablet() ? 65 : 40,
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
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  ),
                  child: TextFormField(
                    //cursorHeight: 40,
                    keyboardType: TextInputType.text,
                    controller: searchBox,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.sp),
                    onFieldSubmitted: (String value) {
                      //

                      var data = getData(SubRefencePostData(
                          data: SubRefeData(
                              duration: "ALL",
                              endDate: '',
                              keyword: value,
                              profileId: widget.profileId,
                              startDate: '')));

                      //

                      // _bloc.GetReferenceIn(data);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 16, right: 30),
                      hintText: "Name & ID",
                      hintStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: GestureDetector(
                          onTap: () {
                            print(searchBox.text);

                            getData(
                              SubRefencePostData(
                                data: SubRefeData(
                                    duration: "ALL",
                                    endDate: '',
                                    keyword: searchBox.text,
                                    profileId: widget.profileId,
                                    startDate: ''),
                              ),
                            );

                            //
                          },
                          child: Container(
                            height: 22.h,
                            width: 22.w,
                            child: SvgPicture.asset(
                              "assets/svg/search.svg",
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              child: ReferenceInTabBar(
                onDateSelected: (date) {
                  // _bloc.GetCapitalHistoryData(
                  //    HistoryReqData(endDate: date, pno: pno));

                  // _bloc.GetReferenceIn(
                  //     HistoryReqData(Keyword: "", profileId: 0, endDate: date));

                  getData(SubRefencePostData(
                      data: SubRefeData(
                          duration: "EndDate",
                          endDate: date,
                          keyword: "",
                          profileId: widget.profileId,
                          startDate: '')));

                  setState(() {
                    Filter = "EndDate";
                  });
                },
                tab_length: 4,
                function: (int index) {
                  if (index == 0)
                    Filter = "ALL";
                  else if (index == 1)
                    Filter = "CM";
                  else if (index == 2) Filter = "TY";
                  print(Filter + ' : me pressed : ' + index.toString());
                  setState(() {
                    Filter = Filter;
                  });

                  getData(SubRefencePostData(
                      data: SubRefeData(
                          duration: Filter,
                          endDate: '',
                          keyword: "",
                          profileId: widget.profileId,
                          startDate: '')));

                  //_bloc.GetCapitalHistoryData(
                  //    HistoryReqData(duration: Filter, pno: pno));

                  // _bloc.GetReferenceIn(HistoryReqData(
                  //     Keyword: "", profileId: 0, duration: Filter));

                  //
                },
                tabs: ["ALL", "CM", "TY"],
                child: [
                  Filter == "ALL" || Filter == "EndDate"
                      ? SubReferenceInListBuilder(referenceData ?? [])
                      : Container(),
                  Filter == "CM" || Filter == "EndDate"
                      ? SubReferenceInListBuilder(referenceData ?? [])
                      : Container(),
                  Filter == "TY" || Filter == "EndDate"
                      ? SubReferenceInListBuilder(referenceData ?? [])
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubReferenceInListBuilder extends StatelessWidget {
  final List<ReferenceNode> data;

  SubReferenceInListBuilder(this.data);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              padding: EdgeInsets.only(top: 12),
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
                      SubReferenceInCards(
                        nodeData: data[index],
                      ),
                      if (index == data.length - 1)
                        Container(
                          height: 30,
                        )
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class SubReferenceInCards extends StatefulWidget {
  SubReferenceInCards({Key? key, required this.nodeData}) : super(key: key);

  // final String username;
  // final String userid;
  // final int profileid;
  // final String acd;
  // final int capital;

  final ReferenceNode nodeData;

  @override
  State<SubReferenceInCards> createState() => _SubReferenceInCardsState();
}

class _SubReferenceInCardsState extends State<SubReferenceInCards> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AppModel model = ScopedModel.of<AppModel>(context);

    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Container(
            height: 110.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Color(0xff189694),
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
                              width: isTablet() ? 100 : 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
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
                                  widget.nodeData.userId ?? '',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.white,
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
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Container(
                            height: isTablet() ? 50 : 20,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Color(0xff189694),
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
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      widget.nodeData.fullName ?? '',
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                          ),
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Capital",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                                    .format(widget.nodeData.userCapitalAmount),
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
                      ReferenceInScreen.showData
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(0xFF8E8E8E),
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
                                            "assets/svg/down_arrow.svg"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
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
                        "ACD ",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 11.sp,
                              fontFamily: 'Montserrat',
                              color: Color(0xff189694),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        getFormattedDate(widget.nodeData.acd ?? DateTime.now()),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 11.sp,
                              fontFamily: 'Montserrat',
                              color: model.isDarkTheme
                                  ? Colors.white
                                  : Colors.black,
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
          Visibility(
            visible: isvisible,
            child: SubReferenceInBriefCard(
              profileid: widget.nodeData.profileId?.toInt() ?? 0,
              capital: widget.nodeData.memberCapital ?? 0,
              name: widget.nodeData.fullName ?? '',
              closingPayment: widget.nodeData.recentClosingAmount?.toInt() ?? 0,
              members: widget.nodeData.memberCount?.toInt() ?? 0,
            ),
          )
        ],
      ),
    );
  }
}

class SubReferenceInBriefCard extends StatelessWidget {
  const SubReferenceInBriefCard(
      {Key? key,
      required this.profileid,
      required this.capital,
      required this.closingPayment,
      required this.name,
      required this.members})
      : super(key: key);

  final int profileid;
  final num capital;
  final num closingPayment;
  final num members;
  final String name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppModel model = ScopedModel.of<AppModel>(context);
    return Container(
      height: isTablet() ? 140 : 100,
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10),
      margin: EdgeInsets.only(bottom: 23),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Expanded(
            flex: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Capital",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          color: model.isDarkTheme
                              ? Colors.white
                              : Color(0xff8E8E8E)),
                    ),
                    // Text(
                    //   "Rs.  ${capital}",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w400, color: Colors.black),
                    // )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Closing Payment",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          color: model.isDarkTheme
                              ? Colors.white
                              : Color(0xff8E8E8E)),
                    ),
                    // Text(
                    //   "Rs. ${closingPayment}",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w400, color: Colors.black),
                    // )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Members",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                          color: model.isDarkTheme
                              ? Colors.white
                              : Color(0xff8E8E8E)),
                    ),
                    // Text(
                    //   members.toString(),
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w400, color: Colors.black),
                    // )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              flex: 30,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   "Capital",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 13,
                      //       color: Color(0xff8E8E8E)),
                      // ),
                      Text(
                        "Rs.  ${capital}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: model.isDarkTheme
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   "Closing Payment",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 13,
                      //       color: Color(0xff8E8E8E)),
                      // ),
                      Text(
                        "Rs. ${closingPayment}",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: model.isDarkTheme
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   "Members",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 13,
                      //       color: Color(0xff8E8E8E)),
                      // ),
                      Text(
                        members.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: model.isDarkTheme
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  ),
                ],
              )),
          Spacer(),
          InkWell(
            onTap: () {
              toNext(SubRefenceUserScreen(
                userId: profileid,
                name: name,
              ));
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff1164AA)),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 0.0.w, vertical: 10),
    //   child: Container(
    //     height: isTablet() ? 230 : 100,
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).cardColor,
    //       borderRadius: BorderRadius.circular(15),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Theme.of(context).shadowColor.withOpacity(0.4),
    //           blurRadius: 5.h,
    //           spreadRadius: 3.w,
    //           offset: Offset(1.h, 4.w),
    //         ),
    //       ],
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => PaymentHistory(
    //                   profileId: this.profileid,
    //                 ),
    //               ),
    //             );
    //           },
    //           child: Container(
    //             width: isTablet() ? 100 : size.width / 4 - 20,
    //             decoration: BoxDecoration(color: Theme.of(context).cardColor),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 SvgPicture.asset(
    //                   'assets/svg/total_rec.svg',
    //                   height: 20,
    //                   width: 20,
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 SizedBox(
    //                   width: isTablet() ? null : 50,
    //                   child: Center(
    //                     child: Text(
    //                       'Closing Payment',
    //                       textAlign: TextAlign.center,
    //                       style:
    //                           Theme.of(context).textTheme.bodyText2!.copyWith(
    //                                 fontSize: 10.sp,
    //                                 fontFamily: 'Montserrat',
    //                                 fontWeight: FontWeight.w400,
    //                               ),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => ProfileScreen(
    //                   profileId: this.profileid,
    //                 ),
    //               ),
    //             );
    //           },
    //           child: Container(
    //             width: size.width / 4 - 20,
    //             decoration: BoxDecoration(color: Theme.of(context).cardColor),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 SvgPicture.asset(
    //                   'assets/svg/pro.svg',
    //                   height: 20,
    //                   width: 20,
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 SizedBox(
    //                   width: isTablet() ? null : 50,
    //                   child: Center(
    //                     child: Text(
    //                       'View Profile',
    //                       textAlign: TextAlign.center,
    //                       style:
    //                           Theme.of(context).textTheme.bodyText2!.copyWith(
    //                                 fontSize: 10.sp,
    //                                 fontFamily: 'Montserrat',
    //                                 fontWeight: FontWeight.w400,
    //                               ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => CapitalHistory(
    //                   profileId: this.profileid,
    //                 ),
    //               ),
    //             );
    //           },
    //           child: Container(
    //             width: size.width / 4 - 20,
    //             decoration: BoxDecoration(color: Theme.of(context).cardColor),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 SvgPicture.asset(
    //                   'assets/svg/capital_history.svg',
    //                   height: 20,
    //                   width: 20,
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 SizedBox(
    //                   width: isTablet() ? null : 50,
    //                   child: Center(
    //                     child: Text(
    //                       'Capital History',
    //                       textAlign: TextAlign.center,
    //                       style:
    //                           Theme.of(context).textTheme.bodyText2!.copyWith(
    //                                 fontSize: 10.sp,
    //                                 fontFamily: 'Montserrat',
    //                                 fontWeight: FontWeight.w400,
    //                               ),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => RecievedAmount(
    //                   profileId: this.profileid,
    //                 ),
    //               ),
    //             );
    //           },
    //           child: Container(
    //             width: size.width / 4 - 20,
    //             decoration: BoxDecoration(color: Theme.of(context).cardColor),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 SvgPicture.asset(
    //                   'assets/svg/total_rec.svg',
    //                   height: 20,
    //                   width: 20,
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 SizedBox(
    //                   width: isTablet() ? null : 50,
    //                   child: Center(
    //                     child: Text(
    //                       'Total Received',
    //                       textAlign: TextAlign.center,
    //                       style:
    //                           Theme.of(context).textTheme.bodyText2!.copyWith(
    //                                 fontSize: 10.sp,
    //                                 fontFamily: 'Montserrat',
    //                                 fontWeight: FontWeight.w400,
    //                               ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

//---------------------
class ReferenceInTabBar extends StatefulWidget {
  const ReferenceInTabBar(
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
  State<ReferenceInTabBar> createState() => _ReferenceInTabBarState();
}

class _ReferenceInTabBarState extends State<ReferenceInTabBar>
    with TickerProviderStateMixin {
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
      return selectedDate;
    }
    return datePicked;
  }

  // bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    AppModel model = ScopedModel.of<AppModel>(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 09,
              child: Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: model.isDarkTheme == false
                        ? Colors.grey.withOpacity(0.4)
                        : Color.fromARGB(255, 120, 121, 121),
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
                    labelColor: model.isDarkTheme ? Colors.white : Colors.black,
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
                                          : model.isDarkTheme == true
                                              ? Colors.white
                                              : Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(08),
                              color: _selectedIndex == i
                                  ? Colors.white
                                  : Colors.transparent),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),

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
            height: size.height * 0.54.h,
            width: double.maxFinite,
            child: TabBarView(
                controller: _tabControllerV2, children: widget.child)),
      ],
    );
  }
}

class SubReferenceIn extends StatelessWidget {
  const SubReferenceIn(
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
  final Color? color_v1, color_v2;
  final Widget? trailing_v1, trailing_v2;
  final int? amount_size_v2;
  final double? amount_size, title_size_v1, titlesize_v2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.w),
      child: Container(
        height: isTablet() ? 236 : 200.0,
        decoration: BoxDecoration(
          color: Color(0xff189694),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.4),
              blurRadius: 3.h,
              spreadRadius: 2.w,
              offset: Offset(1.h, 4.w),
            ),
          ],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: CircleAvatar(
                  radius: 25.h, backgroundColor: color_v1, child: icon_v1),
            ),
            title: Text(
              "Sub Reference Capital",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 13.sp,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            subtitle: Text(
              subtitle_v1 ?? "",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: amount_size ?? 18.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
            trailing: Column(
              children: [trailing_v1 ?? Container()],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12, bottom: 0, top: 5),
            child: Container(
              width: double.infinity,
              height: isTablet() ? 120 : 95,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.3),
                    blurRadius: 4.h,
                    spreadRadius: 3.w,
                    offset: Offset(1.w, 3.h),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      alignment: Alignment.center,
                      height: isTablet() ? 100 : 75,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.3),
                            blurRadius: 4.h,
                            spreadRadius: 3.w,
                            offset: Offset(1.w, 3.h),
                          ),
                        ],
                      ),
                      child: Text(
                        'Sub \Ref \nClosing \nPayment',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: amount_size ?? 12.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Rs. ',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 18.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                          ),
                        ),
                        Text(
                          Constant.currencyFormatWithoutDecimal
                              .format(amount_size_v2),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: amount_size ?? 24.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

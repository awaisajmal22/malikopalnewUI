import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:malikopal/model/requestbody/HistoryReqBody_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/model/ReferenceInResponse_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/setting/capital_history.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/setting/profile_screen.dart';
import 'package:malikopal/screens/setting/recieved_amount.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/shared_pref.dart';
import '../../ScopedModelWrapper.dart';
import '../../model/DashboardResponse_model.dart';
import '../../utils/utility.dart';
import '../widgets/loading_dialog.dart';
import 'payment_history.dart';
import 'subreference/sub_reference.dart';

class ReferenceInScreen extends StatefulWidget {
  ReferenceInScreen({
    Key? key,
  }) : super(key: key);

  static bool showData = false;

  @override
  State<ReferenceInScreen> createState() => _ReferenceInScreenState();
}

class _ReferenceInScreenState extends State<ReferenceInScreen> {
  //int selected = 0;
  int pno = 0;
  late DashBoardBloc _bloc;
  RefrenceInResponseDataModel? data;
  String Filter = "ALL";
  int totalCapital = 0;
  num totalClosing = 0;
  int totalMember = 0;
  DashboardResponseDataModel? responc;
  @override
  void initState() {
    _bloc = DashBoardBloc();
    _bloc.getDashboardData();
    _bloc.dashboardResponseStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        setState(() {
          responc = event.data;
        });

        print('new Data is here');

        // print(data?.toJson());

        SessionData().setUserProfile(responc);
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();

        //

        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showIndicator();
      }
    });
    _bloc.GetReferenceInStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        dp(
            msg: "Reference nodes lenght",
            arg: data?.data?.referenceNodes?.length);
        data = event.data;
        totalCapital = data?.data?.totalCapital?.toInt() ?? 0;
        totalClosing = data?.data?.referenceNodes?.fold(
                0,
                (previousValue, element) =>
                    previousValue! + element.recentClosingAmount!) ??
            0;
        totalMember = data?.data?.memberCount?.toInt() ?? 0;
        setState(() {});
        print(data?.toJson());
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });
    _bloc.GetReferenceIn(
        HistoryReqDataModel(Keyword: "", duration: "ALL", profileId: 0));

    super.initState();
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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            CustomTopBar(
              backButtonColor:
                  isDarkThemeEnabled(context) ? Colors.white : Colors.black,
              topbartitle: 'Reference',
              action: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return SubReferenceInScreen(
                      profileId: 0,
                    );
                  }));
                },
                child: responc?.IsSubReferenceAllowed == true
                    ? Card(
                        color: Colors.grey[800],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Sub Reference",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ))
                    : SizedBox.shrink(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              height: isTablet() ? 250 : null,
              child: Referencein(
                title_v1: "Reference Capital",
                subtitle_v2: 'Members Closing Payment',
                icon_v1: Center(
                  child: Container(
                      height: 30.h,
                      width: 30.w,
                      child: SvgPicture.asset('assets/svg/newcapital.svg')),
                ),
                color_v1: Colors.white,
                //  Color(0XFFF6921E),
                subtitle_v1:
                    Constant.currencyFormatWithoutDecimal.format(totalCapital),
                trailing_v1: Flexible(
                  child: Container(
                    width: 90,
                    height: 70,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [Color(0xff1F5FA2), Color(0xff272E6D)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                          // color:
                          // //  Colors.white,
                          height: 35,
                          width: 1,
                          margin: EdgeInsets.only(right: 5),
                        ),
                        Flexible(
                          child: FittedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' Members',
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
                                        // Colors.white,
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
                    textAlign: TextAlign.left,

                    style: TextStyle(fontSize: 18.sp),
                    onFieldSubmitted: (String value) {
                      var data = new HistoryReqDataModel(
                          Keyword: value, duration: "ALL", profileId: 0);

                      //

                      _bloc.GetReferenceIn(data);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 14, right: 50),
                      hintText: "Name & ID",
                      hintStyle: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: GestureDetector(
                          onTap: () {
                            print(searchBox.text);

                            var data = new HistoryReqDataModel(
                                Keyword: searchBox.text,
                                duration: "ALL",
                                profileId: 0);

                            _bloc.GetReferenceIn(data);

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
              height: 12,
            ),
            SingleChildScrollView(
              child: ReferenceInTabBar(
                onDateSelected: (date) {
                  // _bloc.GetPaymentHistoryViewData(
                  //    HistoryReqData(endDate: date, pno: pno));

                  _bloc.GetReferenceIn(HistoryReqDataModel(
                      Keyword: "", profileId: 0, endDate: date));
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
                  else if (index == 2) Filter = "1Y";
                  print(Filter + ' : me pressed : ' + index.toString());
                  setState(() {
                    Filter = Filter;
                  });
                  //_bloc.GetPaymentHistoryViewData(
                  //    HistoryReqData(duration: Filter, pno: pno));

                  _bloc.GetReferenceIn(HistoryReqDataModel(
                      Keyword: "", profileId: 0, duration: Filter));
                },
                tabs: ["ALL", "CM", "1Y"],
                child: [
                  Filter == "ALL" || Filter == "EndDate"
                      ? StreamBuilder<ApiResponse<RefrenceInResponseDataModel>>(
                          stream: _bloc.GetReferenceInStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch ((snapshot.data?.status ?? "")) {
                                case Status.LOADING:
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                  );
                                //break;
                                case Status.COMPLETED:
                                  dp(
                                      msg: "Nodes",
                                      arg: snapshot.data?.data?.data
                                          ?.referenceNodes?.length);

                                  if (snapshot.data?.data?.data?.referenceNodes
                                          ?.isNotEmpty ??
                                      false)
                                    return ReferenceInListBuilder(snapshot
                                            .data?.data?.data?.referenceNodes ??
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
                  Filter == "CM" || Filter == "EndDate"
                      ? StreamBuilder<ApiResponse<RefrenceInResponseDataModel>>(
                          stream: _bloc.GetReferenceInStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch ((snapshot.data?.status ?? "")) {
                                case Status.LOADING:
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10
                                            .h), //child: Loading(loadingMessage: snapshot.data.message),
                                  );
                                //break;
                                case Status.COMPLETED:
                                  if (snapshot.data?.data?.data?.referenceNodes
                                          ?.isNotEmpty ??
                                      false)
                                    return ReferenceInListBuilder(snapshot
                                            .data?.data?.data?.referenceNodes ??
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
                  Filter == "1Y" || Filter == "EndDate"
                      ? StreamBuilder<ApiResponse<RefrenceInResponseDataModel>>(
                          stream: _bloc.GetReferenceInStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch ((snapshot.data?.status ?? "")) {
                                case Status.LOADING:
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                  );
                                //break;
                                case Status.COMPLETED:
                                  if (snapshot.data?.data?.data?.referenceNodes
                                          ?.isNotEmpty ??
                                      false)
                                    return ReferenceInListBuilder(snapshot
                                            .data?.data?.data?.referenceNodes ??
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReferenceInListBuilder extends StatelessWidget {
  final List<ReferenceNode> data;

  ReferenceInListBuilder(this.data);

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
              padding: EdgeInsets.only(top: 12),
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
                      ReferenceInCards(
                        capital: data[index].userCapitalAmount?.toInt() ?? 0,
                        acd: data[index].acd.toString(),
                        userid: data[index].userId.toString(),
                        username: data[index].fullName ?? "",
                        profileid: data[index].profileId?.toInt() ?? 0,
                      ),
                      if (index == data.length - 1)
                        Container(
                          height: 80,
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

class ReferenceInCards extends StatefulWidget {
  const ReferenceInCards(
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
  State<ReferenceInCards> createState() => _ReferenceInCardsState();
}

class _ReferenceInCardsState extends State<ReferenceInCards> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppModel model = ScopedModel.of<AppModel>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: Column(
        children: [
          Container(
            height: isTablet() ? 125.h : 110.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(25),
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
                    color: Color(0xff254180),
                    // Color(0xff1164AA),
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
                              width: isTablet() ? 150 : 100,
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
                                  widget.userid,
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
                              color: Color(0xff254180),
                              //  Color(0xff1164AA),
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
                                          color: Colors.white,
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
                      ReferenceInScreen.showData
                          ? InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFF6921E),
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
                          : SizedBox()
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
                              color: Color(0xff254180),
                              //  Color(0xff1164AA),
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        getFormattedDate(DateTime.parse(widget.acd)),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
            height: 10.h,
          ),
          Container(
            child: Visibility(
                visible: isvisible,
                child: ReferenceInBriefCard(profileid: widget.profileid)),
          )
        ],
      ),
    );
  }
}

class ReferenceInBriefCard extends StatelessWidget {
  const ReferenceInBriefCard({Key? key, required this.profileid})
      : super(key: key);
  final int profileid;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.w, vertical: 10),
      child: Container(
        height: isTablet() ? 140 : 100,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
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
              child: SizedBox(
                width: isTablet() ? 100 : size.width / 4 - 20,

                // decoration: BoxDecoration(color: Theme.of(context).cardColor,),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/total_rec.svg',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: isTablet() ? null : 50,
                      child: Center(
                        child: Text(
                          'Closing Payment',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 8.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
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
              child: SizedBox(
                width: size.width / 4 - 20,
                // decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/pro.svg',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: isTablet() ? null : 50,
                      child: Center(
                        child: Text(
                          'View Profile',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 8.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
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
              child: SizedBox(
                width: size.width / 4 - 20,
                // decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/capital_history.svg',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: isTablet() ? null : 50,
                      child: Center(
                        child: Text(
                          'Capital History',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 8.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
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
              child: SizedBox(
                width: size.width / 4 - 20,
                // decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/total_rec.svg',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: isTablet() ? null : 50,
                      child: Center(
                        child: Text(
                          'Total Received',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 8.sp,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          children: [
            Expanded(
              flex: 09,
              child: Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: darkTheme == false
                        ? Colors.white
                        //  Colors.grey.withOpacity(0.4)
                        : Color.fromARGB(255, 120, 121, 121),
                  ),
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                      insets: EdgeInsets.all(1),
                    ),
                    indicatorWeight: 0,
                    indicatorColor: darkTheme == false
                        ? Colors.white
                        //  Colors.grey.withOpacity(0.4)
                        : Color.fromARGB(255, 120, 121, 121),
                    //  Theme.of(context).shadowColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabControllerV2,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    labelColor: darkTheme ? Colors.white : Colors.black,
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
                                              ? Colors.white
                                              : Colors.black.withOpacity(0.32),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(08),
                              color: _selectedIndex == i
                                  ? Color(0xffACBBF3)
                                  // Colors.white
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

class Referencein extends StatelessWidget {
  Referencein(
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
      this.color2 = const Color(0xff254180),
      //  const Color(0xff1164AA),
      this.bgColor = const Color(0xff254180),
      // Color(0xff1164AA),
      this.titlesize_v2})
      : super(key: key);
  final String? title_v1, subtitle_v1;
  final String? title_v2, subtitle_v2;
  final Widget? icon_v1, icon_v2;
  final Color? color_v1, color_v2;
  final Widget? trailing_v1, trailing_v2;
  final int? amount_size_v2;
  final double? amount_size, title_size_v1, titlesize_v2;
  final Color bgColor;
  Color color2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0.w),
      child: Container(
        height: isTablet() ? 230 : 200.0,
        decoration: BoxDecoration(
          color: Color(0xffACBBF3),
          // bgColor,
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
              title_v1 ?? '',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 13.sp,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    //  Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            subtitle: Text(
              subtitle_v1 ?? "",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: amount_size ?? 18.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    //  Colors.white,
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
                // color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [Color(0xff1F5FA2), Color(0xff272E6D)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Theme.of(context).shadowColor.withOpacity(0.3),
                //     blurRadius: 4.h,
                //     spreadRadius: 3.w,
                //     offset: Offset(1.w, 3.h),
                //   ),
                // ],
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
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                        color: Colors.white,
                      ))
                          // color: color2,
                          // borderRadius: BorderRadius.circular(20),
                          // gradient: LinearGradient(
                          //   colors: [Color(0xff1F5FA2), Color(0xff272E6D)],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // )),

                          // boxShadow: [
                          //   BoxShadow(
                          //     color:
                          //         Theme.of(context).shadowColor.withOpacity(0.3),
                          //     blurRadius: 4.h,
                          //     spreadRadius: 3.w,
                          //     offset: Offset(1.w, 3.h),
                          //   ),
                          // ],
                          ),
                      child: Text(
                        subtitle_v2 ?? '',
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
                                      color: Colors.white,
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
                                    color: Colors.white,
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

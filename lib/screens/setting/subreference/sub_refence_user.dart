import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/setting/capital_history.dart';
import 'package:malikopal/screens/setting/recieved_amount.dart';
import 'package:malikopal/screens/setting/subreference/reference_user.dart';

import 'package:malikopal/screens/setting/subreference/sub_reference_post.dart';
import 'package:malikopal/utils/utility.dart';
import '../../../utils/Const.dart';
import '../components/setting.widgets.dart';
import '../payment_history.dart';
import '../profile_screen.dart';

class SubRefenceUserScreen extends StatefulWidget {
  const SubRefenceUserScreen(
      {Key? key, required this.userId, required this.name})
      : super(key: key);

  final int userId;
  final String name;

  @override
  State<SubRefenceUserScreen> createState() => _SubRefenceUserScreenState();
}

class _SubRefenceUserScreenState extends State<SubRefenceUserScreen> {
  int totalCapital = 0;
  int totalClosing = 0;
  int totalMember = 0;

  List<ReferenceNode>? referenceData;

  DashboardRepository dashboardRepository = DashboardRepository();

  RefrenceInUserModel? data;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData(SubRefencePostData(
        data: SubRefeData(
            duration: "All",
            endDate: '',
            keyword: '',
            profileId: widget.userId,
            startDate: '')));
  }

  Future<RefrenceInUserModel?> getData(SubRefencePostData dataPost) async {
    //
    isLoading = true;
    if (mounted) setState(() {});
    referenceData?.clear();
    var subReference = await dashboardRepository.getSubUserRefence(dataPost);

    dp(msg: "Sub user", arg: subReference?.data?.referenceNodes?.length);

    if (subReference != null) {
      //

      data = subReference;

      var newData = data!.data;

      totalCapital = newData?.totalCapital?.toInt() ?? 0;
      totalClosing = newData?.totalClosing?.toInt() ?? 0;
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              leading: SizedBox(),
              title: Text(
                widget.name,
                style: TextStyle(
                    color: Color(0xff404041),
                    fontWeight: FontWeight.w700,
                    fontSize: 17),
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
            Padding(
              padding:
                  const EdgeInsets.only(left: 2, right: 2, bottom: 10, top: 20),
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
                      var data = getData(SubRefencePostData(
                          data: SubRefeData(
                              duration: "ALL",
                              endDate: '',
                              keyword: value,
                              profileId: widget.userId,
                              startDate: '')));

                      // _bloc.GetReferenceIn(data);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 20, right: 50),
                      hintText: "Name & ID",

                      hintStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                      icon: Padding(
                        padding: EdgeInsets.only(
                          left: 18,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            print(searchBox.text);
                            // var data = new HistoryReqData(
                            //     Keyword: searchBox.text,
                            //     duration: "ALL",
                            //     profileId: 0);
                            // _bloc.GetReferenceIn(data);

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
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (referenceData?.isEmpty ?? true)
                    ? Center(
                        child: Text("Empty Data"),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: referenceData?.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 12),
                            itemBuilder: (context, index) {
                              return SubReferenceUserCard(
                                capital: referenceData?[index]
                                        .userCapitalAmount
                                        ?.toInt() ??
                                    0,
                                acd: getFormattedDate(
                                    referenceData?[index].acd ??
                                        DateTime.now()),
                                userid: referenceData?[index].userId ?? "",
                                username: referenceData?[index].fullName ?? "",
                                profileid:
                                    referenceData?[index].profileId?.toInt() ??
                                        0,
                              );
                            }),
                      )
          ],
        ),
      ),
    );
  }
}

class SubReferenceUserCard extends StatefulWidget {
  const SubReferenceUserCard(
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
  State<SubReferenceUserCard> createState() => _SubReferenceInCardsState();
}

class _SubReferenceInCardsState extends State<SubReferenceUserCard> {
  bool isvisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        left: 12.0.w,
        right: 12.0.w,
      ),
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
                          flex: 3,
                          child: Container(
                            height: 20,
                            width: 100,
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
                                height: 20,
                                width: 50,
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
                          "ACD ",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 11.sp,
                                    fontFamily: 'Montserrat',
                                    color: Color(0xff1164AA),
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        Text(
                          widget.acd,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 11.sp,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
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
              height: 25.h,
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
    return Container(
      height: isTablet() ? 225 : 90,
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10),
      margin: EdgeInsets.only(bottom: 26),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22),
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
        children: [
          InkWell(
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
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
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
              url: "assets/newassets/PaymentHistoryView.svg",
            ),
          ),
          InkWell(
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
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
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
    return SizedBox(
      height: 65,
      child: Column(
        children: [
          SvgPicture.asset(url),
          SizedBox(
            height: 6,
          ),
          Text(
            textFiled,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

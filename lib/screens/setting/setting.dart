import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malikopal/utils/utility.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:malikopal/model/DashboardResponse_model.dart';
import 'package:malikopal/networking/Endpoints.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/main_setting.dart';
import 'package:malikopal/screens/setting/change_password.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';

import 'package:malikopal/utils/shared_pref.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const routeName = '/setting-screen';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  DashboardResponseDataModel data = DashboardResponseDataModel(
      isClosingDays: false,
      IsRefrenceInAllowed: false,
      IsShowDataAllowed: false,
      IsShowListAllowed: false,
      IsSubReferenceAllowed: false);

  late SharedPreferences preferences;
  String note = '';

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();

    //
    getData();
    SessionData().getUserProfile().then(
          (value) => setState(() {
            data = value;
          }),
        );
  }

  getData() async {
    //
    textEditingController = TextEditingController();

    preferences = await SharedPreferences.getInstance();

    await preferences.reload();

    note = await preferences.getString("note") ?? '';

    textEditingController.text = note;

    dp(msg: "Note", arg: note);

    if (mounted) setState(() {});
  }

  /// Get from gallery
  ///
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint("$size");
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HideCapitalView(),
          ),
        );
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: AnimatedBottomNavBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff1F5FA2),
            Color(0xff272E6D),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          height: isTablet() ? size.height + 15 : size.height - 20,
          // margin: EdgeInsets.symmetric(horizontal: 14),
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40.h,
              ),
              CustomTopBar(
                topbartitle: 'Settings',
              ),
              Expanded(
                  child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: size.height * 0.69,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      color: isDarkThemeEnabled(context)
                          ? Color(0xff585959)
                          : Color(0xFFFFFFFF),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.1,
                            width: size.width * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                  data.image == null
                                      ? Endpoints.noProfilePicUrl
                                      : (Endpoints.profilePicUrl +
                                          data.image.toString()),
                                )),
                                color: Colors.white,
                                shape: BoxShape.circle),
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) => LinearGradient(
                                    colors: isDarkThemeEnabled(context)
                                        ? [
                                            Colors.white,
                                            Colors.white.withOpacity(0.6)
                                          ]
                                        : [
                                            Color(0xff1F5FA2),
                                            Color(0xff272E6D)
                                          ])
                                .createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              data.fullName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) => LinearGradient(
                                    colors: isDarkThemeEnabled(context)
                                        ? [
                                            Colors.white,
                                            Colors.white.withOpacity(0.6)
                                          ]
                                        : [
                                            Color(0xff1F5FA2),
                                            Color(0xff272E6D)
                                          ])
                                .createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              data.UserName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        duration: Duration(milliseconds: 300),
                                        child: ChangePassword()),
                                  );
                                },
                                child: SettingList(
                                  labelText: 'Password',
                                  trailinig: Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                              SettingList(
                                labelText: 'Touch/Face ID',
                                trailinig: SettingSwitcher(),
                              ),
                              // SettingList(
                              //   labelText: 'Dashboard',
                              //   trailinig: GlowSetting(),
                              // ),
                              SettingList(
                                labelText: 'Glow',
                                trailinig: GlowSetting(),
                              ),
                              SettingList(
                                labelText: 'Dark Mode',
                                trailinig: Appearence(),
                              ),
                              // SettingList(
                              //   labelText: 'Motion',
                              //   trailinig: SettingSwitcher3(),
                              // ),
                            ],
                          ),
                        ],
                      )),
                ],
              ))
              // Flexible(
              //   flex: 2,
              //   child: TopWidgets(),
              // ),

              // Flexible(
              //   flex: isTablet() ? 13 : 9,
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Container(
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey.withOpacity(0.2),
              //               blurRadius: 18.h,
              //               spreadRadius: 05.w,
              //               offset: Offset(2.w, 3.h),
              //             )
              //           ],
              //           borderRadius: BorderRadius.circular(25),
              //           gradient: LinearGradient(
              //             begin: Alignment.topLeft,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               // Color(0xffEEC32D),
              //               // Color(0xffF6322A),
              //               Color(0xff254180),
              //               Color(0xff254180),
              //               // Color(0xff1164AA),
              //               // Color(0xff1164AA)
              //             ],
              //           ),
              //         ),
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(
              //               vertical: 5.h, horizontal: 12.w),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Container(
              //                 height:
              //                     isTablet() ? 200 : size.height * 0.15.h,
              //                 margin: EdgeInsets.all(4),
              //                 decoration: BoxDecoration(
              //                     color: Colors.red,
              //                     shape: BoxShape.circle,
              //                     border: Border.all(
              //                       color: Colors.white,
              //                       width: 2.w,
              //                     )),
              //                 child: GestureDetector(
              //                   onTap: () {},
              //                   child: CircleAvatar(
              //                     radius: isTablet() ? 85 : 55,
              //                     backgroundImage: NetworkImage(
              //                         data.image == null
              //                             ? Endpoints.noProfilePicUrl
              //                             : (Endpoints.profilePicUrl +
              //                                 data.image.toString())),
              //                   ),
              //                 ),
              //               ),
              //               Text(
              //                 data.fullName ?? "",
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodyText1!
              //                     .copyWith(
              //                       fontSize: 22.sp,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //               ),
              //               Text(
              //                 data.UserName ?? "",
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodyText1!
              //                     .copyWith(
              //                       fontSize: 18.sp,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w300,
              //                     ),
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               )
              //               // Flexible(
              //               //   flex: isTablet() ? 0 : 1,
              //               //   child: ListTile(
              //               //     title: Center(
              //               //       child:,
              //               //     ),
              //               //     subtitle: Center(
              //               //       child: Padding(
              //               //         padding: const EdgeInsets.all(8.0),
              //               //         child: ,
              //               //       ),
              //               //     ),
              //               //   ),
              //               // ),
              //               // Flexible(
              //               //   flex: isTablet() ? 2 : 1,
              //               //   child: Padding(
              //               //     padding: EdgeInsets.symmetric(
              //               //         horizontal: 30.w, vertical: 10.h),
              //               //     child: Row(
              //               //       mainAxisAlignment:
              //               //           MainAxisAlignment.spaceAround,
              //               //       children: [
              //               //         GestureDetector(
              //               //           onTap: () {
              //               //             Navigator.push(
              //               //               context,
              //               //               MaterialPageRoute(
              //               //                 builder: (context) =>
              //               //                     ProfileScreen(),
              //               //               ),
              //               //             );
              //               //           },
              //               //           child: SmallRadiusButton(
              //               //             text: "View Profile",
              //               //             color: [
              //               //               Color(0xFFFAFAFA),
              //               //               Color(0xFFFAFAFA)
              //               //             ],
              //               //           ),
              //               //         ),
              //               //         GestureDetector(
              //               //           onTap: () {
              //               //             Navigator.push(
              //               //               context,
              //               //               MaterialPageRoute(
              //               //                 builder: (context) =>
              //               //                     MainSettings(),
              //               //               ),
              //               //             );
              //               //           },
              //               //           child: SmallRadiusButton(
              //               //             text: 'App Setting',
              //               //             color: [
              //               //               Color(0xFFFAFAFA),
              //               //               Color(0xFFFAFAFA)
              //               //             ],
              //               //           ),
              //               //         ),
              //               //       ],
              //               //     ),
              //               //   ),
              //               // ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // ListView(
              //   scrollDirection: Axis.vertical,
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           PageTransition(
              //               type: PageTransitionType.leftToRight,
              //               duration: Duration(milliseconds: 300),
              //               child: ChangePassword()),
              //         );
              //       },
              //       child: SettingList(
              //         labelText: 'Password',
              //         trailinig: Icon(Icons.arrow_forward_ios),
              //       ),
              //     ),
              //     SettingList(
              //       labelText: 'Touch/Face ID',
              //       trailinig: SettingSwitcher(),
              //     ),
              //     // SettingList(
              //     //   labelText: 'Dashboard',
              //     //   trailinig: GlowSetting(),
              //     // ),
              //     SettingList(
              //       labelText: 'Glow',
              //       trailinig: GlowSetting(),
              //     ),
              //     SettingList(
              //       labelText: 'Dark Mode',
              //       trailinig: Appearence(),
              //     ),
              //     // SettingList(
              //     //   labelText: 'Motion',
              //     //   trailinig: SettingSwitcher3(),
              //     // ),
              //   ],
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // Flexible(
              //   flex: isTablet() ? 6 : 4,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 12.w),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         Flexible(
              //           flex: 08,
              //           child: GestureDetector(
              //             onTap: () {
              //               //

              //               Navigator.push(
              //                 context,
              //                 PageTransition(
              //                     type: PageTransitionType.leftToRight,
              //                     duration: Duration(milliseconds: 300),
              //                     child: ChangePassword()),
              //               );
              //             },
              //             child: Cards(
              //               title: 'Change  Password',
              //               iconPath:
              //                   "assets/newassets/passwordCahange.svg",
              //             ),
              //           ),
              //         ),
              //         Spacer(),
              //         Flexible(
              //           flex: 08,
              //           child: GestureDetector(
              //             //update bank detail-->
              //             onTap: () {
              //               //

              //               Navigator.push(
              //                 context,
              //                 PageTransition(
              //                   type: PageTransitionType.leftToRight,
              //                   duration: Duration(milliseconds: 300),
              //                   child: MainSettings(),
              //                 ),
              //               );

              //               //
              //             },
              //             child: Cards(
              //               title: 'Setting \nApp',
              //               iconPath: "assets/newassets/newSettingApp.svg",
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 12, right: 12, top: 20),
              //   child: SizedBox(
              //     height: 150,
              //     child: Card(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20)),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: TextField(
              //           maxLines: 10,
              //           controller: textEditingController,
              //           decoration: InputDecoration(
              //               border: InputBorder.none,
              //               hintText: "Note",
              //               hintStyle: TextStyle(color: Colors.grey)),
              //           onChanged: (value) async {
              //             //
              //             await preferences.setString('note', value);
              //             print(value);
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 35.h,
              // ),
              // Flexible(
              //   flex: 04,
              //   child: Container(
              //     alignment: Alignment.center,
              //     margin: EdgeInsets.symmetric(horizontal: 12.w),
              //     height: size.width * 0.50.h,
              //     decoration: BoxDecoration(
              //       color: Theme.of(context).cardColor,
              //       borderRadius: BorderRadius.circular(30),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Theme.of(context).shadowColor,
              //           blurRadius: 18.h,
              //           spreadRadius: 05.w,
              //           offset: Offset(2.w, 3.h),
              //         ),
              //       ],
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushReplacementNamed(
              //                 context, DashBoardScreen.routeName);
              //           },
              //           child: Container(
              //             width: 500,
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: 20.w, vertical: 08.h),
              //             margin: EdgeInsets.symmetric(horizontal: 40.h),
              //             decoration: BoxDecoration(
              //                 color: Theme.of(context).shadowColor,
              //                 borderRadius: BorderRadius.circular(10)),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 SvgPicture.asset(
              //                   'assets/svg/dashboard_icon.svg',
              //                   height: 30.h,
              //                   width: 30.w,
              //                   color: Theme.of(context).dividerColor,
              //                 ),
              //                 SizedBox(
              //                   width: 20,
              //                 ),
              //                 Text(
              //                   'Dashboard',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodyText1!
              //                       .copyWith(
              //                         fontSize: 16.sp,
              //                         fontWeight: FontWeight.w400,
              //                       ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           // ),
              //           // GestureDetector(
              //           //   onTap: () {
              //           //     Navigator.pushReplacementNamed(
              //           //         context, MessageScreen.routeName);
              //           //   },
              //           //   child: Container(
              //           //     width: 500,
              //           //     padding: EdgeInsets.symmetric(
              //           //         horizontal: 20.w, vertical: 08.h),
              //           //     margin: EdgeInsets.symmetric(horizontal: 40.w),
              //           //     decoration: BoxDecoration(
              //           //         color: Theme.of(context).shadowColor,
              //           //         borderRadius: BorderRadius.circular(10)),
              //           //     child: Row(
              //           //       mainAxisAlignment: MainAxisAlignment.center,
              //           //       children: [
              //           //         SvgPicture.asset(
              //           //           'assets/svg/msgs.svg',
              //           //           height: 30.h,
              //           //           width: 30.w,
              //           //           color: Theme.of(context).dividerColor,
              //           //         ),
              //           //         SizedBox(
              //           //           width: 20,
              //           //         ),
              //           //         Text(
              //           //           'Messaging',
              //           //           style: Theme.of(context)
              //           //               .textTheme
              //           //               .bodyText1!
              //           //               .copyWith(
              //           //                 fontSize: 16.sp,
              //           //                 fontWeight: FontWeight.w400,
              //           //               ),
              //           //         ),
              //           //       ],
              //           //     ),
              //           //   ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //
  Padding TopWidgets() {
    return Padding(
      padding: EdgeInsets.only(
          left: 18.0.h, right: 18.0.h, top: 8.h, bottom: 12.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 50.h),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HideCapitalView(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 22.0.w),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    //Theme.of(context).backgroundColor,
                    shape: BoxShape.circle),
                child: Image.asset(
                  'assets/images/arrow_back.png',
                  color: Theme.of(context).dividerColor,
                  height: 17.h,
                  width: 20.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  Cards({Key? key, required this.title, this.width, required this.iconPath})
      : super(key: key);
  final String title;
  final String iconPath;
  final double? width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 160.h,
      width: size.width * 0.4.w,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 18.h,
            spreadRadius: 05.w,
            offset: Offset(2.w, 3.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 12,
          ),
          iconPath.contains(".svg")
              ? SvgPicture.asset(iconPath)
              : Image.asset(
                  iconPath,
                  height: 40.h,
                  width: 40.w,
                  color: Theme.of(context).dividerColor,
                ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: SizedBox(
              width: width ?? size.width * 0.3.w,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15.sp,
                      height: 1.5.h,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class SmallRadiusButton extends StatelessWidget {
  const SmallRadiusButton({
    required this.text,
    this.color,
    this.textcolor,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color? textcolor;
  final List<Color>? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 00.h),
      height: isTablet() ? 50.h : 50.h,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 18.h,
            spreadRadius: 03.w,
            offset: Offset(2.w, 3.h),
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: color ??
              [
                // Color.fromARGB(255, 50, 167, 230),
                // Color.fromARGB(255, 194, 44, 231),
              ],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14.sp,
                color:
                    textcolor ?? Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

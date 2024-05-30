import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:malikopal/model/SendNotificationResponse_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/loading.dart';

import '../../../utils/utility.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = '/Notification-view';

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late DashBoardBloc _bloc;
  List<SendNotificationResponseDataModel>? data;
  @override
  void initState() {
    _bloc = DashBoardBloc();

    _bloc.GetNotificationData();

    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  String title = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    //var inputDate = inputFormat.parse(DateTime.now().toString());

    //var outputFormat = DateFormat('dd/MM/yyyy');
    //var date = outputFormat.format(inputDate);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: AnimatedBottomNavBar(),
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            CustomTopBar(topbartitle: 'Notifications'),
            Column(
              children: [
                //dynamic valuee...loaded from api's.
                Container(
                  height: size.height,
                  child: StreamBuilder<
                          ApiResponse<List<SendNotificationResponseDataModel>>>(
                      stream: _bloc.GetNotificationStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch ((snapshot.data?.status ?? "")) {
                            case Status.LOADING:
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Center(
                                    child: Loading(
                                        loadingMessage:
                                            snapshot.data!.message)),
                              );
                            //break;
                            case Status.COMPLETED:
                              if ((snapshot.data?.data ?? []).isEmpty ==
                                  false) {
                                var data = snapshot.data?.data ?? [];
                                return ListBuilder(data);
                              } else {
                                return Text(
                                  "No New Notifications.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600),
                                );
                              }
                            case Status.ERROR:
                              return SizedBox.shrink();
                          }
                        }
                        return SizedBox.shrink();
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  NotificationCard({
    Key? key,
    required this.color,
    required this.title,
    required this.desc,
    required this.date,
    // required this.onPressed,
  }) : super(key: key);

  final Color color;
  final String title;
  final String desc;
  final String date;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.11,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 02,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: size.width * 0.2,
                      child: CircleAvatar(
                        backgroundColor: color,
                        child: Center(
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            child: SvgPicture.asset(
                                'assets/svg/white_notification.svg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: size.width * 0.08,
                  // ),
                  Flexible(
                    flex: 08,
                    child: Container(
                      width: size.width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 05,
                            child: Container(
                              width: size.width * 0.6,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontSize: 17.sp,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    desc,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                          fontSize: 14.sp,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 03,
                            child: Container(
                              width: size.width * 0.3,
                              alignment: Alignment.centerRight,
                              child: Text(
                                date,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      fontSize: 14.sp,
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

                  // SizedBox(
                  //   width: size.width * 0.13,
                  // ),
                  // GestureDetector(
                  //   onTap: () => onPressed(),
                  //   child: Container(
                  //     child: SvgPicture.asset(
                  //       'assets/svg/bin.svg',
                  //       color: Theme.of(context).dividerColor,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CardType { Notice, Alert, Update }

class ListBuilder extends StatefulWidget {
  final List<SendNotificationResponseDataModel> data;

  ListBuilder(this.data);

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: ((context, index) {
        final item = widget.data[index];
        return ListViewItems(item, context, index);
      }),
    );
  }

  ShowUpAnimation ListViewItems(
      SendNotificationResponseDataModel item, BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    return ShowUpAnimation(
        delayStart: Duration(milliseconds: 0),
        animationDuration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        direction: Direction.horizontal,
        offset: 0.7,
        child: Column(
          children: [
            index == 0
                ? Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.25.h,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xffACBBF3),
                                Color(0xffACBBF3),
                                // Color(0xFF1E1CB0),
                                // Color(0xFF00C9FF),
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.4),
                              blurRadius: 5.h,
                              spreadRadius: 3.w,
                              offset: Offset(1.h, 4.w),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Text(
                                'Notice'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Colors.black,
                                      // Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              //  Colors.white.withOpacity(0.6),
                              height: 20.h,
                              endIndent: 1,
                              indent: 1,
                              thickness: 1,
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(horizontal: 20),
                              width: size.width * 0.8,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 12),
                                child: Text(
                                  widget.data[index].desc.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: Colors.black,
                                          // Colors.white,
                                          fontSize: 12.h,
                                          fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Dismissible(
                    key: Key(item.notificationID.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        widget.data.removeAt(index);
                      });
                      showSnackBar(context, "Notification Dissmissed", false);
                    },
                    // Show a red background as the item is swiped away.
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.4),
                            blurRadius: 5.h,
                            spreadRadius: 3.w,
                            offset: Offset(1.h, 4.w),
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      child: NotificationCard(
                        title: widget.data[index].title.toString(),
                        date: widget.data[index].date.toString(),
                        desc: widget.data[index].desc.toString(),
                        color: widget.data[index].title == "Alert"
                            ? Color(0xff1164AA)
                            : Color(0xFF929497),
                        // onPressed: () {
                        //   setState(() {
                        //     widget.data.removeAt(index);
                        //   });
                        // },
                      ),
                    ),
                  ),
          ],
        ));
  }
}

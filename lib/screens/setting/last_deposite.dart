import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/model/requestbody/HistoryReqBody_model.dart';
import 'package:malikopal/repositories/dashboard_repo.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/GlowSetting.dart';
import 'package:malikopal/utils/Const.dart';
import 'package:malikopal/utils/utility.dart';

import '../../model/last_deposit_data_model.dart';

class LastDepositeView extends StatefulWidget {
  const LastDepositeView({Key? key}) : super(key: key);

  @override
  State<LastDepositeView> createState() => _LastDepositeViewState();
}

class _LastDepositeViewState extends State<LastDepositeView> {
  //late TextEditingController _searchtextcontroller;

  int pno = 0;
  // late DashboardBloc _bloc;
  List<DatumModel>? data;
  String Filter = "ALL";
  int totalCredit = 0;
  String LastDate = "";
  DashboardRepository repository = DashboardRepository();
  @override
  void initState() {
    getLastData(HistoryReqDataModel(duration: Filter, pno: pno));
    // _bloc = DashboardBloc();
    // _bloc.CapitalHistoryStream.listen((event) {
    //   if (event.status == Status.COMPLETED) {
    //     DialogBuilder(context).hideLoader();
    //     setState(() {
    //       // data = event.data;
    //       // LastDate = data?.history?.first.dateStr ?? "";
    //       // totalCredit = data?.history?.first.credit?.toDouble() ?? 0;
    //       // data?.forEach((element) {
    //       //   totalCredit += (element.Credit ?? 0);
    //       // });
    //     });
    //   } else if (event.status == Status.ERROR) {
    //     DialogBuilder(context).hideLoader();
    //     showSnackBar(context, event.message, true);
    //   } else if (event.status == Status.LOADING) {
    //     DialogBuilder(context).showLoader();
    //   }
    // });

    // _bloc.GetLastAddedAmountyData(HistoryReqData(duration: Filter, pno: pno));

    super.initState();
  }

  getLastData(HistoryReqDataModel data1) async {
    HistoryReqBodyModel reqBody = HistoryReqBodyModel(data: data1);

    repository.GetLastAddedAmountyDataNew(reqBody).then((event) {
      if (event?.data != null) {
        setState(() {
          data = event?.data;

          if (data != null && data!.length > 0) {
            LastDate = data?.first.dateStr ?? "";
            totalCredit = data?.first.credit?.toInt() ?? 0;
          }

          // data?.forEach((element) {
          //   totalCredit += (element.Credit ?? 0);
          // });
        });
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    //_searchtextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: AnimatedBottomNavBar(),
        body: SafeArea(
          child: Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 01,
                  child: CustomTopBar(
                      backButtonColor: isDarkThemeEnabled(context)
                          ? Colors.white
                          : Colors.black,
                      topbartitle: "Last Deposit"),
                ),
                Flexible(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 3,
                        ),
                        GlowSetting(
                          color: Color(0xff1F5FA2).withOpacity(0.1),
                          //  Color.fromARGB(255, 90, 152, 190)
                          //     .withOpacity(0.1),
                          color1: Color(0xff1F5FA2).withOpacity(0.1),
                          // Color.fromARGB(255, 68, 182, 223)
                          //     .withOpacity(0.7),
                          radius: size.height < 700 ? 155 : 180,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Rs\n',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                ),
                                TextSpan(
                                  text: Constant.currencyFormatWithoutDecimal
                                      .format(totalCredit),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Center(
                          child: Text(
                            LastDate.isNotEmpty ? LastDate : "---",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkThemeEnabled(context)
                                        ? Colors.white
                                        : Colors.black),
                          ),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

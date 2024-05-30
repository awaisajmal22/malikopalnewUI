import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malikopal/bloc/authorization_bloc.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:malikopal/model/auth_model/LoginData_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Login_Screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Otp_Screen.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/utility.dart';

import '../../../model/DashboardResponse_model.dart';
import '../../../utils/shared_pref.dart';
import '../../setting/update_bank_details.dart';
import '../../setting/update_profile.dart';

String method = "Phone";

class VerificationScreen extends StatefulWidget {
  VerificationScreen({
    Key? key,
    required this.skipOtp,
  }) : super(key: key);
  static const routeName = '/verification-screen';
  final bool skipOtp;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late AuthorizationBloc _bloc;
  late DashBoardBloc _bloc2;
  DashboardResponseDataModel? responc;

  @override
  void initState() {
    _bloc = AuthorizationBloc();
    _bloc.sendOtopDateStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();

        var phone = event.data?.EmailPhone;

        String phone2 = phone.toString();

        String? t = event.data?.Type;

        String t2 = t.toString();

        if (widget.skipOtp) {
          _bloc2 = DashBoardBloc();
          _bloc2.getDashboardData();
          _bloc2.dashboardResponseStream.listen((event) {
            if (event.status == Status.COMPLETED) {
              DialogBuilder(context).hideLoader();
              setState(() {
                responc = event.data;
              });
              print(' Responce: ${responc?.isProfileUpdateRequired}');
              print('Data');

              // print(data?.toJson());

              SessionData().setUserProfile(responc);
              if (responc?.isProfileUpdateRequired == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => UpdateProfileView(
                      isBankDetailUpdate:
                          responc?.isBankUpdateRequired ?? false,
                      isProfileUpdate:
                          responc?.isProfileUpdateRequired ?? false,
                    ),
                  ),
                );
              } else if (responc?.isBankUpdateRequired == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => UpdateBankDetailsView(
                      bankDetailUpdate: responc?.isBankUpdateRequired ?? false,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HideCapitalView(
                      isLogin: true,
                    ),
                  ),
                );
              }
            } else if (event.status == Status.ERROR) {
              DialogBuilder(context).hideLoader();

              //

              showSnackBar(context, event.message, true);
            } else if (event.status == Status.LOADING) {
              DialogBuilder(context).showIndicator();
            }
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                phone_number: phone2,
                otpMethod: t2,
                skipOtp: widget.skipOtp,
              ),
            ),
          );
        }
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
        CheckUnauthMessage(context, event.message);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });
    super.initState();

    method = "Email";
    SendOtpData data = SendOtpData(OtpMethod: method);
    _bloc.postSendOtp(data);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, MyHomePage.routeName);
        return true;
      },
      child: Scaffold(
        // backgroundColor: Color(0xfff1f1f2),
        resizeToAvoidBottomInset: true,
        body: Container(
          height: size.height,
          width: size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Bounce(
                    duration: Duration(milliseconds: 100),
                    onPressed: () {
                      method = "Email";
                      SendOtpData data =
                          SendOtpData(OtpMethod: method);
                      _bloc.postSendOtp(data);
                    },
                    child: AnimatedCircularBar(
                      child: Center(
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            "assets/svg/mail_verif.png",
                            color: isDarkThemeEnabled(context)
                                ? Colors.white
                                : null,
                          ),
                        ),
                      ),
                      radius: 170,
                      color: Colors.grey.withOpacity(0.1),
                      color1: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ),
                // Flexible(
                //   flex: 1,
                //   child: Bounce(
                //     onPressed: () {
                //       method = "Phone";
                //       SendOtpData data = SendOtpData(OtpMethod: method);
                //       _bloc.postSendOtp(data);
                //     },
                //     duration: Duration(milliseconds: 100),
                //     child: AnimatedCircularBar(
                //       child: Center(
                //         child: SizedBox(
                //           height: 80,
                //           width: 80,
                //           child: SvgPicture.asset(
                //             "assets/svg/phone_verif.svg",
                //             color: isDarkThemeEnabled(context)
                //                 ? Colors.white
                //                 : null,
                //           ),
                //         ),
                //       ),
                //       radius: 170,
                //       color: Colors.grey.withOpacity(0.1),
                //       color1: Colors.grey.withOpacity(0.2),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

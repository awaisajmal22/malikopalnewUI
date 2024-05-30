import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:malikopal/bloc/authorization_bloc.dart';
import 'package:malikopal/model/auth_model/LoginData_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Login_Screen.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:malikopal/screens/widgets/GlowSetting.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/utils/utility.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {Key? key,
      required this.otpMethod,
      required this.phone_number,
      required this.skipOtp})
      : super(key: key);
  static const routeName = 'OtpScreen';
  final String phone_number;
  final String otpMethod;
  final bool skipOtp;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  //glow anim
  late Animation<double> firstAnimation;
  late AnimationController firstAnimationController;
  late Animation<double> secondAnimation;
  late AnimationController secondAnimationController;
  late AuthorizationBloc _bloc;

  late TextEditingController textEditingController;
  double animationValue = 0;
  bool isFirstAnimationCompleted = false;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )
      ..forward()
      ..repeat(reverse: true);
    textEditingController = TextEditingController();

    _bloc = AuthorizationBloc();
    _bloc.verifyOtpStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        Navigator.pushReplacementNamed(context, HideCapitalView.routeName);
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });

    _bloc.sendOtopDateStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    _controller.dispose();
    super.dispose();
  }

  // verifyOtpFun() {
  //   VerifyOtpData data =
  //       VerifyOtpData(Otp: widget.phone_number, OtpMethod: widget.otpMethod);
  //   _bloc.postVerifyOtp(data);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, MyHomePage.routeName);
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: AnimatedBuilder(
              animation: _controller.view,
              builder: (context, _) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: size.height,
                    child: Column(
                      children: [
                        CustomTopBar(topbartitle: ""),
                        SizedBox(height: 40.h),
                        GlowSetting(
                          color: Color(0xff1F5FA2).withOpacity(0.3),
                          // Color(0xff1164AA).withOpacity(0.1),
                          color1: Color(0xff1F5FA2).withOpacity(0.3),
                          //  Color(0xffBF40BF).withOpacity(0.7),
                          radius: size.height < 700 ? 155 : 180,
                          child: Container(
                            height: 80.h,
                            width: 80.h,
                            child: SvgPicture.asset("assets/svg/point_hand.svg",
                                color: Color(0xffACBBF3)
                                //  Theme.of(context).dividerColor,
                                ),
                          ),
                        ),

                        SizedBox(
                          height: 100.h,
                        ),
                        Container(
                          child: Text(
                            'We have sent the verificaiton code \nto your registered email.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 100.h,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 20.0.h,
                              horizontal: 12.w,
                            ),
                            child: Otp_Box(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: GestureDetector(
                              onTap: () {
                                SendOtpData data =
                                    SendOtpData(OtpMethod: widget.otpMethod);
                                _bloc.postSendOtp(data);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset('assets/svg/resend.svg',
                                        color: Color(0xffACBBF3)),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Resend',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat',
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     if (widget.phone_number ==
                        //         textEditingController.text.toString()) {
                        //       VerifyOtpData data = VerifyOtpData(
                        //           Token: widget.phone_number,
                        //           Type: widget.otpMethod);

                        //       _bloc.postVerifyOtp(data);
                        //     }
                        //   },
                        //   child: CustomButton(
                        //     title: 'Verify'.toUpperCase(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  PinCodeTextField Otp_Box(BuildContext context) {
    return PinCodeTextField(
      appContext: this.context,
      pastedTextStyle: TextStyle(
        color: Theme.of(context).backgroundColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      length: 6,
      hintCharacter: '1',
      enablePinAutofill: true,
      hintStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Montserrat'),
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        activeColor: Theme.of(context).cardColor,
        activeFillColor: Theme.of(context).cardColor,
        inactiveColor: Theme.of(context).cardColor,
        selectedColor: Theme.of(context).cardColor,
        selectedFillColor: Theme.of(context).cardColor,
        inactiveFillColor: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
      ),
      cursorColor: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      textStyle: TextStyle(fontSize: 18.sp, height: 1.6),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: textEditingController,
      keyboardType: TextInputType.number,
      boxShadows: [
        BoxShadow(
          offset: Offset(1, 2),
          color: Theme.of(context).shadowColor,
          blurStyle: BlurStyle.normal,
          blurRadius: 2,
          spreadRadius: 3,
        )
      ],
      onCompleted: (v) {
        VerifyOtpData data = VerifyOtpData(Token: v, Type: widget.otpMethod);
        _bloc.postVerifyOtp(data);
      },
      onChanged: (x) {},
    );
  }
}

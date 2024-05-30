import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:malikopal/screens/loginprocess/components/inputfield.widget.dart';

import '../../../repositories/dashboard_repo.dart';
import '../../../repositories/auth_repo/AuthRepository.dart';
import '../../../utils/utility.dart';
import '../../setting/components/setting.widgets.dart';
import '../components/widgets.dart';
import 'Login_Screen.dart';

class NewOtpScreen extends StatefulWidget {
  NewOtpScreen({Key? key, required this.userId}) : super(key: key);
  String userId;

  @override
  State<NewOtpScreen> createState() => _NewOtpScreenState();
}

class _NewOtpScreenState extends State<NewOtpScreen> {
  //

  TextEditingController textEditingController = TextEditingController();
  TextEditingController passwordFeild = TextEditingController();
  TextEditingController confirm = TextEditingController();

  bool isloading = false;

  DashboardRepository dashboardRepository = DashboardRepository();

  var obsecure = true;
  var obsecure2 = true;

  resetPassword() async {
    setState(() {
      isloading = true;
    });
    dp(msg: "Text", arg: textEditingController.text);
    try {
      if (textEditingController.text.trim().isNotEmpty &&
          passwordFeild.text.isNotEmpty &&
          confirm.text.isNotEmpty) {
        var responce = await dashboardRepository.resetPassword(
            widget.userId, textEditingController.text, passwordFeild.text);
        dp(msg: "Res", arg: responce);
        if (responce['status'] ?? false) {
          showSnackBar(context,
              responce['message'] ?? "Reset password successfully", false);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return MyHomePage();
            },
          ));
        } else {
          showSnackBar(
              context,
              responce['message'] ?? "Something went wrong please try again",
              true);
        }
      } else {
        showSnackBar(context, "Enter user id", true);
      }
    } catch (e, s) {
      dp(msg: "Error occur  $e", arg: s);
      setState(() {
        isloading = false;
      });
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 25.h),
              CustomTopBar(topbartitle: ""),
              SizedBox(height: MediaQuery.of(context).size.width / 4),
              Otp_Box(context),
              SizedBox(height: 30),
              CustomInputField(
                textcontroller: passwordFeild,
                hint: "New password",
                icon: Padding(
                  padding: EdgeInsets.only(
                      left: isTablet() ? size.width * 0.1.w : 16),
                  child: Container(
                    height: 24.h,
                    width: 24.w,
                    child: Image.asset("assets/svg/Lock.png",
                        color: Color(0xffACBBF3)
                        // Theme.of(context).dividerColor,
                        ),
                  ),
                ),
                suffixicon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obsecure = !obsecure;
                    });
                  },
                  child: Icon(
                    obsecure
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                    size: 24,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                isvisible: obsecure,
              ),
              SizedBox(height: 30),
              CustomInputField(
                textcontroller: confirm,
                hint: "Confirm New password",
                isvisible: obsecure2,
                icon: Padding(
                  padding: EdgeInsets.only(
                      left: isTablet() ? size.width * 0.1.w : 16),
                  child: Container(
                    height: 24.h,
                    width: 24.w,
                    child: Image.asset("assets/svg/Lock.png",
                        color: Color(0xffACBBF3)
                        // Theme.of(context).dividerColor,
                        ),
                  ),
                ),
                suffixicon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obsecure2 = !obsecure2;
                    });
                  },
                  child: Icon(
                    obsecure2
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                    size: 24,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 3),
              isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        if (textEditingController.text.isEmpty) {
                          showSnackBar(
                              context, "OTP should not be empty", true);

                          return;
                        }

                        if (passwordFeild.text == confirm.text) {
                          resetPassword();
                        } else {
                          showSnackBar(context, "Password not match", true);
                        }
                      },
                      child: CustomButton(title: 'RESET'))
            ],
          ),
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
        //
      },
      onChanged: (x) {},
    );
  }
}

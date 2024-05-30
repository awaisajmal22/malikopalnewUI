import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInputField extends StatefulWidget {
  CustomInputField(
      {required this.textcontroller,
      this.icon,
      this.hint,
      this.suffixicon,
      this.isvisible,
      this.textinputType,
      this.emprty_error_msg,
      this.error_msg,
      Key? key})
      : super(key: key);
  final TextEditingController textcontroller;
  final Widget? icon;
  final String? hint;
  final Widget? suffixicon;
  final bool? isvisible;
  final String? emprty_error_msg;
  final String? error_msg;
  final TextInputType? textinputType;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField>
    with TickerProviderStateMixin {
  // final TextEditingController textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: size.width * 0.83,
      child: Neumorphic(
        style: NeumorphicStyle(
          lightSource: LightSource.topLeft,
          disableDepth: false,
          shadowLightColorEmboss: Theme.of(context).shadowColor,
          // shadowDarkColorEmboss: Color.fromARGB(255, 182, 182, 182),
          depth: -3,
          color: Theme.of(context).canvasColor,
          intensity: 0.9,
          // border: NeumorphicBorder(
          //   width: 1,
          //   color: Color.fromARGB(255, 211, 211, 211),
          // ),
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
        ),
        child: Center(
          child: TextField(
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18.sp),
            controller: widget.textcontroller,
            keyboardType: widget.textinputType ?? TextInputType.text,
            obscureText: widget.isvisible ?? false,
            decoration: InputDecoration(
              suffixIcon: widget.suffixicon ?? null,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xffA2A0A8),
                    fontWeight: FontWeight.w400,
                    // color: Theme.of(context).hintColor,
                  ),
              icon: widget.icon ??
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.2,
                    ),
                    child: Container(
                      height: 18,
                      width: 18,
                      child: SvgPicture.asset(
                        "assets/svg/user.svg",
                        color: Color(0xff),
                        // color: Color(0xFF90278E),
                      ),
                    ),
                  ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

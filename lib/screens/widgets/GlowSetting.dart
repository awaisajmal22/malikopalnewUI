import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/utils/utility.dart';

class GlowSetting extends StatefulWidget {
  GlowSetting({
    Key? key,
    required this.child,
    this.radius,
    this.color,
    this.color1,
  }) : super(key: key);

  final Widget child;
  final double? radius;
  final color;
  final color1;

  @override
  State<GlowSetting> createState() => _GlowSettingState();
}

class _GlowSettingState extends State<GlowSetting>
    with TickerProviderStateMixin {
  late Animation<double> firstAnimation;
  late AnimationController firstAnimationController;
  late Animation<double> secondAnimation;

  double animationValue = 0;
  bool isFirstAnimationCompleted = false;
  @override
  void initState() {
    //Glow Walaa
    firstAnimationController =
        AnimationController(duration: const Duration(seconds: 32), vsync: this);

    firstAnimation = CurvedAnimation(
        parent: firstAnimationController, curve: Curves.slowMiddle)
      ..addListener(() {
        setState(() {
          if (!isFirstAnimationCompleted) {
            animationValue = firstAnimation.value * 320;
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          isFirstAnimationCompleted = true;
          firstAnimationController.repeat();
        }
      });
    firstAnimationController.repeat();

    /// Easing animation
    //     AnimationController(duration: const Duration(seconds: 15), vsync: this);

    // secondAnimation = CurvedAnimation(
    //   ..addListener(() {
    //     setState(() {
    //       if (isFirstAnimationCompleted) {
    //         animationValue = secondAnimation.value * 360;
    //       }
    //     });
    //   })
    //   ..addStatusListener((AnimationStatus status) {
    //     if (status == AnimationStatus.completed) {
    //       isFirstAnimationCompleted = false;
    //       firstAnimationController.forward();
    //     }
    //   });

    SessionData().isGlow().then((value) {
      setState(() {
        isGlowOn = value;
      });
    });

    super.initState();
  }

  bool isGlowOn = true;
  @override
  void dispose() {
    firstAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double rads = (animationValue - (60 / 2) - (60 / 2));

    // print('cos = ' + math.cos(rads).toString());
    // print('sign = ' + math.sin(rads).toString());
    return AnimatedCircularBar(
      child: widget.child,
      color: isGlowOn
          ? widget.color
          : Theme.of(context).shadowColor.withOpacity(0),
      color1: isGlowOn
          ? widget.color1
          : Theme.of(context).shadowColor.withOpacity(0),
      border: isGlowOn
          ? Border.all(
              color: isDarkThemeEnabled(context)
                  ? Theme.of(context).shadowColor.withOpacity(0.2)
                  : Color(0xffD0D8F5),
              style: BorderStyle.solid,
              width: 20.0,
            )
          : Border.all(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              style: BorderStyle.solid,
              width: 3.0,
            ),
      spreadradius: 20.h,
      blurradius: 18.h,
      negativeOffsetx: isGlowOn ? -6 * math.sin(animationValue / 50) : 7.h,
      negativeOffsety: isGlowOn ? -6 * math.cos(animationValue / 50) : 7.h,
      offsetx: isGlowOn ? 20 * math.cos(animationValue / 50) : 7.h,
      offsety: isGlowOn ? 20 * math.sin(animationValue / 50) : 7.h,
      radius: widget.radius ?? 220.h,
    );
  }
}

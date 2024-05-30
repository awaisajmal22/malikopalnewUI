import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';

import '../../../utils/utility.dart';
import '../../setting/components/setting.widgets.dart';

class CapitalWithDrawalAlert extends StatefulWidget {
  CapitalWithDrawalAlert({Key? key, required this.message, this.title})
      : super(key: key);
  static const routeName = '/withdraw_alert-screen';
  final String message;
  final String? title;
  @override
  State<CapitalWithDrawalAlert> createState() => _CapitalWithDrawalAlertState();
}

class _CapitalWithDrawalAlertState extends State<CapitalWithDrawalAlert>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 800);

  late AnimationController _controller;
  late Animation<double> _animateright;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    _animateright = Tween<double>(begin: -2.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller.view,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.translationValues(
                  0.0, _animateright.value * width, 0.0),
              child: child,
            );
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            child: AnimatedAlertDialog(
              color: [Color(0xff1164AA), Color(0xff1164AA)],
              // title: widget.title,
              description: widget.message,
            ),
          ),
        ),
      ),
    );
  }
}

class WithDrawPaymentAlert extends StatefulWidget {
  WithDrawPaymentAlert({Key? key, required this.message, this.title})
      : super(key: key);
  static const routeName = '/withdraw_alert-screen';
  final String message;
  final String? title;
  @override
  State<WithDrawPaymentAlert> createState() => _WithDrawPaymentAlertState();
}

class _WithDrawPaymentAlertState extends State<WithDrawPaymentAlert>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 800);

  late AnimationController _controller;
  late Animation<double> _animateright;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    _animateright = Tween<double>(begin: -2.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller.view,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.translationValues(
                  0.0, _animateright.value * width, 0.0),
              child: child,
            );
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            child: AnimatedAlertDialog(
              // title: widget.title,
              description: widget.message,
            ),
          ),
        ),
      ),
    );
  }
}

class ClosingPaymentAlert extends StatefulWidget {
  ClosingPaymentAlert(
      {Key? key, required this.message, this.title, this.isClosingOption})
      : super(key: key);
  static const routeName = '/closing_alert-screen';
  final String message;
  final String? title;
  bool? isClosingOption;
  @override
  State<ClosingPaymentAlert> createState() => _ClosingPaymentAlertState();
}

class _ClosingPaymentAlertState extends State<ClosingPaymentAlert>
    with TickerProviderStateMixin {
  //

  final _duration = Duration(milliseconds: 800);

  late AnimationController _controller;
  late Animation<double> _animateright;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    _animateright = Tween<double>(begin: -2.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //   height: 40.h,
          // ),
          Flexible(
            flex: 01,
            child: CustomTopBar(
              backButtonColor:
                  isDarkThemeEnabled(context) ? Colors.white : Colors.black,
              topbartitle: widget.title!,
            ),
          ),
          AnimatedBuilder(
            animation: _controller.view,
            builder: (context, child) {
              return AnimatedAlign(
                alignment: Alignment.bottomCenter,
                duration: _duration,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, _animateright.value * width, 0.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedAlertDialog(
                        isCloseOption: widget.isClosingOption,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        textcolor: Color(0xFFFFF100),
                        btn_begin: Alignment.centerLeft,
                        btn_end: Alignment.centerRight,
                        color_v2: [Colors.white],
                        iconcolor: Color(0xff1164AA),
                        //  Color(0xff9E1F63),
                        description: widget.message,
                        // title: widget.title,
                        color: [Color(0xffACBBF3), Color(0xffACBBF3)]
                        // [Color(0xff1164AA), Color(0xff1164AA)],
                        ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}

class RolloverPaymentAlert extends StatefulWidget {
  RolloverPaymentAlert({Key? key, required this.message, this.title})
      : super(key: key);
  static const routeName = '/closing_alert-screen';
  final String message;
  final String? title;
  @override
  State<RolloverPaymentAlert> createState() => _RolloverPaymentAlertState();
}

class _RolloverPaymentAlertState extends State<RolloverPaymentAlert>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 800);

  late AnimationController _controller;
  late Animation<double> _animateright;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    _animateright = Tween<double>(begin: -2.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 01,
              child: CustomTopBar(
                backButtonColor:
                    isDarkThemeEnabled(context) ? Colors.white : Colors.black,
                topbartitle: widget.title!,
              ),
            ),
            AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return AnimatedAlign(
                    alignment: Alignment.bottomCenter,
                    duration: _duration,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, _animateright.value * width, 0.0),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedAlertDialog(
                            isCloseOption: true,
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            textcolor: Colors.white,
                            btn_begin: Alignment.centerLeft,
                            btn_end: Alignment.centerRight,
                            iconcolor: Color(0xff1164AA),
                            // Color(0xFFAC2EA3),
                            description: widget.message,
                            // title: widget.title,
                            color: [Color(0xffACBBF3), Color(0xffACBBF3)]
                            // [Color(0xff1164AA), Color(0xff1164AA)],
                            ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class CapitalWithDrawPendingDateAlert extends StatefulWidget {
  CapitalWithDrawPendingDateAlert(
      {Key? key,
      required this.message,
      this.title,
      this.urduMessage1,
      this.urduMessage2,
      this.daterich,
      this.description2,
      this.dateForurdu})
      : super(key: key);
  static const routeName = '/closing_alert-screen';
  final String message;
  final String? title;
  final String? urduMessage1;
  final String? urduMessage2;
  final String? dateForurdu;
  final String? daterich;
  final String? description2;

  @override
  State<CapitalWithDrawPendingDateAlert> createState() =>
      _CapitalWithDrawPendingDateAlertState();
}

class _CapitalWithDrawPendingDateAlertState
    extends State<CapitalWithDrawPendingDateAlert>
    with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 800);

  late AnimationController _controller;
  late Animation<double> _animateright;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);

    _animateright = Tween<double>(begin: -2.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTopBar(
              topbartitle: 'Withdraw Status',
              backButtonColor:
                  isDarkThemeEnabled(context) ? Colors.white : Colors.black,
            ),
            AnimatedBuilder(
                animation: _controller.view,
                builder: (context, child) {
                  return AnimatedAlign(
                    alignment: Alignment.bottomCenter,
                    duration: _duration,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, _animateright.value * width, 0.0),
                      child: AnimatedPendingAlertDailog(
                          begin: Alignment.topRight,
                          urduDescription1: widget.urduMessage1,
                          urduDescription2: widget.urduMessage2,
                          dateforUrdu: widget.dateForurdu,
                          end: Alignment.bottomLeft,
                          textcolor: Color(0xFFFFF100),
                          btn_begin: Alignment.centerLeft,
                          btn_end: Alignment.centerRight,
                          iconcolor: Color(0xff1164AA),
                          // Color(0xff1164AA),
                          description: widget.message,
                          daterich: widget.daterich,
                          description2: widget.description2,
                          title: widget.title,
                          color: [
                            Color(0xffACBBF3),
                            Color(0xffACBBF3),
                          ]
                          // [Color(0xff1164AA), Color(0xff1164AA)]
                          // [Color(0xff1164AA), Color(0xff1164AA)],
                          ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

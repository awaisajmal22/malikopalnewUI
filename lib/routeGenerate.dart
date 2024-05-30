import 'package:flutter/material.dart';
import 'package:malikopal/screens/dashboard/custom.widgets/custom_widgets.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/alerts.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/closingPayment.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/dashboard.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/notifications.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/rollover.screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Login_Screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Otp_Screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/forget_pass.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/splash_screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/verification_method.dart';
import 'package:malikopal/screens/setting/change_password.dart';
import 'package:malikopal/screens/setting/message_screen.dart';
import 'package:malikopal/screens/setting/setting.dart';

class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute(
      {required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Remove the default transition animation
    return child;
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (context) {
      //       return SplashScreen();
      //     },
      //   );
      case (HideCapitalView.routeName):
        return NoAnimationPageRoute(
          builder: (context) {
            return HideCapitalView();
          },
        );
      case (SplashScreen.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );
      case (WithDrawPaymentAlert.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return WithDrawPaymentAlert(
              message: "",
            );
          },
        );
      case (ClosingPaymentView.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return ClosingPaymentView();
          },
        );
      case (DashBoardView.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return DashBoardView();
          },
        );
      case (RollOverView.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return RollOverView();
          },
        );
      case (MyHomePage.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return MyHomePage();
          },
        );
      case (AnimatedBottomNavBar.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return AnimatedBottomNavBar();
          },
        );
      case (SettingScreen.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return SettingScreen();
          },
        );
      case (VerificationScreen.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return VerificationScreen(
              skipOtp: false,
            );
          },
        );
      case (ChangePassword.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return ChangePassword();
          },
        );
      case (ForgetPsswordScreen.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return ForgetPsswordScreen();
          },
        );
      case (OtpScreen.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return OtpScreen(
              otpMethod: '',
              phone_number: '',
              skipOtp: true,
            );
          },
        );
      case (NotificationView.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return NotificationView();
          },
        );
      case (MessageScreen.routeName):
        return MaterialPageRoute(
          builder: (context) {
            return MessageScreen();
          },
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text(
            'Route Error..',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    });
  }
}

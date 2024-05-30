import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:local_auth/local_auth.dart';
import 'package:malikopal/bloc/authorization_bloc.dart';
import 'package:malikopal/model/requestbody/ThumbReqBody_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/dashboard/dashboard.screens/hidecapital.screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Login_Screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/splash_screen.dart';
import 'package:malikopal/screens/widgets/loading_dialog.dart';
import 'package:malikopal/services/GlobalService.dart';
import 'package:malikopal/utils/shared_pref.dart';
import 'package:malikopal/utils/utility.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class AuthenticationService {
  // final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  BuildContext ctx;
  AuthorizationBloc _bloc = AuthorizationBloc();
  bool isAuthenticated = false;
  bool AuthNewValue = false;
  String _path = "";
  String _type = "";
  AuthenticationService({required this.ctx}) {
    _bloc = AuthorizationBloc();
    _bloc.LoginByThumbStream.listen((event) {
      if (event.status == Status.LOADING) {
        DialogBuilder(ctx).showLoader();
      } else if (event.status == Status.ERROR) {
        DialogBuilder(ctx).hideLoader();
        showSnackBar(ctx, event.message, true);
        Navigator.pushReplacementNamed(ctx, SplashScreen.routeName);
      } else if (event.status == Status.COMPLETED) {
        String? token = event.data?.token;
        var check = token == null ? "" : token.toString();
        SessionData().setUserSession(check).then((value) {
          DialogBuilder(ctx).hideLoader();
          Navigator.pushReplacementNamed(ctx, HideCapitalView.routeName);
        });
      }
    });
    _bloc.ActivateThumbStream.listen((event) {
      if (event.status == Status.LOADING) {
        DialogBuilder(ctx).showLoader();
      } else if (event.status == Status.ERROR) {
        DialogBuilder(ctx).hideLoader();
        showSnackBar(ctx, event.message, true);
      } else if (event.status == Status.COMPLETED) {
        if (_path == "main_setting") SessionData().setTouchID(AuthNewValue);
        DialogBuilder(ctx).hideLoader();
      }
    });
  }

  Future<String> authenticateUser(
      {required String path,
      required String type,
      bool? value,
      String? message}) async {
    //

    final LocalAuthentication authentication = LocalAuthentication();

    isAuthenticated = false;

    AuthNewValue = value ?? false;

    _path = path;

    _type = type;

    try {
      bool canCheckBiometrics = await authentication.canCheckBiometrics;

      if (canCheckBiometrics == true) {
        List<BiometricType> availableBiometrics =
            await authentication.getAvailableBiometrics();
        if (availableBiometrics.isEmpty) {
          // no biometrics are enrolled.
          return "Please Enroll your biomatrics form setting to continue.";
        }
        // bool faceSupport = availableBiometrics.contains(BiometricType.face);
        // bool thumbSupport =
        //     availableBiometrics.contains(BiometricType.fingerprint);

        //bool thumbRec = _type == 'thumb';
        bool faceRec = _type == 'face';

        // if (faceRec) {
        //   if (!faceSupport) {
        //     return "NotSupported";
        //   }
        // }

        // if (thumbRec) {
        //   if (!thumbSupport) {
        //     return "NotSupported";
        //   }
        // }
        String title = (faceRec
            ? 'Scan your face to Authorize'
            : 'Scan your finger to Authorize');
        try {
          isAuthenticated = await authentication.authenticate(
              localizedReason: message!,
              authMessages: <AuthMessages>[
                AndroidAuthMessages(
                  signInTitle: title,
                  cancelButton: 'No thanks',
                ),
                IOSAuthMessages(
                  localizedFallbackTitle: title,
                  cancelButton: 'No thanks',
                ),
              ],
              options: const AuthenticationOptions(
                  biometricOnly: true,
                  stickyAuth: false,
                  useErrorDialogs: true));
          if (path == 'splash') {
            //form splash screen so must login
            if (isAuthenticated) {
              _login();
            } else {
              Navigator.pushReplacementNamed(ctx, MyHomePage.routeName);
              return "Failed";
            }
          } else if (path == 'main_setting') {
            //from setting to enable or disable biomatrics
            if (isAuthenticated) {
              _activateDeactivate();
            } else {
              return "Failed";
            }
          }
        } on PlatformException catch (e) {
          if (path == 'splash') {
            Navigator.pushReplacementNamed(ctx, MyHomePage.routeName);
          }
          if (e.code == auth_error.notEnrolled) {
            // Add handling of no hardware here.
          } else if (e.code == auth_error.lockedOut ||
              e.code == auth_error.permanentlyLockedOut) {
            // ...
          } else {
            // ...
          }
        }
      } else {
        return "NotSupported";
      }
    } catch (e) {
      return e.toString();
    }
    return (isAuthenticated && AuthNewValue) ? "True" : "False";
  }

  _login() {
    String deviceId = GlobalService().getDeviceId();
    ThumbReqDataModel data =
        ThumbReqDataModel(Activate: true, DeviceId: deviceId, LoginMethod: 'Thumb');
    _bloc.ThumbLogin(data);
  }

  _activateDeactivate() {
    var deviceId = GlobalService().getDeviceId();
    _bloc.ActivateThumbLogin(ThumbReqDataModel(
        Activate: AuthNewValue, DeviceId: deviceId, LoginMethod: 'Thumb'));
  }
}

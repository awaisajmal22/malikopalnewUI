import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/Otp_Screen.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/new_otp_screen.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malikopal/ScopedModelWrapper.dart';
import 'package:malikopal/firebase_options.dart';
import 'package:malikopal/repositories/auth_repo/AuthRepository.dart';
import 'package:malikopal/routeGenerate.dart';
import 'package:malikopal/screens/loginprocess/loginscreens/splash_screen.dart';
import 'package:malikopal/utils/globles.dart';
import 'package:malikopal/utils/styles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

//User Id : 100362
// Pass : 665544
// Pass : 665544
// Pin : 000000

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  dp(msg: "Handling a background message in sap car:", arg: message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ScopeModelWrapper(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, _, model) {
        model.updateAppLandingData();

        return GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: MaterialApp(
            useInheritedMediaQuery: true,
            //locale: DevicePreview.locale(context),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'),
            ],
            // builder: DevicePreview.appBuilder,s
            debugShowCheckedModeBanner: false,
            title: 'Malik Opal',
            navigatorKey: knavigatorKey,
            theme: Styles.lightTheme(),
            darkTheme: Styles.darkTheme(),
            themeMode: model.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            initialRoute: SplashScreen.routeName,
            
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        );
      },
    );
  }
}

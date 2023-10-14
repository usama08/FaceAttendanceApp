import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoofficeclock/enums/theme.dart';
import 'package:geoofficeclock/provider_service/multi_provider.dart';
import 'package:geoofficeclock/view/Login/components/login_screen.dart';
import 'package:geoofficeclock/view/onBoardingScreens/splash_screen.dart';
import 'package:geoofficeclock/view/onBoardingScreens/components/boarding_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: unused_element
// late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _cameras = await availableCameras();

  runApp(
    MultiProvider(
      providers: multiProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: kAppThemeData[AppTheme.light],
          home: const AppWrapper(),
        );
      },
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  late SharedPreferences _prefs;
  bool _showSplashScreen = true;
  bool _showOnboardingScreen = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    _prefs = await SharedPreferences.getInstance();
    bool? firstLaunch = _prefs.getBool('firstLaunch');

    if (firstLaunch == null || firstLaunch) {
      _prefs.setBool('firstLaunch', false);
      setState(() {
        _showSplashScreen = true;
        _showOnboardingScreen = true;
      });
    } else {
      setState(() {
        _showSplashScreen = false;
        _showOnboardingScreen = false;
      });
    }
  }

  void _completeOnboarding() {
    setState(() {
      _showOnboardingScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return _showSplashScreen
        ? SplashScreen(
            onBoardingCompleted: () {
              setState(() {
                _showSplashScreen = false;
              });
            },
          )
        : _showOnboardingScreen
            ? OnBoardingScreen(
                onBoardingCompleted: _completeOnboarding,
              )
            : const LoginScreen();
  }
}

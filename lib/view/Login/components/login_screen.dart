import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoofficeclock/Loading/animation_fade.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/constant/svg_image.dart';
import 'package:geoofficeclock/network_utils/connectivity.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../BottomNavigationBar/navigation_bar.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginApis = Get.put(LoginApis());
  LocalAuthentication auth = LocalAuthentication();
  final networkcontroller = Get.put(NetworkConnect());
  String msg = "You are not authorized.";
  final _loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool rememberMe = false;
  bool _bioLogin = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadSavedCredentials();
  }

  void loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    print('Loaded Username: $username');
    print('Loaded Password: $password');
    if (username != null && password != null) {
      _loginController.username.text = username;
      _loginController.password.text = password;
      rememberMe = true;

      // Auto-login using stored credentials
      // _simulateLogin();
    }
  }

  // New method for fingerprint authentication
  Future<void> _authenticateWithFingerprint() async {
    try {
      bool hasBiometrics = await auth.canCheckBiometrics;

      if (hasBiometrics) {
        bool pass = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint',
        );

        if (pass || rememberMe == true) {
          setState(() {
            msg = "You are Authenticated.";
            _simulateLogin();
          });
        }
      } else {
        setState(() {
          _bioLogin = false; // Clear _bioLogin value
          msg = "Fingerprint authentication not available.";
        });
      }
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _bioLogin = false; // Clear _bioLogin value
        msg = "Error while opening fingerprint/face scanner";
      });
    }
  }

  void _simulateLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      await loginApis.fetchLoginData(context);

      setState(() {
        isLoading = false;
      });
      if (loginApis.isAllow == true) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: greenlight,
            content: Text('Login Successful'),
          ),
        );
        Get.to(const NavigationMenu());
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text('You are not Allowed to login'),
        ));
      }
      // ignore: use_build_context_synchronously
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: warning,
          content: Text('Login failed. Please try again later.'),
        ),
      );

      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgroundimage.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 30,
                  width: 150.w,
                  height: 42.h,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/unitedlogo.png'))),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 125.w,
                  width: 130.w,
                  height: 180.h,
                  child: FadeAnimation(
                      delay: 1.2,
                      opacity: 1.0,
                      xOffset: 50.0,
                      child: SvgPicture.asset(clocklogo)),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FadeAnimation(
                  delay: 1.5,
                  opacity: 1.0,
                  xOffset: 100.0,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(121, 123, 148, 0.494),
                              blurRadius: 10.0,
                              offset: Offset(1, 10),
                            )
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: white))),
                                child: TextFormField(
                                  controller: _loginController.username,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Username',
                                      hintStyle: TextStyle(color: greyColor)),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: obscurePassword,
                                  controller: _loginController.password,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle:
                                          const TextStyle(color: greyColor),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            obscurePassword = !obscurePassword;
                                          });
                                        },
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: darkblue,
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                            side: const BorderSide(color: greylight),
                          ),
                          Text(
                            'Remember Me',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: greylight,
                                    fontWeight: FontWeight.normal),
                          ),
                          const Spacer(),
                          SizedBox(width: 20.w),
                          Text(
                            'BioLogin',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: greylight,
                                    ),
                          ),
                          Switch(
                            value: _bioLogin,
                            onChanged: (value) {
                              setState(() {
                                _bioLogin = value;
                                if (_bioLogin) {
                                  _authenticateWithFingerprint();
                                }
                              });
                            },
                            activeColor: const Color(0xff333D55),
                            activeTrackColor:
                                const Color(0xff333D55).withOpacity(0.2),
                            inactiveThumbColor: Colors.grey,
                            trackOutlineColor:
                                const MaterialStatePropertyAll(white),
                            inactiveTrackColor: Colors.grey.withOpacity(0.2),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            bool isConnected = await networkcontroller
                                .checkInternetConnectivity();
                            if (!isConnected) {
                              // ignore: use_build_context_synchronously
                              networkcontroller
                                  .showNetworkErrorMessage(context);
                              // ignore: use_build_context_synchronously
                            } else {
                              setState(() {
                                if (_loginController.username.text
                                        .trim()
                                        .isEmpty ||
                                    _loginController.password.text
                                        .trim()
                                        .isEmpty) {
                                  if (rememberMe) {
                                    _loginController.saveCredentials(
                                      _loginController.username.text.trim(),
                                      _loginController.password.text.trim(),
                                    );
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please Enter Your Username & Password.'),
                                    ),
                                  );
                                } else {
                                  if (!isLoading) {
                                    _simulateLogin();
                                  }
                                }
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.0587,
                            decoration: BoxDecoration(
                              color: darkblue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isLoading ? 'Loading...' : "Log In",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

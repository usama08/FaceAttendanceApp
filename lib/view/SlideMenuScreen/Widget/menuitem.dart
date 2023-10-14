import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/controller/shared_preference.dart';
import 'package:geoofficeclock/view/Login/components/login_screen.dart';
import 'package:geoofficeclock/view/Login/controller/login_controller.dart';
import 'package:get/get.dart';

final _loginController = Get.put(LoginController());
Widget itemMenu(BuildContext context, svgicon, text, Function() onpress) {
  return GestureDetector(
    onTap: onpress,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  svgicon,
                  color: black,
                ),
                SizedBox(width: 5.w),
                Text(
                  text,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                ),
              ],
            )
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios_outlined,
          color: greylight,
          size: 18,
        ),
      ],
    ),
  );
}

Widget logout(BuildContext context, text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.logout,
                color: greylight,
                size: 25,
              ),
              SizedBox(width: 5.w),
              Text(
                text,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
            ],
          )
        ],
      ),
      const Icon(
        Icons.arrow_forward_ios_outlined,
        color: greylight,
        size: 18,
      ),
    ],
  );
}

Future<void> logOut(BuildContext context) async {
  // Clear user data or perform any necessary cleanup
  // Clear specific keys in SharedPreferences
  await SharedPref.saveLoggedIn(false); // Set isLoggedIn to false
  await SharedPref.saveUserName(''); // Clear the username
  await SharedPref.savePassword(''); // Clear the password

  // Clear the text fields in the login screen
  _loginController.username.clear();
  _loginController.password.clear();
  Get.deleteAll();
  // Navigate to the login screen
  Get.to(const LoginScreen());
}

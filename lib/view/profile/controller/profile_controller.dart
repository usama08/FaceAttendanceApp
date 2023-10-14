import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constant/app_colors.dart';
import '../../../widgets/sction_button.dart';
import '../Widget/custom_button.dart';
import '../Widget/textfield.dart';

class ProfileController extends GetxController {
  //// -------------------   change password    ---------------------  /////
  void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: greylight,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                textfieldCustom(context, "Current Password", true),
                SizedBox(height: 8.h),
                textfieldCustom(context, "New Password", true),
                SizedBox(height: 8.h),
                textfieldCustom(context, "Comfirm Password", true),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    actionButton2(context, blue, "Save Changes", white),
                    actionButton2(context, white, "Cancel", black),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //// -------------------   change password -------------  /////
  void showUserInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Personal Information",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: greylight,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                textfieldCustom(context, "Username", false),
                SizedBox(height: 8.h),
                textfieldCustom(context, "Email", false),
                SizedBox(height: 8.h),
                textfieldCustom(context, "Number", false),
                SizedBox(height: 8.h),
                textfieldCustom(context, "DoB", false),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    actionButton3(context, theme, "Save Changes", () {}),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

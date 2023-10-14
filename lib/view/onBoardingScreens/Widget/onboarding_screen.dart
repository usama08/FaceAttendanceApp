import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/svg_image.dart';

class CustomScreen extends StatelessWidget {
  final String imagePath;
  final Color backgroundColor;
  final Color decoration;
  final String text1;
  final String text2;
  final String text3;
  final Color textcolor;
  final bool value;

  const CustomScreen({
    Key? key,
    required this.imagePath,
    required this.backgroundColor,
    required this.decoration,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.textcolor,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: SizedBox(
              width: 328.w,
              height: 276.59.h,
              child: Image(
                image: AssetImage(imagePath),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 3.375,
                height: MediaQuery.of(context).size.height * 0.505,
                decoration: BoxDecoration(
                  color: decoration,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0.r),
                    topRight: Radius.circular(20.0.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text1,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 24, color: headingText),
                      ),
                      SizedBox(height: 15.h),
                      Text(text2,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 36,
                                    color: textcolor,
                                    fontWeight: FontWeight.bold,
                                  )),
                      SizedBox(height: 15.h),
                      Container(
                        width: 50.w,
                        height: 2.h,
                        color: theme,
                      ),
                      SizedBox(height: 30.h),
                      Text(text3,
                          maxLines: 5,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    wordSpacing: 4,
                                    height: 1.5,
                                    fontSize: 14,
                                    color: textcolor,
                                  )),
                      SizedBox(height: 15.h),
                      value == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    featuresWidget(context, "Mark Attendance"),
                                    SizedBox(height: 10.h),
                                    featuresWidget(context, "Leave Management"),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    featuresWidget(
                                        context, "Check Leave Balances"),
                                    SizedBox(height: 10.h),
                                    featuresWidget(
                                        context, " View Attendance History "),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget featuresWidget(BuildContext context, features) {
  return Row(
    children: [
      SvgPicture.asset(
        checkboxicon,
        width: MediaQuery.of(context).size.width * 0.020,
        height: MediaQuery.of(context).size.height * 0.025,
        // color: Colors.white,
      ),
      SizedBox(width: 10.w),
      Text(
        features,
        maxLines: 2,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              wordSpacing: 2,
              height: 1.5,
              fontSize: 12,
              color: black,
            ),
      ),
    ],
  );
}

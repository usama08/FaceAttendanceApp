import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/svg_image.dart';

Widget notificationscreen(BuildContext context, texthead, status, time) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(
        children: [
          SvgPicture.asset(
            notificationsvg,
            width: MediaQuery.of(context).size.width * 0.050,
            height: MediaQuery.of(context).size.height * 0.060,
          )
        ],
      ),
      SizedBox(width: 10.w),
      Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width * 0.720,
        // height: MediaQuery.of(context).size.height * 0.090,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              texthead,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: black,
                  ),
            ),
            RichText(
              text: TextSpan(
                text: 'Your leave Request from ',
                style: const TextStyle(
                    color: black,
                    letterSpacing: 1.5,
                    fontFamily: 'Satoshi-Regular'),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'May 28 ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blue,
                          letterSpacing: 1.5,
                          fontFamily: 'Satoshi-Regular')),
                  const TextSpan(text: 'to '),
                  const TextSpan(
                      text: 'May 29 ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blue,
                          letterSpacing: 1.5,
                          fontFamily: 'Satoshi-Regular')),
                  const TextSpan(text: 'has been '),
                  TextSpan(
                      text: status,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blue,
                          letterSpacing: 1.5,
                          fontFamily: 'Satoshi-Regular')),
                ],
              ),
            ),
            Text(
              time,
            )
          ],
        ),
      ),
    ],
  );
}

///////--------------Attendane Widget ----------------/////
Widget notificationattendan(
  BuildContext context,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Column(
        children: [
          SvgPicture.asset(
            notificationsvg,
            width: MediaQuery.of(context).size.width * 0.050,
            height: MediaQuery.of(context).size.height * 0.060,
          )
        ],
      ),
      SizedBox(width: 10.w),
      Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width * 0.720,
        // height: MediaQuery.of(context).size.height * 0.080,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: black,
                  ),
            ),
            RichText(
              text: const TextSpan(
                text: 'Your Just Marked Your Attendance at ',
                style: TextStyle(color: black, letterSpacing: 1.5),
                children: <TextSpan>[
                  TextSpan(
                      text: '9:02 AM',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blue,
                          letterSpacing: 1.5)),
                ],
              ),
            ),
            const Text(
              "May 5 8:03 AM",
            )
          ],
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constant/app_colors.dart';

Widget attendanceShow(BuildContext context, days1, days2, text3, image, color) {
  return Container(
    width: 155.w,
    // height: 85.h,
    // color: white,
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: blurcolor.withOpacity(0.10),
          offset: const Offset(0, 14),
          blurRadius: 32,
          spreadRadius: 0,
        )
      ],
    ),
    padding: const EdgeInsets.all(5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    days1,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: color, fontFamily: "Satoshi-Bold"),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: days2,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                      children: <TextSpan>[
                        TextSpan(
                          text: " ",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: greyColor),
                        ),
                        TextSpan(
                          text: text3,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: greyColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              height: 51.h,
              width: 48.w,
              child: SvgPicture.asset(image),
            )
          ],
        )
      ],
    ),
  );
}

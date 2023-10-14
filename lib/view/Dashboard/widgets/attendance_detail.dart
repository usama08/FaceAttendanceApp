import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constant/app_colors.dart';
import '../../../responsiveutil/responsive.dart';

Widget timeDuration(BuildContext context, icon, text, color1, {Color? color}) {
  // bool button = false;

  return Container(
    width: MediaQuery.of(context).size.width * 0.422,
    height: MediaQuery.of(context).size.height * 0.058,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: borderside,
        width: 1.w,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          icon,
          width: 27.w, // Specify the desired width
          height: 26.h, // Specify the desired height
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: color1,
              ),
        ),
      ],
    ),
  );
}

/////// --------------- Date Picker ----------------------------------------//////////////

/////// ---------------check in and check out button -----------------------//////////////
Widget checkButton(
  BuildContext context,
  color,
  icon,
  iconcolor,
  text,
  color1,
) {
  return Container(
    alignment: Alignment.center,
    width: ResponsiveUtils.getWidth(context, 0.400),
    height: ResponsiveUtils.getHeight(context, 0.0569),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: borderside,
        width: 1.w,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 5),
        ImageIcon(
          AssetImage(icon),
          size: 16,
          color: iconcolor,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: color1,
              ),
        ),
        SizedBox(width: 5.w),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoofficeclock/constant/app_colors.dart';

Widget actionButton2(BuildContext context, color, text, color1) {
  return Container(
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.1.w, color: greylight)),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 0.322,
    height: MediaQuery.of(context).size.height * 0.052,
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color1,
          ),
    ),
  );
}

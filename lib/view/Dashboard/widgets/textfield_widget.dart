import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constant/app_colors.dart';

Widget textfield(BuildContext context, controller) {
  return Container(
      width: MediaQuery.of(context).size.width * 3.300,
      height: MediaQuery.of(context).size.height * 0.138,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: borderside,
          width: 1.w,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Write here...',
              hintStyle: TextStyle(color: greyColor),
              labelStyle: TextStyle(color: borderside)),
        ),
      ));
}

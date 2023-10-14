import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

Widget textfieldCustom(BuildContext context, labeltext, bool value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        labeltext,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w400),
      ),
      const SizedBox(height: 4),
      TextField(
        obscureText: value,
        decoration: const InputDecoration(
          filled: true,
          fillColor: greylite,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
        ),
      ),
    ],
  );
}

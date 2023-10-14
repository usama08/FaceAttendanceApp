import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

bool isLoading = false;
Widget actionButton(BuildContext context, Color color, String text,
    Function() onpress, bool isLoading) {
  return GestureDetector(
    onTap: isLoading ? null : onpress,
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 3.375,
      height: MediaQuery.of(context).size.height * 0.0587,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
    ),
  );
}

Widget actionButton3(BuildContext context, color, text, Function() onpress) {
  return GestureDetector(
    onTap: onpress,
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.675,
      height: MediaQuery.of(context).size.height * 0.0587,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: white,
            ),
      ),
    ),
  );
}

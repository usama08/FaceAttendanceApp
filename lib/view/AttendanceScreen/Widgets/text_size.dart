import 'package:flutter/material.dart';
import '../../../constant/app_colors.dart';

////// ---------------- heading -------------- /////////
Widget heading(BuildContext context, heading) {
  return Text(
    heading,
    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: mpscreenfont,
        ),
  );
}

/// --------------- textCustom ---------------- ///////////
Widget texttype(BuildContext context, texttype) {
  return Text(
    texttype,
    style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: border,
        ),
  );
}

//// ---------- customBorder -----------------//////
Widget customBorder(BuildContext context) {
  return Container(
    height: 42,
    width: 0.1,
    color: border,
  );
}

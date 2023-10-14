import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

Widget datetime(BuildContext context, text, text2) {
  return Container(
    decoration: BoxDecoration(
      color: lightgreeen,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: black,
              ),
        ),
        Text(
          text2,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: black,
              ),
        ),
      ],
    ),
  );
}

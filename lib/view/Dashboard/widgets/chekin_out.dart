import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

Widget checkinout(
  BuildContext context,
  image,
  text1,
  text2,
) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.434,
    height: MediaQuery.of(context).size.height * 0.0999,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: blurcolor.withOpacity(0.18),
          offset: const Offset(0, 14),
          blurRadius: 32,
          spreadRadius: 0,
        )
      ],
      image: DecorationImage(
        image: ExactAssetImage(image),
        fit: BoxFit.cover,
      ),
    ),
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(text1,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: primarycolor,
                  fontFamily: 'Satoshi-Bold',
                )),
        Text(text2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: primarycolor,
                )),
      ],
    ),
  );
}

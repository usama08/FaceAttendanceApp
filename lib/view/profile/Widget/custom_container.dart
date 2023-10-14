import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:get/get.dart';
import '../../../constant/svg_image.dart';
import '../controller/profile_controller.dart';

Widget infoUser(BuildContext context, text1, textresponse) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 0, 40.10, 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: black,
              ),
        ),
        Text(
          textresponse,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: profiletext,
                fontSize: 12,
              ),
        ),
      ],
    ),
  );
}

////////////-----------  Custom  Container -----------///////////////

Widget customContainer(BuildContext context, text, bool value) {
  var controller = Get.put(ProfileController());
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 3.012,
    // height: MediaQuery.of(context).size.height * 0.065,
    decoration: const BoxDecoration(
      color: greylite,
    ),
    padding: const EdgeInsets.fromLTRB(40, 15, 40.0, 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: black,
              ),
        ),
        value == true
            ? GestureDetector(
                onTap: () {
                  controller.showUserInfoDialog(context);
                },
                child: SvgPicture.asset(
                  editing,
                  width: MediaQuery.of(context).size.width * 0.018,
                  height: MediaQuery.of(context).size.height * 0.014,
                ),
              )
            : const SizedBox()
      ],
    ),
  );
}

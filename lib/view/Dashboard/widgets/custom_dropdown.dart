import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geoofficeclock/provider_service/apis_services/controller_date.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/svg_image.dart';

class DropDown extends StatefulWidget {
  const DropDown({
    Key? key,
  }) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String selectedValue = "Select Leave type";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: "Select Leave type",
        child: Text(
          "Select Leave type",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: greyColor,
              ),
        ),
      ),
      DropdownMenuItem(
        value: "2",
        child: Row(
          children: [
            SvgPicture.asset(
              sickl, // Replace with your image path
              width: 32.w,
              height: 29.h,
            ),
            const SizedBox(width: 14),
            Text(
              "Sick Leave",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: black,
                  ),
            ),
            SizedBox(width: 150.w),
          ],
        ),
      ),
      DropdownMenuItem(
        value: "3",
        child: Row(
          children: [
            SvgPicture.asset(
              urgentleave, // Replace with your image path
              width: 32.w,
              height: 29.h,
            ),
            SizedBox(width: 14.w),
            Text(
              "Earned leave",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: black,
                  ),
            ),
            SizedBox(width: 150.w),
          ],
        ),
      ),
      DropdownMenuItem(
        value: "1",
        child: Row(
          children: [
            SvgPicture.asset(
              casualleave, // Replace with your image path
              width: 36.w,
              height: 26.h,
            ),
            SizedBox(width: 12.w),
            Text(
              "Casual Leave",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: black,
                  ),
            ),
            SizedBox(width: 150.w),
          ],
        ),
      ),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final controllerProvidertext =
        Provider.of<DatePicker>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width * 0.905,
      height: MediaQuery.of(context).size.height * 0.058,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderside,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controllerProvidertext.selectedValue,
          dropdownColor: Colors.white,
          elevation: 3,
          style: const TextStyle(color: dropdown, fontSize: 10),
          onChanged: (String? newValue) {
            setState(() {
              controllerProvidertext.selectedValue = newValue!;
              print("va$selectedValue");
            });
          },
          items: dropdownItems,
        ),
      ),
    );
  }
}

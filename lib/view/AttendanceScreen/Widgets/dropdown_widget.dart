import 'package:flutter/material.dart';
import 'package:geoofficeclock/constant/app_colors.dart';

class DropDownvalue extends StatefulWidget {
  const DropDownvalue({super.key, Key? key1});

  @override
  State<DropDownvalue> createState() => _DropDownvalueState();
}

class _DropDownvalueState extends State<DropDownvalue> {
  String selectedValue = "Present";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: "Present",
        child: Text(
          "Present",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
              ),
        ),
      ),
      DropdownMenuItem(
        value: "Sick Leave",
        child: Text(
          "Sick Leave",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
              ),
        ),
      ),
      DropdownMenuItem(
        value: "Urgent Work",
        child: Text(
          "Urgent Work",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
              ),
        ),
      ),
      DropdownMenuItem(
        value: "Casual Leave",
        child: Text(
          "Casual Leave",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
              ),
        ),
      ),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.905,
      height: MediaQuery.of(context).size.height * 0.048,
      // Adjust the width as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderside,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          dropdownColor: Colors.white,
          elevation: 3,
          style: const TextStyle(color: dropdown, fontSize: 10),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: dropdownItems,
        ),
      ),
    );
  }
}

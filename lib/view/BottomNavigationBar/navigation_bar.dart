import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../constant/svg_image.dart';
import '../AttendanceScreen/components/attendance_screen.dart';
import '../Dashboard/components/dashboard_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;
  final screens = [
    const DashBoard(),
    const AttendanceScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          currentIndex == 0
              ? BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    homefill,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Home",
                )
              : BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    homeicon,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Home",
                ),
          currentIndex == 1
              ? BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    calenderfill,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Attendance",
                )
              : BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    attendance,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Attendance",
                ),
          currentIndex == 2
              ? BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    bellfill,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Notification",
                )
              : BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    notificationicon,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Notification",
                ),
          currentIndex == 3
              ? BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    userfill,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Profile",
                )
              : BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    userprofileicon,
                    width: 22.w,
                    height: 22.h,
                  ),
                  label: "Profile",
                )
        ],
      ),
    );
  }
}

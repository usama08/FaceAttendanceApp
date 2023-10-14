import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoofficeclock/Loading/animation_loading.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/constant/svg_image.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/view/AttendanceScreen/components/attendance_screen.dart';
import 'package:geoofficeclock/view/BottomNavigationBar/navigation_bar.dart';
import 'package:geoofficeclock/view/Dashboard/components/markattendance.dart';
import 'package:geoofficeclock/view/SlideMenuScreen/Widget/menuitem.dart';
import 'package:geoofficeclock/view/profile/profile_screen.dart';
import 'package:get/get.dart';

bool isLoading = false;

class SideMenuBar extends StatefulWidget {
  final GlobalKey<SliderDrawerState> sliderDrawerKey;

  const SideMenuBar({
    Key? key,
    required this.sliderDrawerKey,
  }) : super(key: key);

  @override
  State<SideMenuBar> createState() => _SideMenuBarState();
}

class _SideMenuBarState extends State<SideMenuBar> {
  final loginController = Get.put(LoginApis());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      userinfo,
                      width: MediaQuery.of(context).size.width * 0.142,
                      height: MediaQuery.of(context).size.height * 0.142,
                    ),
                    Text(
                      loginController.username.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    itemMenu(context, sideitem1, "Mark Attendance", () async {
                      Get.to(const MarkAttendance());
                      setState(() {
                        isLoading = true;
                      });

                      setState(() {
                        isLoading = false;
                        widget.sliderDrawerKey.currentState?.closeSlider();
                      });
                    }),
                    SizedBox(height: 15.h),
                    itemMenu(context, sideitem2, "Dashboard", () async {
                      Get.to(const NavigationMenu());
                      setState(() {
                        isLoading = true;
                      });

                      setState(() {
                        isLoading = false;
                        widget.sliderDrawerKey.currentState?.closeSlider();
                      });
                    }),
                    SizedBox(height: 15.h),
                    itemMenu(context, sideitem3, "Profile page", () async {
                      Get.to(const ProfileScreen());
                      setState(() {
                        isLoading = true;
                      });

                      setState(() {
                        isLoading = false;
                        widget.sliderDrawerKey.currentState?.closeSlider();
                      });
                    }),
                    SizedBox(height: 15.h),
                    itemMenu(context, sideitem4, "Attendance History",
                        () async {
                      Get.to(const AttendanceScreen());
                      setState(() {
                        isLoading = true;
                      });

                      setState(() {
                        isLoading = false;
                        widget.sliderDrawerKey.currentState?.closeSlider();
                      });
                    }),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: logout(
                        context,
                        "Logout",
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Version  1.0.3",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: version,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
        if (isLoading)
          Container(
            color: const Color.fromARGB(255, 202, 201, 201).withOpacity(0.5),
            child: const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimationLoader(),
                Text(
                  "Loading...",
                  style: TextStyle(color: black),
                )
              ],
            )),
          ),
      ],
    );
  }
}

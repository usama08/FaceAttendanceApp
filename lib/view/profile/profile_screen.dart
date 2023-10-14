import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/view/SlideMenuScreen/Widget/SideMenuscreenWidget.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';
import '../../constant/svg_image.dart';
import 'Widget/custom_container.dart';
import 'controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var controllerprofile = Get.put(ProfileController());
  final loginController = Get.put(LoginApis());
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    sliderDrawerKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliderDrawer(
      appBar: SliderAppBar(
        drawerIconColor: blue,
        isTitleCenter: true,
        appBarPadding: const EdgeInsets.only(
          top: 30,
        ),
        appBarHeight: MediaQuery.of(context).size.height * 0.09,
        appBarColor: Colors.white,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: blue, fontWeight: FontWeight.bold),
        ),
      ),
      slider: SideMenuBar(sliderDrawerKey: sliderDrawerKey),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    child: SvgPicture.asset(
                      profilesvg,
                      width: MediaQuery.of(context).size.width * 0.142,
                      height: MediaQuery.of(context).size.height * 0.142,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    loginController.username.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Emp ID :${loginController.empID.toString()}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: black, fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ////-----------   Header Container -----------////
            customContainer(context, "Personal Information", true),
            SizedBox(height: 20.h),
            ///// ---------   user info widget -----------///
            infoUser(context, "Username", "Nauman Aziz"),
            infoUser(context, "Email", "nauman.aziz@theunitedsoftware.com"),
            infoUser(context, "Number", "0300-1234567"),
            infoUser(context, "DoB", "13-April,1985"),
            SizedBox(height: 10.h),
            ////// ---------  header container -----------/////
            customContainer(context, "Settings", false),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                controllerprofile.showChangePasswordDialog(context);
              },
              child: SizedBox(
                width: 309.w,
                height: 62.h,
                // padding: const EdgeInsets.fromLTRB(40, 0, 40.10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          lock,
                          width: MediaQuery.of(context).size.width * 0.015,
                          height: MediaQuery.of(context).size.height * 0.018,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Change Password",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: black,
                                  ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      arrowforward,
                      width: MediaQuery.of(context).size.width * 0.015,
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoofficeclock/Loading/animation_fade.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/constant/app_icons.dart';
import 'package:geoofficeclock/constant/svg_image.dart';
import 'package:geoofficeclock/network_utils/connectivity.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/view/Dashboard/controller/dashboard_controller.dart';
import 'package:geoofficeclock/view/SlideMenuScreen/Widget/SideMenuscreenWidget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Loading/animation_loading.dart';
import '../../../constant/common _image.dart';
import '../../../controller/global_controller.dart';
import '../../../provider_service/apis_services/controller_date.dart';
import '../../../widgets/sction_button.dart';
import '../../../widgets/status_widget.dart';
import '../widgets/attendance_detail.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/textfield_widget.dart';
import 'markattendance.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey();
  var date = Get.put(Globalfunctions());
  final controller = Get.put(DashboardController());
  final networkcontroller = Get.put(NetworkConnect());
  final loginController = Get.put(LoginApis());
  SharedPreferences? prefs;
  bool isLoading = false;
  bool Loading = false;
  // int empid = 0;
  String userName = '';
  bool dataFetched = false;
  DatePicker datePickerProvider = DatePicker();
  bool search = false;
  bool demo = true;

  @override
  void initState() {
    super.initState();

    Provider.of<DatePicker>(context, listen: false).fetchreport();
    initPrefs().then((_) {
      setState(() {});
    });
  }

/////////////////////////------------------- refresh -------------------- ///////////////////////////
  void refresh() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    userName = prefs?.getString('userName') ?? '';
    print(userName);
  }

  Future<bool> _onBackPressed() async {
    return false;
  }

  ///////////////////////-------------------  close the App  --------------////////////////////

  void markAttendance() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(const MarkAttendance());

      setState(() {
        isLoading = false;
      });
    });
  }

  //////////////// -----------------------------     Network ------------------------- ///////////////////
  @override
  void dispose() {
    AnimationLoader;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerProvidertext =
        Provider.of<DatePicker>(context, listen: true);

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
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
              "Dashboard",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: blue, fontWeight: FontWeight.bold),
            ),
          ),
          slider: SideMenuBar(sliderDrawerKey: sliderDrawerKey),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          delay: 1.1,
                          opacity: 1.0,
                          xOffset: 100.0,
                          child: Text(
                            "Morning, ${loginController.username.value.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: blue,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controllerProvidertext.resetDates();
                            controllerProvidertext.selectDate(
                                context: context, type: "start");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.350,
                            height: MediaQuery.of(context).size.height * 0.038,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: borderside,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(controllerProvidertext.formattedDate
                                    .toString()),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 22,
                                  color: greylight,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controllerProvidertext.resetDates();
                            controllerProvidertext.selectDate(
                                context: context, type: "enddate");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.350,
                            height: MediaQuery.of(context).size.height * 0.038,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: borderside,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(controllerProvidertext.endDate.toString()),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 22,
                                  color: greylight,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool isConnected = await networkcontroller
                                .checkInternetConnectivity();
                            if (!isConnected) {
                              // ignore: use_build_context_synchronously
                              networkcontroller
                                  .showNetworkErrorMessage(context);
                              // ignore: use_build_context_synchronously
                            } else {
                              controllerProvidertext.resetDates;
                              Loading = true; // Show loading indicator
                              demo = false; // Reset demo flag
                              isLoading ? null : refresh();
                              await controllerProvidertext.fetchreport();

                              Loading = false; // Hide loading indicator
                            }
                          },
                          child: Container(
                            width: 61.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: searchcolor,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Icon(
                              Icons.search,
                              size: 25,
                              color: blue,
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 10.h),
                    FadeAnimation(
                      delay: 1.2,
                      opacity: 1.0,
                      xOffset: 100.0,
                      child: GestureDetector(
                        onTap: isLoading ? null : markAttendance,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 3.435,
                          // height: MediaQuery.of(context).size.height * 0.0699,
                          decoration: BoxDecoration(
                            color: isLoading ? greylite : white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: blurcolor.withOpacity(0.10),
                                offset: const Offset(0, 14),
                                blurRadius: 32,
                                spreadRadius: 0,
                              )
                            ],
                            // border: Border.all(
                            //   color: borderside,
                            //   width: 0.2,
                            // ),
                            image: const DecorationImage(
                              image: ExactAssetImage(mark2),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 30.0.h,
                                    width: 31.0.w,
                                    child: SvgPicture.asset(
                                      iconsvg,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10.0.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mark Attendance",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: blue,
                                            ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        controllerProvidertext.currentDateformat
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: dropdown,
                                            ),
                                      ),
                                      SizedBox(height: 2.h),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 50.0.w),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageIcon(
                                    AssetImage(arrow),
                                    size: 16,
                                    color: blue,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    ////      ------------ Attendance Details -----------------    ////
                    // context.watch<DatePicker>().isLoading
                    //     ? const Center(
                    //         child: AnimationLoader(),
                    //       )
                    //     :
                    FadeAnimation(
                      delay: 1.3,
                      opacity: 1.0,
                      xOffset: 100.0,
                      child: Wrap(
                          spacing: 20,
                          runSpacing: 15,
                          alignment: WrapAlignment.spaceEvenly,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            attendanceShow(
                              context,
                              "Presents",
                              controllerProvidertext.presents == null
                                  ? '..'
                                  : controllerProvidertext.presents.toString(),
                              "Days",
                              presentsvg,
                              green,
                            ),
                            attendanceShow(
                                context,
                                "Absent",
                                controllerProvidertext.totalAbsent == null
                                    ? '..'
                                    : controllerProvidertext.totalAbsent
                                        .toString(),
                                "Days",
                                absentsvg,
                                warning),
                            attendanceShow(
                                context,
                                "Late",
                                controllerProvidertext.latedays == null
                                    ? '..'
                                    : controllerProvidertext.latedays
                                        .toString(),
                                "Days",
                                latesvg,
                                late),
                            attendanceShow(
                                context,
                                "Leaves",
                                controllerProvidertext.leaves == null
                                    ? '..'
                                    : controllerProvidertext.leaves.toString(),
                                "Days",
                                leavesvg,
                                leave),
                          ]),
                    ),

                    SizedBox(height: 15.h),

                    ///-----------         map        ----------------///
                    Container(
                      width: MediaQuery.of(context).size.width * 3.335,
                      height: MediaQuery.of(context).size.height * 0.1119,
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: blurcolor.withOpacity(0.10),
                            offset: const Offset(0, 14),
                            blurRadius: 32,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Today’s Route",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: mpscreenfont,
                                        )),
                                Text("02",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: black,
                                        )),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.015,
                                height:
                                    MediaQuery.of(context).size.height * 0.1119,
                                color: mpscreenfont,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.460,
                                height:
                                    MediaQuery.of(context).size.height * 0.1119,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: ExactAssetImage(mapmark),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: MediaQuery.of(context).size.width * 3.315,
                      // height: MediaQuery.of(context).size.height * 0.512,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              blurStyle: BlurStyle.normal,
                              color: gryblur,
                              blurRadius: 80.0,
                              spreadRadius: -6.0, //extend the shadow
                              offset: Offset(
                                20.0,
                                60.0,
                              ))
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Leave Request",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: dropdown,
                                  ),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          //// ------------ Widget timeduration ---------///
                          Wrap(
                            spacing: 20,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controllerProvidertext.resetDates();
                                  controllerProvidertext.selectDate(
                                      context: context, type: "hrfrom");
                                },
                                child: timeDuration(
                                  context,
                                  calender2svg,
                                  controllerProvidertext.formattedFirstfullday
                                      .toString(),
                                  darkblue,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controllerProvidertext.resetDates();
                                  controllerProvidertext.selectDate(
                                      context: context, type: "hrto");
                                },
                                child: timeDuration(
                                  context,
                                  calender2svg,
                                  controllerProvidertext.formattedLastfullday
                                      .toString(),
                                  darkblue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Obx(() {
                            return FadeAnimation(
                              delay: 1.5,
                              opacity: 1.0,
                              xOffset: 100.0,
                              child: Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        // print("print");

                                        controller.button.value =
                                            !controller.button.value;
                                        if (controller.button.value) {
                                          controller.button2.value = false;
                                        }
                                      },
                                      child: timeDuration(
                                        context,
                                        clock,
                                        "Half Day",
                                        controller.button.value
                                            ? white
                                            : darkblue,
                                        color: controller.button.value
                                            ? darkblue
                                            : white,
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        // print("print");

                                        controller.button2.value =
                                            !controller.button2.value;
                                        if (controller.button2.value) {
                                          controller.button.value = false;
                                          controllerProvidertext
                                              .hasBeenPressed = false;
                                          controllerProvidertext
                                              .hasBeenPressed2 = false;
                                          controllerProvidertext
                                              .calculateDateTimeDifference(
                                                  controllerProvidertext
                                                      .firstfullday,
                                                  controllerProvidertext
                                                      .lastfullday);
                                        }
                                      },
                                      child: timeDuration(
                                        context,
                                        calendersvg,
                                        "Full Day",
                                        controller.button2.value
                                            ? white
                                            : darkblue,
                                        color: controller.button2.value
                                            ? darkblue
                                            : white,
                                      ),
                                    ),
                                  ),
                                  if (controller.button.value)
                                    GestureDetector(
                                      onTap: () {
                                        // print("12:00 pm");
                                      },
                                      child: Wrap(
                                        spacing: 20,
                                        children: [
                                          InkWell(
                                            hoverColor: redColor,
                                            mouseCursor:
                                                SystemMouseCursors.click,
                                            onTap: () {
                                              controllerProvidertext
                                                  .updateControllerValue();
                                              setState(() {
                                                controllerProvidertext
                                                        .hasBeenPressed =
                                                    !controllerProvidertext
                                                        .hasBeenPressed;
                                                if (controllerProvidertext
                                                    .hasBeenPressed) {
                                                  controllerProvidertext
                                                      .hasBeenPressed2 = false;
                                                }

                                                print(
                                                    "value${controllerProvidertext.firsthalf.toString()}");
                                                // Change the color to black when tapped
                                              });
                                            },
                                            child: timeDuration(
                                              context,
                                              clock,
                                              "First Half",
                                              controllerProvidertext
                                                      .hasBeenPressed
                                                  ? white
                                                  : darkblue,
                                              color: controllerProvidertext
                                                      .hasBeenPressed
                                                  ? darkblue
                                                  : white,
                                            ),
                                          ),
                                          InkWell(
                                            mouseCursor:
                                                SystemMouseCursors.click,
                                            onTap: () {
                                              controllerProvidertext
                                                  .updateControllerValue2();
                                              setState(() {
                                                controllerProvidertext
                                                        .hasBeenPressed2 =
                                                    !controllerProvidertext
                                                        .hasBeenPressed2;
                                                if (controllerProvidertext
                                                    .hasBeenPressed2) {
                                                  controllerProvidertext
                                                      .hasBeenPressed = false;
                                                }
                                                print(
                                                    "value${controllerProvidertext.firsthalf.toString()}");
                                                // Change the color to black when tapped
                                              });
                                            },
                                            child: timeDuration(
                                              context,
                                              clock,
                                              "Second Half",
                                              controllerProvidertext
                                                      .hasBeenPressed2
                                                  ? white
                                                  : darkblue,
                                              color: controllerProvidertext
                                                      .hasBeenPressed2
                                                  ? darkblue
                                                  : white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }),

                          SizedBox(height: 10.h),

                          ///-------dropdown class-------///
                          const FadeAnimation(
                              delay: 1.5,
                              opacity: 1.0,
                              xOffset: 100.0,
                              child: DropDown()),
                          SizedBox(height: 10.h),

                          ///-------widget textfiled---------///
                          textfield(context, controllerProvidertext.quotation),
                          SizedBox(height: 10.h),
                          ////-------widget button------///
                          actionButton(context, darkblue, "Inform HR",
                              () async {
                            if (controllerProvidertext
                                    .quotation.text.isNotEmpty &&
                                controllerProvidertext.formattedFirstfullday !=
                                    null &&
                                controllerProvidertext.formattedLastfullday !=
                                    null &&
                                controllerProvidertext.firsthalf != null &&
                                controllerProvidertext
                                    .selectedValue!.isNotEmpty) {
                              isLoading ? null : refresh();
                              // All variables are not null (not empty)
                              await controllerProvidertext
                                  .makeLeaveRequest(context);

                              controllerProvidertext.resetValues();

                              controller.button.value = false;
                              controller.button2.value = false;
                              controllerProvidertext.selectedValue;

                              print("hit");
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: searchcolor,
                                    title: Text("Error",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: blue,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),
                                    content: Text(
                                        "Please fill in all the required fields.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: black,
                                              fontSize: 16,
                                            )),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: blue,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }, false),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 0),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                  child: const Center(
                    child: AnimationLoader(),
                  ),
                ),
            ],
          ),
        )));
  }
}

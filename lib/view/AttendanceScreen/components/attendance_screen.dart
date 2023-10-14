import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/constant/svg_image.dart';
import 'package:geoofficeclock/network_utils/connectivity.dart';
import 'package:geoofficeclock/view/AttendanceScreen/Widgets/table_leavses.dart';
import 'package:geoofficeclock/view/Dashboard/widgets/tabbar_widget.dart';
import 'package:geoofficeclock/view/SlideMenuScreen/Widget/SideMenuscreenWidget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Loading/animation_loading.dart';
import '../../../controller/global_controller.dart';
import '../../../provider_service/apis_services/controller_date.dart';
import '../../../widgets/status_widget.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  var date = Get.put(Globalfunctions());
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey();
  final networkcontroller = Get.put(NetworkConnect());
  SharedPreferences? prefs;
  bool isLoading = false;
  bool Loading = false;
  bool button = false;
  bool button2 = false;
  // int empid = 0;
  String userName = '';
  bool dataFetched = false;
  DatePicker datePickerProvider = DatePicker();
  bool search = false;
  bool demo = true;

  @override
  void initState() {
    super.initState();
    Provider.of<DatePicker>(context, listen: false).alldatafetch();
  }

  Future<bool> _onBackPressed() async {
    return false;
  }

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

  @override
  Widget build(BuildContext context) {
    final controllerProvidertext =
        Provider.of<DatePicker>(context, listen: true);

    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: blue,
          isTitleCenter: true,
          appBarPadding: const EdgeInsets.only(top: 30, left: 5),
          appBarHeight: MediaQuery.of(context).size.height * 0.09,
          appBarColor: Colors.white,
          title: Text(
            "Attendance",
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
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "To",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: border,
                                  ),
                        ),
                        const SizedBox(width: 140),
                        Text(
                          "From",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: border,
                                  ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controllerProvidertext.resetDates();
                          controllerProvidertext.selectDate(
                              context: context, type: "startto");
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
                              Text(controllerProvidertext.startto.toString()),
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
                              context: context, type: "endto");
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
                              Text(controllerProvidertext.endto.toString()),
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
                            networkcontroller.showNetworkErrorMessage(context);
                            // ignore: use_build_context_synchronously
                          } else {
                            controllerProvidertext.resetDates;

                            Loading = true; // Show loading indicator
                            demo = false; // Reset demo flag

                            controllerProvidertext.alldatafetch();
                            isLoading ? null : refresh();

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

                  ////      ------------ Attendance Details -----------------    ////
                  // context.watch<DatePicker>().isLoading
                  //     ? const Center(
                  //         child: AnimationLoader(),
                  //       )
                  //     :
                  Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        attendanceShow(
                          context,
                          "Presents",
                          controllerProvidertext.allpresent.toString() == 'null'
                              ? ".."
                              : controllerProvidertext.allpresent.toString(),
                          "Days",
                          clock1,
                          green,
                        ),
                        attendanceShow(
                            context,
                            "Absent",
                            controllerProvidertext.allabsents.toString() ==
                                    'null'
                                ? ".."
                                : controllerProvidertext.allabsents.toString(),
                            "Days",
                            clender,
                            warning),
                        attendanceShow(
                            context,
                            "Late",
                            controllerProvidertext.lateMinutes.toString() ==
                                    'null'
                                ? ".."
                                : controllerProvidertext.lateMinutes.toString(),
                            "mints",
                            watch2,
                            late),
                        attendanceShow(
                            context,
                            "Working",
                            controllerProvidertext.workingHours.toString() ==
                                    'null'
                                ? ".."
                                : controllerProvidertext.workingHours
                                    .toString(),
                            "hrs",
                            workinghours,
                            leave),
                      ]),

                  SizedBox(height: 15.h),

                  context.watch<DatePicker>().isLoading
                      ? const Center(
                          child: AnimationLoader(),
                        )
                      : const MyAttendanceTable(),

                  SizedBox(height: 5.h),
                  context.watch<DatePicker>().isLoading
                      ? const Center(
                          child: AnimationLoader(),
                        )
                      : const MyTabbedContainer(),

                  ///--------------         map        ----------------///

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
      ),
    );
  }
}

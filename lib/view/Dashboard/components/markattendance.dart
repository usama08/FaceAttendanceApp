import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoofficeclock/Loading/animation_fade.dart';
import 'package:geoofficeclock/Loading/animation_loading.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/constant/app_icons.dart';
import 'package:geoofficeclock/constant/common%20_image.dart';
import 'package:geoofficeclock/camera/camera_selfi.dart';
import 'package:geoofficeclock/network_utils/connectivity.dart';
import 'package:geoofficeclock/provider_service/apis_services/controller_date.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/view/SlideMenuScreen/Widget/SideMenuscreenWidget.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/svg_image.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/attendance_detail.dart';
import '../widgets/chekin_out.dart';
import '../widgets/tabbar_widget.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({Key? key}) : super(key: key);

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  var controller = Get.put(DashboardController());
  final loginController = Get.put(LoginApis());

  Completer<GoogleMapController> mapcontroller = Completer();
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey();
  final networkcontroller = Get.put(NetworkConnect());
  bool isLoading = false;
  SharedPreferences? prefs;
  String userName = '';
  final Set<Marker> _markers = {};
  double latitudeValue = 0.0;
  double longitudeValue = 0.0;
  LatLng targetLocation = const LatLng(0.0, 0.0);
  bool _showHideButton = false; // Initially, hide the button

  // Create a Set to hold the Circle objects
  final Set<Circle> _circles = {};
  // Initialize with 0

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("H:mm").format(now);
  }

  @override
  void initState() {
    super.initState();
    initPrefs().then((_) {
      setState(() {});
    });
    Provider.of<DatePicker>(context, listen: false).currentTime.toString();
    controller.checkmarkAttendanceAPI();
    controller.getcheckStatus();
    _addCurrentLocationMarker();
    _addTargetLocationMarker();
    _checkDistanceToTarget();
    // _gettCurrentLocation();
    latitudeValue = loginController.Latitude.value;
    longitudeValue = loginController.Longitude.value;
    targetLocation = LatLng(latitudeValue, longitudeValue);

    // Initialize the Circle
    _circles.add(_createTargetCircle());
  }
//////////////-----------------///////////////////

/////////////////// MAp functions here ///////////////////////
  Circle _createTargetCircle() {
    return Circle(
      circleId: const CircleId('targetCircle'),
      center: LatLng(latitudeValue, longitudeValue),
      radius: 50.0,
      strokeWidth: 2,
      strokeColor: Colors.red,
      fillColor: Colors.red.withOpacity(0.2),
    );
  }

  Future<void> _addCurrentLocationMarker() async {
    final currentLocation = await _getCurrentLocation();

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow:
              InfoWindow(title: loginController.username.value.toString()),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    });
  }

  Future<void> _addTargetLocationMarker() async {
    setState(() {
      // _markers.add(
      //   Marker(
      //     markerId: const MarkerId('targetLocation'),
      //     position: LatLng(
      //         loginController.Latitude.value, loginController.Longitude.value),
      //     infoWindow: const InfoWindow(title: 'UIG House'),
      //     icon:
      //         BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      //   ),
      // );
    });
  }

  ///////////// --------------   Location  ---------------   //////////////

  Future<Position> _getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print("Error getting current location: $e");
      return const Position(
          longitude: 254.5555,
          latitude: 221.5556,
          timestamp: null,
          accuracy: 100,
          altitude: 55.66611,
          altitudeAccuracy: 20,
          heading: 2,
          headingAccuracy: 12,
          speed: 10,
          speedAccuracy: 10);
    }
  }

  Future<void> _checkDistanceToTarget() async {
    final currentLocation = await _getCurrentLocation();
    final distance = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      targetLocation.latitude,
      targetLocation.longitude,
    );

    setState(() {
      // If the distance is less than 50 meters, show the button; otherwise, hide it.
      _showHideButton = distance < 50.0;
    });
  }

////////////////// ---------------------- ///////////////////

  // Future<LatLng> _gettCurrentLocation() async {
  //   try {
  //     final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     return LatLng(position.latitude, position.longitude);
  //   } catch (e) {
  //     print("Error getting current location: $e");
  //     // Return a default location if there's an error
  //     return const LatLng(
  //         0.0, 0.0); // You can change this to your desired default location
  //   }
  // }
  Future<bool> checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    userName = prefs?.getString('userName') ?? '';
    print(userName);
  }

  Future<bool> _onBackPressed() async {
    return false;
  }

  void refresh() {
    setState(() {
      isLoading = true;
    });

    controller.getcheckStatus();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    getSystemTime();
    super.dispose();
  }

  Widget buildAttendancePage() {
    final provider = Provider.of<DatePicker>(context, listen: true);

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: RefreshIndicator(
              onRefresh: () async {
                controller.update();
                isLoading ? null : refresh();
              },
              child: SliderDrawer(
                  appBar: SliderAppBar(
                    drawerIconColor: blue,
                    isTitleCenter: true,
                    appBarPadding: const EdgeInsets.only(
                      top: 30,
                    ),
                    appBarHeight: MediaQuery.of(context).size.height * 0.09,
                    appBarColor: Colors.white,
                    title: Text(
                      "Mark Attendance",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: blue, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: blue,
                      ),
                      onPressed: () {
                        showLoadingDialog();
                      },
                    ),
                  ),
                  slider: const SideMenuBar(
                      sliderDrawerKey: GlobalObjectKey(Close)),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: isLoading
                            ? null
                            : SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Morning, ${loginController.username.value.toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                color: blue,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.h),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          2.054,
                                      // height:
                                      //     MediaQuery.of(context).size.height *
                                      //         0.0699,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: bordeerlight,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: black,
                                                      fontSize: 10,
                                                    ),
                                              ),
                                              SizedBox(height: 5.w),
                                              Row(
                                                children: [
                                                  Text(
                                                    provider.currentDateformat,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                          color: primarycolor,
                                                        ),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  SvgPicture.asset(
                                                    calenderr,
                                                    width: 14.w,
                                                    height: 15.h,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Time",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: black,
                                                      fontSize: 10,
                                                    ),
                                              ),
                                              SizedBox(height: 5.w),
                                              StreamBuilder<int>(
                                                stream: Stream.periodic(
                                                    const Duration(seconds: 1),
                                                    (count) => count),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      getSystemTime(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                            color: primarycolor,
                                                          ),
                                                    );
                                                  } else {
                                                    return const Text(
                                                        "Loading...");
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 0),
                                          Obx(() {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Status",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                      ),
                                                ),
                                                SizedBox(height: 5.w),
                                                Text(
                                                  controller.status.value
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: controller.status
                                                                    .value ==
                                                                "Present"
                                                            ? Colors.green
                                                            : Colors.red,
                                                      ),
                                                ),
                                              ],
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    /////// --------------    Widget Check out / in details ------------------///////
                                    Obx(() {
                                      return FadeAnimation(
                                        delay: 1.4,
                                        opacity: 1.0,
                                        xOffset: 100.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            checkinout(
                                              context,
                                              checkin,
                                              "Check In",
                                              "Late Min :${controller.latemin.value}",
                                            ),
                                            checkinout(
                                              context,
                                              checkkout,
                                              "Check Out",
                                              "Working hr : ${controller.workingHour.value}",
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 20.h),

                                    /////// ------------- Google flutter Map ----------////////////

                                    // ? Container(
                                    //     width: MediaQuery.of(context)
                                    //             .size
                                    //             .width *
                                    //         1.454,
                                    //     height: MediaQuery.of(context)
                                    //             .size
                                    //             .height *
                                    //         0.2599,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(4),
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           color: blurcolor
                                    //               .withOpacity(0.10),
                                    //           offset: const Offset(0, 14),
                                    //           blurRadius: 32,
                                    //           spreadRadius: 0,
                                    //         )
                                    //       ],
                                    //       border: Border.all(
                                    //         color: bordeerlight,
                                    //         width: 1.w,
                                    //       ),
                                    //       image: const DecorationImage(
                                    //         image:
                                    //             ExactAssetImage(mapscreen),
                                    //         fit: BoxFit.cover,
                                    //       ),
                                    //     ),
                                    //   )
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2599,
                                          child: FadeAnimation(
                                            delay: 1.5,
                                            opacity: 1.0,
                                            xOffset: 100.0,
                                            child: GoogleMap(
                                              mapType: MapType.normal,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: targetLocation,
                                                zoom: 15.0,
                                              ),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                mapcontroller
                                                    .complete(controller);
                                              },
                                              markers: _markers,
                                              zoomGesturesEnabled: true,
                                              scrollGesturesEnabled: true,
                                              gestureRecognizers: <Factory<
                                                  OneSequenceGestureRecognizer>>{
                                                Factory<OneSequenceGestureRecognizer>(
                                                    () =>
                                                        EagerGestureRecognizer())
                                              },
                                              circles:
                                                  _circles, // Use the Set of Circles here
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 16,
                                          right: 16,
                                          child: Container(
                                            width: 38,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: white.withOpacity(0.6)),
                                            child: IconButton(
                                                onPressed: () async {
                                                  // loginController.getLocation();
                                                  final currentLocation =
                                                      await _getCurrentLocation();
                                                  mapcontroller.future
                                                      .then((controller) async {
                                                    await controller
                                                        .animateCamera(
                                                      CameraUpdate.newCameraPosition(
                                                          CameraPosition(
                                                              target: LatLng(
                                                                  currentLocation
                                                                      .latitude,
                                                                  currentLocation
                                                                      .longitude))),
                                                    );
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.location_on,
                                                  size: 24,
                                                  color: greylight,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    ////// --------------------  check in and out button ----------------//////
                                    _showHideButton
                                        ? Obx(() {
                                            return Wrap(
                                              spacing: 20,
                                              runAlignment:
                                                  WrapAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    bool isConnected =
                                                        await networkcontroller
                                                            .checkInternetConnectivity();

                                                    if (!isConnected) {
                                                      // ignore: use_build_context_synchronously
                                                      networkcontroller
                                                          .showNetworkErrorMessage(
                                                              context);
                                                      // ignore: use_build_context_synchronously
                                                    } else {
                                                      if (!controller
                                                          .isAttendanceMarked
                                                          .value) {
                                                        if (loginController
                                                                .isPhoto
                                                                .value ==
                                                            true) {
                                                          Get.to(
                                                              const CameraSelfi());
                                                        } else {
                                                          // ignore: use_build_context_synchronously
                                                          controller
                                                              .showLoadingfun(
                                                                  context);
                                                          // ignore: use_build_context_synchronously
                                                          controller
                                                              .markAttendanceAPI(
                                                                  context);
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: checkButton(
                                                    context,
                                                    controller
                                                            .isAttendanceMarked
                                                            .value
                                                        ? greyColor
                                                        : darkblue,
                                                    out,
                                                    white,
                                                    "Check In",
                                                    white,
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      bool isConnected =
                                                          await checkInternetConnectivity();
                                                      if (!isConnected) {
                                                        // ignore: use_build_context_synchronously
                                                        networkcontroller
                                                            .showNetworkErrorMessage(
                                                                context);
                                                        // ignore: use_build_context_synchronously
                                                      } else {
                                                        // ignore: use_build_context_synchronously
                                                        controller
                                                            .showLoadingfun(
                                                                context);
                                                        setState(() {
                                                          if (controller
                                                              .isAttendanceMarked
                                                              .value) {
                                                            controller
                                                                .markAttendanceAPI(
                                                                    context);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: checkButton(
                                                        context,
                                                        controller
                                                                .isAttendanceMarked
                                                                .value
                                                            ? white
                                                            : greyColor,
                                                        inn,
                                                        black,
                                                        "Check Out",
                                                        black)),
                                              ],
                                            );
                                          })
                                        : Wrap(
                                            spacing: 20,
                                            runAlignment:
                                                WrapAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .showLocationErrorMessage(
                                                          context);
                                                },
                                                child: checkButton(
                                                  context,
                                                  greyColor,
                                                  out,
                                                  white,
                                                  "Check In",
                                                  white,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .showLocationErrorMessage(
                                                          context);
                                                },
                                                child: checkButton(
                                                    context,
                                                    greyColor,
                                                    inn,
                                                    black,
                                                    "Check Out",
                                                    black),
                                              ),
                                            ],
                                          ),

                                    SizedBox(height: 20.h),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Last 5 Days Attendance",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: blue,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15.h),
                                    //////------------- table show history ------------//////
                                    context.watch<DatePicker>().isLoading
                                        ? const Center(
                                            child: AnimationLoader(),
                                          )
                                        : const MyTabbedContainer(),
                                  ],
                                ),
                              ),
                      ),
                      if (isLoading)
                        Container(
                          color: white.withOpacity(0.1),
                          child: const Center(
                            child: AnimationLoader(),
                          ),
                        ),
                    ],
                  ))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return buildAttendancePage();
    }
  }

  void showLoadingDialog() {
    Get.dialog(
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AnimationLoader(),
          Text(
            "Loading...",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          )
        ],
      )),
      barrierDismissible: false,
    );

    // Simulate some loading process
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
      Get.back();
    });
  }
}

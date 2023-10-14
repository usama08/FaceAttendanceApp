// ignore_for_file: unrelated_type_equality_checks
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:geoofficeclock/Loading/animation_loading.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/constant/app_icons.dart';
import 'package:geoofficeclock/constant/common%20_image.dart';
import 'package:geoofficeclock/network_utils/connectivity.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/view/Dashboard/controller/dashboard_controller.dart';
import 'package:geoofficeclock/view/Dashboard/widgets/date_time.dart';
import 'package:geoofficeclock/view/SlideMenuScreen/Widget/SideMenuscreenWidget.dart';
import 'package:geoofficeclock/widgets/sction_button.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraSelfi extends StatefulWidget {
  const CameraSelfi({super.key});

  @override
  State<CameraSelfi> createState() => _CameraSelfiState();
}

class _CameraSelfiState extends State<CameraSelfi> {
  final loginController = Get.put(LoginApis());
  final controller = Get.put(DashboardController());
  final networkcontroller = Get.put(NetworkConnect());
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey();
  // Selected and cropped image file
  bool clearPic = false;
  bool isLoading = false; // Flag to control the image display
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    return false;
  }

  @override
  void dispose() {
    //...
    super.dispose();
    controller.markAttendanceAPI(context);
    //...
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: SliderDrawer(
            appBar: SliderAppBar(
              appBarColor: Colors.white,
              title: Text(
                "Mark Attendance",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: black, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Image.asset(arrowpng),
                onPressed: () {
                  showLoadingDialog();
                },
              ),
            ),
            slider: SideMenuBar(sliderDrawerKey: sliderDrawerKey),
            child: Column(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loginController.username.value.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: blue,
                            ),
                      ),
                      SizedBox(height: 15.h),
                      datetime(context, "Date", "${controller.currentDate}"),
                      SizedBox(height: 10.h),
                      datetime(context, "Time", "${controller.currentTime}"),
                      SizedBox(height: 10.h),
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.512,
                            child: InkWell(
                              onTap: () {
                                imagePickermethod(1); // Launch image picker
                              },
                              child: controller.image == null ||
                                      clearPic == false
                                  ? DottedBorder(
                                      dashPattern: const [10, 5],
                                      color: Colors.grey,
                                      strokeWidth: 2.0,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.512,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              addpic,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                            ),
                                            Text(
                                              'Take a selfie',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.file(
                                        controller.image!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                            ),
                          ),
                          if (clearPic == true) ...[
                            Positioned(
                              right: 5,
                              top: 0,
                              child: InkWell(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      controller.image =
                                          null; // Clear the image
                                      clearPic = false;
                                    });
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    delpic,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'First take a selfi for Mark Attendance otherwise you not able to Mark Attendance',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: black,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      actionButton(context, darkblue, "Mark Attendance",
                          () async {
                        bool isConnected =
                            await networkcontroller.checkInternetConnectivity();
                        if (!isConnected) {
                          // ignore: use_build_context_synchronously
                          networkcontroller.showNetworkErrorMessage(context);
                          // ignore: use_build_context_synchronously
                        } else {
                          // controller.update();
                          if (loginController.isPhoto.value == true) {
                            if (controller.image != null) {
                              // ignore: use_build_context_synchronously
                              controller.showLoadingfun(context);
                              // ignore: use_build_context_synchronously
                              await controller.markAttendanceAPI(context);

                              controller.showLoadingback();
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: redColor,
                                  content: Text('Please take a Selfi'),
                                ),
                              );
                            }
                          } else {
                            // ignore: use_build_context_synchronously
                            controller.showLoadingfun(context);
                            // ignore: use_build_context_synchronously
                            await controller.markAttendanceAPI(context);
                            Get.back();
                          }
                          // ignore: use_build_context_synchronously
                          // await controller.markAttendanceAPI(context);
                          controller.checkmarkAttendanceAPI();
                          controller.getcheckStatus();

                          controller.isloading = false;
                          controller.update();
                        }
                      }, false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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

  final imagepicker = ImagePicker();

  Future<void> imagePickermethod(int check) async {
    final pick = await imagepicker.pickImage(source: ImageSource.camera);

    if (pick != null) {
      File? croppedFile;

      if (check == 1) {
        final cropped = await ImageCropper().cropImage(
            sourcePath: pick.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: white,
                toolbarWidgetColor: black,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false,
              ),
              IOSUiSettings(
                title: 'Cropper',
              ),
            ],
            compressQuality: 30,
            maxWidth: 500, // Set the maximum width of the cropped image
            maxHeight: 500);

        if (cropped != null) {
          croppedFile = File(cropped.path);
        }
      }

      if (mounted) {
        setState(() {
          controller.image =
              croppedFile ?? croppedFile; // Set the cropped image
          clearPic = true;
        });
        // imageToBytes(image);

        // print("imagebytes${image}");
      }
    } else {}
  }

  // imageToBytes(image) async {
  //   if (image != Null) {
  //     var imageBytes = await image.readAsBytes();
  //     print("Image Bytes Length:${imageBytes}");
  //     image = imageBytes;
  //     print("mycontroller${image}");
  //     return image;
  //   }
  // }
}

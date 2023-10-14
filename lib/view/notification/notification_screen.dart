import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:geoofficeclock/view/SlideMenuScreen/Widget/SideMenuscreenWidget.dart';
import '../../constant/app_colors.dart';
import 'Widget/custom_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          drawerIconColor: blue,
          isTitleCenter: true,
          appBarPadding: const EdgeInsets.only(top: 30, left: 5),
          appBarHeight: MediaQuery.of(context).size.height * 0.09,
          appBarColor: Colors.white,
          title: Text(
            "Notification",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: blue, fontWeight: FontWeight.bold),
          ),
        ),
        slider: SideMenuBar(sliderDrawerKey: sliderDrawerKey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Today",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: black, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: notificationscreen(
                    context, "Leave Request", "Decline", "2 mins")),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: notificationscreen(
                    context, "Leave Application", "Accepts", "23 May 2023")),
            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Yesterday",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: black, fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: notificationattendan(context)),
          ],
        ),
      ),
    );
  }
}

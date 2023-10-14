import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/common _image.dart';
import '../../Login/components/login_screen.dart';
import '../Widget/onboarding_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen(
      {Key? key, required void Function() onBoardingCompleted})
      : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 12),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: const [
            CustomScreen(
              imagePath: splashimage1,
              backgroundColor: theme,
              decoration: white,
              text1: "Welcome",
              text2: "Get started!",
              text3:
                  "The Geo Office Clock is exclusively designed to facilitate Employees to mark attendance on the allowed radius. The App also provides multiple functionalities to perform day to day activities as required by HR department.",
              textcolor: black,
              value: false,
            ),
            CustomScreen(
              imagePath: splashimage2,
              backgroundColor: theme,
              decoration: white,
              text1: "Provide",
              text2: "Many Features",
              text3:
                  "The Geo Office Clock efficiently cater all the requirements of HMRS.",
              textcolor: black,
              value: true,
            ),
            CustomScreen(
              imagePath: splashimage3,
              backgroundColor: darkblue,
              decoration: darkblue,
              text1: "Finish",
              text2: "Explore Now!",
              text3:
                  "The App is most suitable to monitor attendance of employees with higher mobility. Multiple attendance locations can be assigned to any employee as per requirements of line managers.",
              textcolor: white,
              value: false,
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => const LoginScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                key: UniqueKey(),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: theme,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                width: MediaQuery.of(context).size.width * 3.271,
                height: MediaQuery.of(context).size.height * 0.065,
                child: Text(
                  "Start Now",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: white,
                      ),
                ),
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width * 3.375,
              height: MediaQuery.of(context).size.height * 0.078,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: Text(
                      "Skip",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            color: black,
                          ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: SlideEffect(
                      spacing: 10,
                      activeDotColor: theme,
                      dotHeight: 10.h,
                      dotColor: lightblue,
                      dotWidth: 10.w,
                    ),
                    onDotClicked: (index) {
                      controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      "Next",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            color: black,
                          ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

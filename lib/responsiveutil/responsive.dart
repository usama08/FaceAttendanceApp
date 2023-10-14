import 'package:flutter/widgets.dart';

class ResponsiveUtils {
  static double getWidth(BuildContext context, double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  static double getHeight(BuildContext context, double factor) {
    return MediaQuery.of(context).size.height * factor;
  }
}

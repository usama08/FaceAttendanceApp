import 'package:provider/provider.dart';
import 'apis_services/controller_date.dart';

import 'apis_services/report_fivedays.dart';

var multiProvider = [
  ChangeNotifierProvider<DatePicker>(
    create: (_) => DatePicker(),
    lazy: true,
  ),
  ChangeNotifierProvider<ReportFivedays>(
    create: (_) => ReportFivedays(),
    lazy: true,
  ),
  // ChangeNotifierProvider<Markattendance>(
  //   create: (_) => Markattendance(),
  //   lazy: true,
  // ),
];

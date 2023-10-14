import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geoofficeclock/Loading/animation_loading.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../models/reportfivedays.dart';
import '../../../provider_service/apis_services/report_fivedays.dart';

class MyTabbedContainer extends StatefulWidget {
  const MyTabbedContainer({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyTabbedContainerState createState() => _MyTabbedContainerState();
}

class _MyTabbedContainerState extends State<MyTabbedContainer> {
  final double fontSize = 12.0; // Specify your desired font size here

  @override
  Widget build(BuildContext context) {
    final reportcontroller = Provider.of<ReportFivedays>(context, listen: true);
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            FutureBuilder<List<ReportfiveDays>>(
                future: reportcontroller.fetchfivedayreport(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const AnimationLoader(); // Display loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data available.');
                  } else {
                    return Table(
                      defaultColumnWidth: const FixedColumnWidth(120.0),
                      border: TableBorder.all(
                        color: borderside,
                        width: 0.5.w,
                      ),
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            color: bluelight,
                          ),
                          children: [
                            _buildTableRowHeaderContainer(_buildText('Date')),
                            _buildTableRowHeaderContainer(_buildText('Status')),
                            _buildTableRowHeaderContainer(
                                _buildText('Duty Time')),
                            _buildTableRowHeaderContainer(
                                _buildText('Check In')),
                            _buildTableRowHeaderContainer(
                                _buildText('Check Out')),
                            _buildTableRowHeaderContainer(
                                _buildText('Late Min.')),
                            _buildTableRowHeaderContainer(
                                _buildText('Over Time')),
                            _buildTableRowHeaderContainer(
                                _buildText('Work Era')),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[0].checkInDate ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[0].checkInDate
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[0].status
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[0].dutyTime ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[0].dutyTime
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[0].checkInTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[0].checkOutTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[0].lateMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[0].overtimeMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[0].workingMinutes
                                .toString())),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[1].checkInDate ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[1].checkInDate
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[1].status
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[1].dutyTime ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[1].dutyTime
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[1].checkInTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[1].checkOutTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[1].lateMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[1].overtimeMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[1].workingMinutes
                                .toString())),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[2].checkInDate ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[2].checkInDate
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[2].status
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[2].dutyTime ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[2].dutyTime
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[2].checkInTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[2].checkOutTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[2].lateMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[2].overtimeMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[2].workingMinutes
                                .toString())),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[3].checkInDate ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[3].checkInDate
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[3].status
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[3].dutyTime ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[3].dutyTime
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[3].checkInTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[3].checkOutTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[3].lateMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[3].overtimeMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[3].workingMinutes
                                .toString())),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[4].checkInDate ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[4].checkInDate
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[4].status
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                        .reportDataList[4].dutyTime ==
                                    null
                                ? "N/A"
                                : reportcontroller.reportDataList[4].dutyTime
                                    .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[4].checkInTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[4].checkOutTime
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[4].lateMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[4].overtimeMinutes
                                .toString())),
                            _buildTableRowContainer(_buildText(reportcontroller
                                .reportDataList[4].workingMinutes
                                .toString())),
                          ],
                        ),
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    final Color? color = text == 'Present'
        ? presentColor
        : (text == 'Absent' ? absentColor : null);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: color ?? black,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTableRowContainer(Widget child) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: child,
      ),
    );
  }

  Widget _buildTableRowHeaderContainer(Widget child) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: child,
      ),
    );
  }

  // Define your color constants here
  final Color absentColor = const Color.fromARGB(255, 247, 126, 117);
  final Color presentColor = const Color.fromARGB(255, 93, 197, 97);
}

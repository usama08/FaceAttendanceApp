import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geoofficeclock/Loading/animation_loading.dart';
import 'package:geoofficeclock/provider_service/apis_services/controller_date.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/common _image.dart';

class MyAttendanceTable extends StatefulWidget {
  const MyAttendanceTable({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAttendanceTableState createState() => _MyAttendanceTableState();
}

class _MyAttendanceTableState extends State<MyAttendanceTable> {
  final double fontSize = 12.0;
  bool demo = true;
  // Specify your desired font size here
  @override
  void initState() {
    super.initState();
    Provider.of<DatePicker>(context, listen: false).fetchreport();
  }

  @override
  Widget build(BuildContext context) {
    final controllerProvidertext =
        Provider.of<DatePicker>(context, listen: true);
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: gryblur,
                      blurRadius: 50.0,
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        -1.0,
                        -5.0,
                      ))
                ],
              ),
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(70.0),
                border: TableBorder.all(
                  color: bordeerlight,
                  width: 0.5.w,
                ),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: white,
                    ),
                    children: [
                      _buildTableRowHeaderContainer(_buildText('Leave')),
                      _buildTableRowHeaderContainer(_buildText('CL')),
                      _buildTableRowHeaderContainer(_buildText('ML')),
                      _buildTableRowHeaderContainer(_buildText('SL')),
                      _buildTableRowHeaderContainer(_buildText('EL')),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableRowContainer(Stack(children: [
                        Positioned(
                            bottom: -34,
                            left: -20,
                            child: Image.asset((maskgroup))),
                      ])),
                      _buildTableRowContainer(_buildTextleaves(
                          controllerProvidertext.cl.toString() == 'null'
                              ? "0"
                              : controllerProvidertext.cl.toString())),
                      _buildTableRowContainer(_buildTextleaves(
                          controllerProvidertext.ml.toString() == 'null'
                              ? "0"
                              : controllerProvidertext.ml.toString())),
                      _buildTableRowContainer(_buildTextleaves(
                          controllerProvidertext.sl.toString() == 'null'
                              ? "0"
                              : controllerProvidertext.sl.toString())),
                      _buildTableRowContainer(_buildTextleaves(
                          controllerProvidertext.sl.toString() == 'null'
                              ? "0"
                              : controllerProvidertext.el.toString())),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: mpscreenfont,
            ),
      ),
    );
  }

  Widget _buildTextleaves(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: black,
            ),
      ),
    );
  }

  Widget _buildTableRowContainer(Widget child) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        width: 339.w,
        height: 72.h,
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: child,
      ),
    );
  }

  Widget _buildTableRowHeaderContainer(Widget child) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        width: 339.w,
        // height: 52.h,
        padding: const EdgeInsets.all(2.0),
        child: child,
      ),
    );
  }
}

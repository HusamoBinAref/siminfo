import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:siminfo/Model/recorder_model.dart';
import 'package:siminfo/Services/recorder_service.dart';
import 'package:siminfo/Services/routerMapGoogle.dart';

import '../style.dart';

class MyRecorderView extends StatefulWidget {
  @override
  _MyRecorderViewState createState() => _MyRecorderViewState();
}

RecorderService _recorderService = RecorderService();

class _MyRecorderViewState extends State<MyRecorderView> {
  List<RecorderResponseModel>? data = [];
  int currentIndex = -1;
  getData() async {
    var data1 = await _recorderService.getRecorder();
    setState(() {
      data = data1;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('تسجيلاتي'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 700),
                  childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            horizontalMargin: 0,
                            columnSpacing: defaultPadding,
                            headingRowColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              //if (states.contains(MaterialState.hovered))
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.08);
                              //return null;  // Use the default value.
                            }),
                            columns: [
                              DataColumn(
                                label: Text("ID "),
                              ),
                              DataColumn(
                                label: Text("رقم اللوحة"),
                              ),
                              DataColumn(
                                label: Text("الملاحظة"),
                              ),
                              DataColumn(
                                label: Text("latitude"),
                              ),
                              DataColumn(
                                label: Text("longitude"),
                              ),
                            ],
                            rows: data!.length != 0
                                ? List.generate(
                                    data!.length,
                                    (index) => dataRow(data![index]),
                                  )
                                : List.generate(
                                    1,
                                    (index) => dataRowNull(),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

DataRow dataRow(RecorderResponseModel model) {
  return DataRow(
    cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(model.id.toString()),
        ),
      ),
      DataCell(Text(model.plateNumber.toString())),
      DataCell(Text(model.note.toString())),
      DataCell(InkWell(
          onTap: () {
            MapUtils.openMapRouter(model.lat!, model.log!);
          },
          child: Text(model.lat.toString()))),
      DataCell(InkWell(
          onTap: () {
            MapUtils.openMapRouter(model.lat!, model.log!);
          },
          child: Text(model.log.toString()))),
    ],
  );
}

DataRow dataRowNull() {
  return DataRow(
    cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(""),
        ),
      ),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text('')),
    ],
  );
}

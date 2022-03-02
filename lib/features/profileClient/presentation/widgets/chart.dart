import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Chart extends StatelessWidget {
  final List<num> data;
  const Chart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SfSparkLineChart(
      //Enable the trackball
      trackball: const SparkChartTrackball(
          activationMode: SparkChartActivationMode.tap),
      //Enable marker
      marker:
          const SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.all,
      data: data,
    ),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: SfSparkLineChart(
      //Enable the trackball
      trackball: const SparkChartTrackball(
          activationMode: SparkChartActivationMode.tap),
      //Enable marker
      marker:
          const SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.all,
      data: const <double>[
        1,
        5,
        -6,
        0,
        1,
        -2,
        7,
        -7,
        -4,
        -10,
        13,
        -6,
        7,
        5,
        11,
        5,
        3
      ],
    )));
  }
}

import 'package:aquameter/core/utils/size_config.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class DateTimeComboLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool? animate;

  const DateTimeComboLinePointChart(this.seriesList, {Key? key, this.animate})
      : super(key: key);

  factory DateTimeComboLinePointChart.withSampleData() {
    return DateTimeComboLinePointChart(
      _createSampleData(),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: SizeConfig.screenHeight * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: charts.TimeSeriesChart(
          seriesList as List<Series<dynamic, DateTime>>,
          animate: animate,
          defaultRenderer: charts.LineRendererConfig(),
          customSeriesRenderers: [
            charts.PointRendererConfig(customRendererId: 'customPoint')
          ],
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {


    final tableSalesData = [
      TimeSeriesSales(DateTime(2017, 9, 19), 10),
      TimeSeriesSales(DateTime(2017, 9, 26), 50),
      TimeSeriesSales(DateTime(2017, 10, 3), 200),
      TimeSeriesSales(DateTime(2017, 10, 10), 150),
    ];

    final mobileSalesData = [
      TimeSeriesSales(DateTime(2017, 9, 19), 10),
      TimeSeriesSales(DateTime(2017, 9, 26), 50),
      TimeSeriesSales(DateTime(2017, 10, 3), 200),
      TimeSeriesSales(DateTime(2017, 10, 10), 150),
    ];

    return [
  
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      charts.Series<TimeSeriesSales, DateTime>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: mobileSalesData)
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

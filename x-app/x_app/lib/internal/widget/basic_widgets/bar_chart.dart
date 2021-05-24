import 'package:x_app/internal/model/basic_models/chart_data_model.dart';
import 'package:x_app/internal/model/basic_models/chart_series_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:serenat_chart/serenat_chart.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({@required this.series, Key key}) : super(key: key);
  List<ChartSeriesModel> series;

  List<Color> colors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.amber,
    Colors.yellowAccent,
    Colors.purpleAccent
  ];

  @override
  ComponentState createState() => ComponentState();
}

class ComponentState extends State<BarChartWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<ColumnSeries<ChartDataModel, String>> getSeries(
      List<ChartSeriesModel> series) {
    List<ColumnSeries<ChartDataModel, String>> listObj =
        new List<ColumnSeries<ChartDataModel, String>>();

    int i = 0;
    if (widget.series == null) {
      return listObj;
    }
    for (ChartSeriesModel chartSeriesModel in series) {
      listObj.add(createSeries(
          chartSeriesModel.datas, chartSeriesModel.title, widget.colors[i]));
      i += 1;
    }
    return listObj;
  }

  createSeries(List<ChartDataModel> datas, String title, Color color) {
    return ColumnSeries<ChartDataModel, String>(
        // Bind data source
        dataSource: datas,
        dataLabelMapper: (ChartDataModel data, _) => data.label,
        color: color,
        name: title,
        dataLabelSettings: DataLabelSettings(
          isVisible: false,
        ),
        yValueMapper: (ChartDataModel sales, _) => sales.value,
        xValueMapper: (ChartDataModel sales, _) => sales.label);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: getSeries(widget.series),
          tooltipBehavior: TooltipBehavior(
            activationMode: ActivationMode.singleTap,
            enable: false,
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

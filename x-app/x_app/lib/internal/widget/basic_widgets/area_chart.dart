import 'package:x_app/internal/model/basic_models/chart_data_model.dart';
import 'package:x_app/internal/model/basic_models/chart_series_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:serenat_chart/serenat_chart.dart';

class AreaChartWidget extends StatefulWidget {
  AreaChartWidget({@required this.series, Key key}) : super(key: key);
  List<ChartSeriesModel> series;

  List<Color> colors = [Colors.orangeAccent];

  @override
  ComponentState createState() => ComponentState();
}

class ComponentState extends State<AreaChartWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<AreaSeries<ChartDataModel, double>> getSeries(
      List<ChartSeriesModel> series) {
    List<AreaSeries<ChartDataModel, double>> listObj =
        new List<AreaSeries<ChartDataModel, double>>();

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
    return AreaSeries<ChartDataModel, double>(
      // Bind data source
      dataSource: datas,
      xValueMapper: (ChartDataModel data, _) => double.parse(data.label),
      yValueMapper: (ChartDataModel data, _) => data.value,
      borderColor: color.withOpacity(0.5),
      borderWidth: 2,
      markerSettings: MarkerSettings(
          isVisible: true,
          // Marker shape is set to diamond
          color: color.withOpacity(1),
          shape: DataMarkerType.circle),
      color: color.withOpacity(0.3),
    );
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
          tooltipBehavior: TooltipBehavior(
            activationMode: ActivationMode.singleTap,
            enable: true,
          ),
          series: getSeries(widget.series),
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

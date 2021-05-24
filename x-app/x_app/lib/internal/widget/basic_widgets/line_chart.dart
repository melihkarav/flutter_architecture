import 'package:x_app/internal/model/basic_models/chart_data_model.dart';
import 'package:x_app/internal/model/basic_models/chart_series_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:serenat_chart/serenat_chart.dart';

class LineChartWidget extends StatefulWidget {
  LineChartWidget({@required this.series, Key key}) : super(key: key);
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

class ComponentState extends State<LineChartWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<LineSeries<ChartDataModel, String>> getSeries(
      List<ChartSeriesModel> series) {
    List<LineSeries<ChartDataModel, String>> listObj =
        new List<LineSeries<ChartDataModel, String>>();

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
    return LineSeries<ChartDataModel, String>(
        // Bind data source
        dataSource: datas,
        xValueMapper: (ChartDataModel data, _) => data.label,
        enableTooltip: true,
        isVisibleInLegend: true,
        width: 4,
        name: title,
        markerSettings: MarkerSettings(
            isVisible: true,
            // Marker shape is set to diamond
            shape: DataMarkerType.diamond),
        color: color,
        opacity: 1,
        yValueMapper: (ChartDataModel data, _) => data.value);
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

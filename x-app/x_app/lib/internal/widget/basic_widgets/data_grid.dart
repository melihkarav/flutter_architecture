import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:x_app/internal/model/basic_models/chart_data_model.dart';
import 'package:x_app/internal/model/basic_models/chart_series_model.dart';

class DataGrid extends StatefulWidget {
  DataGrid({Key key, this.series}) : super(key: key);
  List<ChartSeriesModel> series;

  @override
  ComponentState createState() => ComponentState();
}

class ComponentState extends State<DataGrid>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DataRow> getSeries(List<ChartSeriesModel> series) {
    List<DataRow> listObj = new List<DataRow>();

    int i = 0;
    if (widget.series == null) {
      return listObj;
    }
    for (ChartSeriesModel chartSeriesModel in series) {
      for (ChartDataModel item in chartSeriesModel.datas) {
        listObj.add(DataRow(cells: <DataCell>[
          DataCell(Text(chartSeriesModel.title)),
          DataCell(Text(item.label)),
          DataCell(Text(item.value.toString()))
        ]));
      }
    }
    return listObj;
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Santral',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Saat',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Değer',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: getSeries(widget.series),
    );
  }
}

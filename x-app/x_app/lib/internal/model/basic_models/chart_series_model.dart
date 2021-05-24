import 'package:x_app/internal/model/basic_models/chart_data_model.dart';
import 'package:flutter/cupertino.dart';

class ChartSeriesModel {
  ChartSeriesModel({@required this.title, @required this.datas});
  String title;
  List<ChartDataModel> datas;
}

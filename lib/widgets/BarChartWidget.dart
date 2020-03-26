import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';


class BarChartWidget extends StatelessWidget{
  List listData;

  BarChartWidget(List list){this.listData = list;}

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(listData,animate: true);
  }



}
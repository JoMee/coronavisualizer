import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';


class BarChartWidget extends StatelessWidget{
  List listData;
  String country;
  BarChartWidget(List list,String country){
    this.country = country;
    this.listData = list;
  }

  @override
  Widget build(BuildContext context) {



    int index = 1;
    for(int i = 1; i<listData.length; i++){
      if(listData[i][1] == country){
        index = i;
        break;
      }
    }


    List<BarData> dataInPlot = new List(listData[index].length-4);

    for(int i = 4; i<dataInPlot.length+4; i++){
      dataInPlot[i-4] = new BarData(int.parse(listData[index][i]), listData[0][i]);
    }
    var series = [
      new charts.Series(
        id: 'confirmed',
        data: dataInPlot,
        domainFn: (BarData bard, _)=>bard.date,
        measureFn: (BarData bard, _)=>bard.num,
      )
    ];
    var chart = new charts.BarChart(
      series,
      animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
        showAxisLine: true,
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
    return chart;
  }
}
class BarData{
  int num;
  String date;
  BarData(this.num,this.date);
}
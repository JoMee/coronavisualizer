import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'util/read_csv.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}
final filename = 'assets/data/time_series_19-covid-Confirmed_archived_0325.csv';
read_Csv reader = new read_Csv(filename);

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Welcome to Flutter',
      home: AppScreen(),
    );
  }
}
class AppScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new AppScreenState();
}
class AppScreenState extends State<AppScreen>{
  Future<String> data;
  Future<List<List>> listData;

  @override
  void initState() {
    super.initState();
    data = reader.getData();
    //listData = reader.getDataAsLists();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: data,
          builder: (BuildContext context, snapshot){

            List<List> listData = new List<List>(snapshot.data.split("\n").length);

            for(int i = 0; i<listData.length; i++){
              String currString = snapshot.data.split("\n")[i];
              List l = new List(currString.split(",").length);
              for(int j = 0; j<currString.split(",").length; j++){

                if(currString.split(",").length == 62){
                  if(j == 0){
                    l[j] = currString.split(",")[j] + currString.split(",")[j+1];
                  }else{

                    l[j] = snapshot.data.split("\n")[i].split(",")[j+1];
                  }
                }else{
                  l[j] = currString.split(",")[j];
                }
              }
              listData[i] = l;
            }
            String country = "Italy";
            int index = 5;

            List<BarData> dataInPlot = new List(listData[index].length-4);

            for(int i = 4; i<dataInPlot.length+4; i++){
              dataInPlot[i-4] = new BarData(int.parse(listData[index][i]), listData[0][i]);
            }

            print(dataInPlot);
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
            );
            
            if(snapshot.hasData) {
              return chart;
            }else return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
class BarData{
  int num;
  String date;
  BarData(this.num,this.date);
}


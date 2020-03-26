import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutterapp/widgets/BarChartWidget.dart';
import 'util/read_csv.dart';

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
    listData = reader.getDataAsLists();
    //listData = reader.getDataAsLists();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
      ),
      body: Center(
        child: FutureBuilder<List<List>>(
          future: listData,
          builder: (BuildContext context, snapshot){
            if(snapshot.hasData) {
              return new BarChartWidget(snapshot.data);
            }else return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}



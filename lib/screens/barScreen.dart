
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/util/read_csv.dart';
import 'package:flutterapp/widgets/BarChartWidget.dart';

final filename = 'assets/data/time_series_19-covid-Confirmed_archived_0325.csv';
read_Csv reader = new read_Csv(filename);

class AppScreen extends StatefulWidget{
  final String country;
  const AppScreen(this.country);

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
        title: Text('Corona History in '+ widget.country),
      ),
      body: Center(
        child: FutureBuilder<List<List>>(
          future: listData,
          builder: (BuildContext context, snapshot){
            if(snapshot.hasData) {
              return new BarChartWidget(snapshot.data, widget.country);
            }else return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: IconButton(
            icon: Icon(Icons.blur_circular),
            onPressed: () => Navigator.pop(context),
          )),
    );
  }
}
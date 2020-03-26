import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


import 'package:flutter/services.dart';

class read_Csv {
  String fileName;

  read_Csv(String location){
    fileName = location;
  }
  Future<String> getData() async{
    //final filename = 'assets/data/time_series_19-covid-Confirmed_archived_0325.csv';
    var bytes = await rootBundle.loadString(fileName);
    return bytes;
  }

  Future<List<List>> getDataAsLists() async{
    var bytes = await rootBundle.loadString(fileName);

    List<List> listData;
    for(int i = 1; i<bytes.split("\n").length; i++){
      List l;
      print(bytes.split("\n")[i].split(",").length);
      for(int j = 4; j<bytes.split("\n")[i].split(",").length; j++){
        l.add(bytes.split("\n")[i].split(",")[j]);

      }
    }

    return listData;
  }
}
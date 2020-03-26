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

    List<List> listData = new List<List>(bytes.split("\n").length);

    for(int i = 0; i<listData.length; i++){
      String currString = bytes.split("\n")[i];
      List l = new List(currString.split(",").length);
      for(int j = 0; j<currString.split(",").length; j++){

        if(currString.split(",").length == 62){
          if(j == 0){
            l[j] = currString.split(",")[j] + currString.split(",")[j+1];
          }else{

            l[j] = bytes.split("\n")[i].split(",")[j+1];
          }
        }else{
          l[j] = currString.split(",")[j];
        }
      }
      listData[i] = l;
    }

    return listData;
  }
}
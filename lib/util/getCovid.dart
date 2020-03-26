import 'package:flutterapp/models/covid_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<Stream<Covid>> getCovid(String country) async {
  final String url = 'https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats?country='+country
  ;
  final http.Request request = new http.Request('get', Uri.parse(url));
  request.headers.addAll({"x-rapidapi-host":"covid-19-coronavirus-statistics.p.rapidapi.com",
    "x-rapidapi-key":"a22f60882emsheeeb65be7c12c84p1cbc4bjsn8558def3036a"});
  final client = new http.Client();
  final streamedRest = await client.send(request);
  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((jsonBody) => (jsonBody as Map)['data']['covid19Stats'])
      .map((data) => Covid.fromJSON(data));
}
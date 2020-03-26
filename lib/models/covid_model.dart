import 'dart:convert';

class Covid {
  final city;
  final province;
  final country;
  final lastUpdate;
  final confirmed;
  final deaths;
  final recovered;

  Covid.fromJSON(Map<String, dynamic> jsonMap):
      city = jsonMap['city'],
      province = jsonMap['province'],
      country = jsonMap['country'],
      lastUpdate = jsonMap['lastUpdate'],
      confirmed = jsonMap['confirmed'],
      deaths = jsonMap['deaths'],
      recovered = jsonMap['recovered'];

  static String stringBuilder(Covid covid){
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write("Cases: ");
    stringBuffer.write(covid.confirmed.toString());
    stringBuffer.write("\n");
    stringBuffer.write("Deaths: ");
    stringBuffer.write(covid.deaths.toString());
    stringBuffer.write("\n");
    stringBuffer.write("Recovered: ");
    stringBuffer.write(covid.recovered.toString());
    stringBuffer.write("\n");
    return stringBuffer.toString();
  }
}
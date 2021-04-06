import 'dart:convert';
import 'package:flutter_dashboard_app/models/line.dart';
import 'package:http/http.dart' as http;

class LineData {
  Future<http.Response> fetchData(String url) {
    return http.get(url);
  }

  Future<LineModel> fetchLineData() async {
    String url = "http://10.0.2.2:5000/api/country/valuesbydate";
    final response = await fetchData(url);

    if (response.statusCode == 200) {

      return LineModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }


  Future<LineModel> fetchLineDataByCountry(String countryName) async {
    String url = "http://10.0.2.2:5000/api/country/valuesbycountry?countryName="+countryName;
    final response = await fetchData(url);

    if (response.statusCode == 200) {
      return LineModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}

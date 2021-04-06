import 'dart:convert';

import 'package:flutter_dashboard_app/models/percantage.dart';
import 'package:http/http.dart' as http;
class PercantageData {


  Future<http.Response> fetchData(String url){
    return http.get(url);
  }

  Future<Percantage> fetchPercantages() async {

    String url = "http://10.0.2.2:5000/api/country/percantage";
    final response =await fetchData(url);

    if (response.statusCode == 200) {

      return Percantage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }


}
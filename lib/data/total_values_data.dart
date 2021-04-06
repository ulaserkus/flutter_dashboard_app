import 'dart:convert';
import 'package:flutter_dashboard_app/models/inserts.dart';
import 'package:flutter_dashboard_app/models/values.dart';
import 'package:http/http.dart' as http;

class TotalValuesData {


  Future<http.Response> fetchData(String url){
    return http.get(url);
  }

   Future<Values> fetchValues() async {

    String url = "http://10.0.2.2:5000/api/country/values";
    final response =await fetchData(url);

    if (response.statusCode == 200) {
      return Values.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

   Future<Inserts> fetchInserts() async {

    String url = "http://10.0.2.2:5000/api/country/changedvalues";
    final response = await fetchData(url);

    if (response.statusCode == 200) {
      return Inserts.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

}

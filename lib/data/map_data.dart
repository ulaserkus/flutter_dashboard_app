import 'dart:convert';

import 'package:flutter_dashboard_app/models/map.dart';
import 'package:http/http.dart' as http;

class MapData {
  Future<http.Response> fetchData(String url) {
    return http.get(url);
  }

  Future<List<MapModel>> fetchMapModel() async {
    String url = "http://10.0.2.2:5000/api/city";
    final response = await fetchData(url);
    List<MapModel> _postList = [];

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = jsonDecode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            _postList.add(MapModel.fromJson(map));
          }
        }
      }
      return _postList;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

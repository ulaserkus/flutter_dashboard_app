import 'dart:convert';
import 'package:flutter_dashboard_app/models/detail.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class DetailData {

  Future<List<DetailModel>> fetchDetailData(String countryName) async {
    String url =
        "http://10.0.2.2:5000/api/country/detail?countryName=" + countryName;
    final response = await http.get(url);
    List<DetailModel> list = [];

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            list.add(DetailModel.fromJson(map));
          }
        }
      }
      return list;
    } else {
      throw Exception('Failed to load album');
    }
  }

  static  postDetailData(double patient, double death,double cure,String addedTime,int countryId)async {
    final Dio _dio = new Dio();
    _dio.options.contentType = Headers.acceptHeader;
    _dio.options.contentType = Headers.jsonContentType;

    var data = {"patient": patient, "death": death,"cure":cure,"addedTime":addedTime,"countryId":countryId};

    Response responseData = await _dio.post<Map<String, dynamic>>('/api/country/addDetail',
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            baseUrl: 'https://10.0.2.2:5001'),
        data: data);

    return responseData;
  }


}

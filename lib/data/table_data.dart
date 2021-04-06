import 'dart:convert';
import 'package:flutter_dashboard_app/models/table.dart';
import 'package:http/http.dart' as http;

class TableData {


  Future<http.Response> fetchTableData(String url) {
    return http.get(url);
  }

  Future<List<TableModel>> fetchTable() async {
    String url = "http://10.0.2.2:5000/api/country";
    final response = await fetchTableData(url);
    List<TableModel> _postList =[];
    if (response.statusCode == 200) {

      List<dynamic> values=[];
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            _postList.add(TableModel.fromJson(map));
          }
        }
      }

      return _postList;
    } else {
      throw Exception('Failed to load album');
    }
  }

}

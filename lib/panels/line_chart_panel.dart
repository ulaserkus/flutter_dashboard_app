import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/data/line_data.dart';
import 'package:flutter_dashboard_app/data/table_data.dart';
import 'package:flutter_dashboard_app/models/line.dart';
import 'package:flutter_dashboard_app/models/table.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinePanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LinePanelState();
  }
}

class LinePanelState extends State<LinePanel> {
  String dropDownValue = "Tümü";
  List<TableModel> listOfCountry;
  List<String> items = ["Tümü"];

  Future<LineModel> model;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    getCountriesNames();
    getLineData();

    super.initState();
  }

  getCountriesNames() async {
    TableData data = TableData();
    listOfCountry = await data.fetchTable();
    listOfCountry.forEach((element) {
      items.add(element.countryName);
    });
    setState(() {
      loading = false;
    });
  }

  getLineData() async {
    LineData data = LineData();
    model =  data.fetchLineData();
    setState(() {
      loading = false;
    });
  }

  getLineDataByCountryName(String countryName) async {
    LineData data = LineData();
    model =  data.fetchLineDataByCountry(countryName);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    values()async {
      List<LineDataView> list = [];
      List<LineDataView> list2 = [];
      List<LineDataView> list3 = [];

      var lineObject = await model;

      for (int i = 0; i < lineObject.dates.length; i++) {
        if (lineObject.dates[i] != null) {
          var data = LineDataView(lineObject.dates[i],
              double.parse(lineObject.totalCuresByDate[i]));
          list.add(data);
        }
      }
      for (int i = 0; i < lineObject.dates.length; i++) {
        if (lineObject.dates[i] != null) {
          var data = LineDataView(lineObject.dates[i],
              double.parse(lineObject.totalPatientsByDate[i]));

          list2.add(data);
        }
      }
      for (int i = 0; i < lineObject.dates.length; i++) {
        if (lineObject.dates[i] != null) {
          var data = LineDataView(lineObject.dates[i],
              double.parse(lineObject.totalDeathsByDate[i]));

          list3.add(data);
        }
      }

      return [list, list2, list3];
    }


    return loading
        ? Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            alignment: Alignment.center,
            child: CircularProgressIndicator())
        : Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height - 160,
            margin: EdgeInsets.only(top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[800]),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: DropdownButton(
                      items: items.map((String e) {
                        return DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            ));
                      }).toList(),
                      value: dropDownValue,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownValue = newValue;
                          if (newValue == "Tümü") {
                            getLineData();
                          } else {
                            getLineDataByCountryName(newValue);
                          }
                        });
                      },
                    ),
                  ),
                ),
                Title(
                    color: Colors.black,
                    child: Text(
                      'Dünya Geneli Tarihsel Dağılımı',
                      style: TextStyle(fontSize: 18),
                    )),
                FutureBuilder(
                  future:values(),
                  builder: (context,snapShot){
                    if(snapShot.hasData){
                      return  SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                          ),
                          series: <ChartSeries>[
                            SplineSeries<LineDataView, String>(
                                name: 'Vaka',
                                color: Colors.redAccent,
                                dataSource: snapShot.data[1],
                                xValueMapper: (LineDataView data, _) => data?.year,
                                yValueMapper: (LineDataView data, _) =>
                                data?.totalValues),
                            SplineSeries<LineDataView, String>(
                                name: 'Ölüm',
                                color: Colors.grey,
                                dataSource: snapShot.data[2],
                                xValueMapper: (LineDataView data, _) => data?.year,
                                yValueMapper: (LineDataView data, _) =>
                                data?.totalValues),
                            SplineSeries<LineDataView, String>(
                                name: 'İyileşme',
                                color: Colors.greenAccent,
                                dataSource: snapShot.data[0],
                                xValueMapper: (LineDataView data, _) => data?.year,
                                yValueMapper: (LineDataView data, _) =>
                                data?.totalValues)
                          ]);

                    }
                    return Center(
                      child: Container(
                        width:MediaQuery.of(context).size.width,
                          child: Center(child: CircularProgressIndicator())),
                    );
                  },

                )
              ],
            ),
          );
  }
}

class LineDataView {
  LineDataView(this.year, this.totalValues);

  final String year;
  final double totalValues;
}

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/data/percantage_data.dart';
import 'package:flutter_dashboard_app/models/percantage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PiePanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PiePanelState();
  }
}

class PiePanelState extends State<PiePanel> {
  Future<Percantage> percantage;

  bool loading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async{
    PercantageData data = PercantageData();
    percantage = data.fetchPercantages();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    values() async {
      List<_PieData> list = [];
      var percantageObject = await percantage;
      double total = 0;

      for(int i = 0 ; i<percantageObject.percantageValues.length; i++){
        total += double.parse(percantageObject.percantageValues[i]);
        var data = _PieData(percantageObject.countryNames[i],double.parse(percantageObject.percantageValues[i]));
        list.add(data);
      }
      var value = 100 - total;
      var data = _PieData("Diğer",value);
      list.add(data);
      return list;
    }

    return loading
        ? Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            alignment: Alignment.center,
            child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.only(top: 5),
            color: Colors.white,
            height: MediaQuery.of(context).size.height - 160,
            child: Center(
                child: FutureBuilder(
                    future: values(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return SfCircularChart(
                            title: ChartTitle(
                                text: 'Dünya Geneli Enfeksiyon Dağılımı'),
                            legend: Legend(isVisible: true),
                            series: <PieSeries<_PieData, String>>[
                              PieSeries<_PieData, String>(
                                  explode: true,
                                  explodeIndex: 0,
                                  dataSource: snapShot.data,
                                  xValueMapper: (_PieData data, _) =>
                                      data.xData,
                                  yValueMapper: (_PieData data, _) =>
                                      data.yData,
                                  dataLabelMapper: (_PieData data, _) =>
                                      data.text,
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                            ]);
                      }

                      return CircularProgressIndicator();
                    })),
          );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);

  final String xData;
  final num yData;
  final String text;
}

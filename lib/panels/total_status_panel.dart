import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/data/map_data.dart';
import 'package:flutter_dashboard_app/data/total_values_data.dart';
import 'package:flutter_dashboard_app/models/inserts.dart';
import 'package:flutter_dashboard_app/models/map.dart';
import 'package:flutter_dashboard_app/models/values.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class TotalStatus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TotalStatusState();
  }
}

/// this is a stateless widget for only view
class TotalStatusState extends State<TotalStatus> {
  MapShapeSource _dataSource;
  bool loading = true;
  Future<Values> values;
  Future<Inserts> _inserts;
  Future<List<MapModel>> _mapValues;

  @override
  void initState() {
    getValues();

    super.initState();
  }

  getValues() {
    var data = TotalValuesData();
    var mapData = MapData();
    values = data.fetchValues();
    _inserts = data.fetchInserts();
    _mapValues = mapData.fetchMapModel();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    mapValues() async {
      List<Model> list = [];
      var mapObject = await _mapValues;
      mapObject.forEach((val) {
        var data = Model("",val.patient.toString().split('.')[0], val.latitude, val.longitude);
        list.add(data);
      });

      _dataSource = MapShapeSource.asset(
        'assets/world_map.json',
        shapeDataField: 'name',
        dataCount: list.length,
        primaryValueMapper: (index) => list[index].country,
      );

      return [list, _dataSource];
    }

    double width = MediaQuery.of(context).size.width;
    return loading
        ? Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            alignment: Alignment.center,
            child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2),
                  children: [
                    Container(
                      margin: EdgeInsets.all(3),
                      color: Colors.white,
                      height: 80,
                      width: width / 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Toplam Vaka Sayısı'),
                            FutureBuilder(
                              future: values,
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  return Text(
                                    "${snapShot.data.total.toString().split('.')[0]}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.redAccent),
                                  );
                                }
                                return Text(
                                  '12324',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.orangeAccent),
                                );
                              },
                            ),
                            Container(
                              height: 18,
                              width: 120,
                              color: Colors.redAccent,
                              child: FutureBuilder(
                                future: _inserts,
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return Text(
                                      '+${snapShot.data.total.toString().split('.')[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    );
                                  }
                                  return Text(
                                    '+10',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  );
                                },
                              ),
                            )
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      color: Colors.white,
                      height: 80,
                      width: width / 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Aktif Vakalar'),
                            FutureBuilder(
                              future: values,
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  return Text(
                                    '${snapShot.data.totalPatient.toString().split('.')[0]}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orangeAccent),
                                  );
                                }

                                return Text(
                                  '12324',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.orangeAccent),
                                );
                              },
                            ),
                            Container(
                              height: 18,
                              width: 120,
                              color: Colors.orangeAccent,
                              child: FutureBuilder(
                                future: _inserts,
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return Text(
                                      '+${snapShot.data.totalPatient.toString().split('.')[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    );
                                  }
                                  return Text(
                                    '+10',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  );
                                },
                              ),
                            )
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      color: Colors.white,
                      height: 80,
                      width: width / 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Ölüm Vakaları'),
                            FutureBuilder(
                              future: values,
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  return Text(
                                    '${snapShot.data.totalDeaths.toString().split('.')[0]}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  );
                                }
                                return Text(
                                  '12324',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                );
                              },
                            ),
                            Container(
                              height: 18,
                              width: 120,
                              color: Colors.grey,
                              child: FutureBuilder(
                                future: _inserts,
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return Text(
                                      '+${snapShot.data.totalDeaths.toString().split('.')[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    );
                                  }
                                  return Text(
                                    '+10',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  );
                                },
                              ),
                            )
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      color: Colors.white,
                      height: 80,
                      width: width / 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Tedavi Edilen Vakalar'),
                            FutureBuilder(
                              future: values,
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  return Text(
                                    '${snapShot.data.totalCure.toString().split('.')[0]}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.greenAccent),
                                  );
                                }
                                return Text(
                                  '12324',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.greenAccent),
                                );
                              },
                            ),
                            Container(
                              height: 18,
                              width: 120,
                              color: Colors.greenAccent,
                              child: FutureBuilder(
                                future: _inserts,
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return Text(
                                      '+${snapShot.data.totalCure.toString().split('.')[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    );
                                  }
                                  return Text(
                                    '+10',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  );
                                },
                              ),
                            )
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                height: MediaQuery.of(context).size.height - 360,
                child: FutureBuilder(
                    future: mapValues(),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return SfMaps(layers: <MapLayer>[
                          MapShapeLayer(
                            loadingBuilder: (BuildContext context) {
                              return Container(
                                height: 25,
                                width: 25,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            },
                            source: snap.data[1],
                            initialMarkersCount: snap.data[0].length,
                            markerBuilder: (BuildContext context, int index) {
                              return MapMarker(
                                latitude: snap.data[0][index].latitude,
                                longitude: snap.data[0][index].longitude,
                                iconType: MapIconType.circle,
                                size: Size(6, 6),
                                iconStrokeColor: Colors.redAccent,
                                iconStrokeWidth: 2,
                                iconColor: Colors.redAccent[200],
                              );
                            },
                            markerTooltipBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Stack(
                                      children: [
                                        Center(
                                          child: Text(
                                            snap.data[0][index].patient,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .fontSize),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.dangerous,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            tooltipSettings: const MapTooltipSettings(
                                color: Colors.red,
                                strokeColor: Colors.black,
                                strokeWidth: 1.5),
                          ),
                        ]);
                      }
                      return Container();
                    }),
              )
            ],
          );
  }
}

class Model {
  ///city modelclass Model {
  const Model(this.country,this.patient, this.latitude, this.longitude);

  final String country;
  final String patient;
  final double latitude;
  final double longitude;
}

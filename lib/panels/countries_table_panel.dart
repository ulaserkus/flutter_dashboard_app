import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dashboard_app/data/table_data.dart';
import 'package:flutter_dashboard_app/models/table.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CountriesTable extends StatefulWidget {
  @override
  CountriesTableState createState() => CountriesTableState();
}

class CountriesTableState extends State<CountriesTable> {
  TextEditingController searchTerm = TextEditingController();
  bool loading = true;
  List<TableModel> model;
  int count = 0;
  String searchText;
  String dropDownValue = "Sıralama";

  @override
  void initState() {
    // TODO: implement initState
    getTableValues();
    super.initState();
  }

  getTableValues() async {
    TableData data = TableData();
    model = await data.fetchTable();
    count = model.length;

    setState(() {
      loading = false;
    });
  }

  onItemChanged(String val) {
    setState(() {
      print(val);
      if (val != null) {
        model = model
            .where((element) =>
                element.countryName.toLowerCase().contains(val.toLowerCase()))
            .toList();
        count = model.length;
      }
      if (val == "") {
        getTableValues();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return loading
        ? Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            alignment: Alignment.center,
            child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.only(top: 5),
            height: MediaQuery.of(context).size.height - 160,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 240,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: TextField(
                            controller: searchTerm,
                            onChanged: onItemChanged,
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                hintText: "Ülke Ara",
                                fillColor: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 245,
                        height: 60,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: DropdownButton(
                            items: [
                              "Sıralama",
                              'Ülke',
                              'Vaka',
                              'Ölüm',
                              'İyileşme'
                            ].map((String e) {
                              return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ));
                            }).toList(),
                            value: dropDownValue,
                            underline: SizedBox(),
                            onChanged: (String newValues) {
                              setState(() {
                                dropDownValue = newValues;
                                switch (newValues) {
                                  case "Ülke":
                                    model.sort((a, b) {
                                      return a.countryName
                                          .toLowerCase()
                                          .compareTo(
                                              b.countryName.toLowerCase());
                                    });
                                    break;
                                  case "Vaka":
                                    model.sort((a, b) {
                                      return a.patient.compareTo(b.patient);
                                    });
                                    break;
                                  case "Ölüm":
                                    model.sort((a, b) {
                                      return a.death.compareTo(b.death);
                                    });
                                    break;

                                  case "İyileşme":
                                    model.sort((a, b) {
                                      return a.cure.compareTo(b.cure);
                                    });
                                    break;
                                }
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Table(
                      children: [
                        TableRow(children: [
                          Column(children: [
                            Text('Ülke',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                          ]),
                          Column(children: [
                            Text('Vaka',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600))
                          ]),
                          Column(children: [
                            Text('Ölüm',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600))
                          ]),
                          Column(children: [
                            Text('İyileşme',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                          ]),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height - 280,
                      margin: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (context, i) {
                            return Table(
                              border: TableBorder(
                                top:
                                    BorderSide(width: 0.5, color: Colors.black),
                                bottom:
                                    BorderSide(width: 0.5, color: Colors.black),
                              ),
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${model[i].countryName}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${model[i].patient.toString().split('.')[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.redAccent),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${model[i].death.toString().split('.')[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${model[i].cure.toString().split('.')[0]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.greenAccent),
                                    ),
                                  ),
                                ]),
                              ],
                            );
                          }))
                ],
              ),
            ),
          );
  }
}

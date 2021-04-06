import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/data/detail_data.dart';
import 'package:flutter_dashboard_app/models/detail.dart';
import 'package:flutter_dashboard_app/views/Home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: must_be_immutable
class AddPage extends StatefulWidget {
  String countryName;

  AddPage(this.countryName);

  @override
  _AddPageState createState() => _AddPageState(this.countryName);
}

class _AddPageState extends State<AddPage> {
  String countryName;
  int count = 0;
  int countryId;
  Future<List<DetailModel>> model;

  _AddPageState(this.countryName);

  final formKey = GlobalKey<FormState>();
  TextEditingController date = new TextEditingController();
  TextEditingController patient = new TextEditingController();
  TextEditingController death = new TextEditingController();
  TextEditingController cure = new TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    print(countryName);
    getDetails();
    super.initState();
  }

  getDetails() async {
    DetailData data = DetailData();
    model = data.fetchDetailData(countryName);
    count = await model.then((value) => value.length);
    await model.then((value) => value.forEach((element) {
          countryId = element.countryId;
        }));
    print(countryId);
  }

  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Kayıt Ekle',
          style: TextStyle(color: Colors.black87),
          textAlign: TextAlign.end,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () async {
                await storage.delete(key: "token");
                var key = await storage.read(key: "token");
                if (key == null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Çıkış Yapıldı')));

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                }
              },
              icon: Icon(
                Icons.logout,
                size: 32,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 5),
          color: Colors.white,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      onTap: () {
                        _selectDate(context);
                        date.text = ("${selectedDate.toLocal()}")
                            .split(' ')[0]
                            .toString();
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        currentFocus.unfocus();
                      },
                      controller: date,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Tarih Seçimi"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: patient,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Vaka Sayısı'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: death,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Ölüm Sayısı'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: cure,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'İyileşen Sayısı'),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () async {
                          Response res = await DetailData.postDetailData(
                              double.parse(patient.text),
                              double.parse(death.text),
                              double.parse(cure.text),
                              selectedDate.toString(),
                              countryId);
                          print(res.statusCode);
                          if (res.statusCode == 200 || res.statusCode == 201) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Kaydet'),
                        style: ElevatedButton.styleFrom(primary: Colors.grey)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Table(
                      children: [
                        TableRow(children: [
                          Column(children: [
                            Text('Tarih',
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
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height / 2 - 100,
                    child: FutureBuilder(
                        future: model,
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: count,
                                itemBuilder: (context, i) {
                                  return Table(
                                    border: TableBorder(
                                      top: BorderSide(
                                          width: 0.5, color: Colors.black),
                                      bottom: BorderSide(
                                          width: 0.5, color: Colors.black),
                                    ),
                                    children: [
                                      TableRow(children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                '${snapShot.data[i].addedTime.toString().split('T')[0]}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                '${snapShot.data[i].patient.toString().split('.')[0]}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                '${snapShot.data[i].death.toString().split('.')[0]}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                '${snapShot.data[i].cure.toString().split('.')[0]}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ],
                                  );
                                });
                          }
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/data/table_data.dart';
import 'package:flutter_dashboard_app/models/table.dart';
import 'package:flutter_dashboard_app/views/Adding.dart';

class AdminPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminPanelState();
  }
}

class AdminPanelState extends State<AdminPanel> {
  List<TableModel> model;
  int count = 0;
  bool loading = true;

  @override
  void initState() {
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

      if (val != null) {
        model = model
            .where((element) =>
            element.countryName.toLowerCase().contains(val.toLowerCase()))
            .toList();
        count=model.length;
      }if(val ==""){
        getTableValues();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 2 - 250,
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextField(
                          onChanged: onItemChanged,
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Ülke Ara",
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 2 + 95,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              height:
                                  MediaQuery.of(context).size.height / 2 + 50,
                              child: ListView.builder(
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
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${model[i].countryName}',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddPage(model[
                                                                          i]
                                                                      .countryName)));
                                                    },
                                                    child: Text("Seç"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.grey),
                                                  )
                                                ],
                                              )),
                                        ]),
                                      ],
                                    );
                                  })),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

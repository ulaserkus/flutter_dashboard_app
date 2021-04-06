import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/panels/countries_table_panel.dart';
import 'package:flutter_dashboard_app/panels/line_chart_panel.dart';
import 'package:flutter_dashboard_app/panels/pie_chart_panel.dart';
import 'package:flutter_dashboard_app/panels/total_status_panel.dart';
import 'package:flutter_dashboard_app/views/Login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          toolbarHeight: 65,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text(
            'Covid-19 App',
            style: TextStyle(color: Colors.black87, fontSize: 20),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                icon: Icon(
                  Icons.login,
                  size: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loadPages(),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            iconSize: 20,
            fixedColor: Colors.black,
            currentIndex: selectedIndex,
            onTap: changePage,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'Anasayfa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                title: Text(
                  'Yüzde',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.table_chart),
                title: Text(
                  'Tablo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.stacked_line_chart),
                title: Text(
                  'Grafik',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }

  loadPages() {
    if (selectedIndex == 0) {
      return TotalStatus();
    } else if (selectedIndex == 1) {
      return PiePanel();
    } else if (selectedIndex == 2) {
      return CountriesTable();
    } else if (selectedIndex == 3) {
      return LinePanel();
    }
  }

}

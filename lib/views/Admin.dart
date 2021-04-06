import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/panels/admin_panel.dart';
import 'package:flutter_dashboard_app/views/Home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            'Admin Panel',
            style: TextStyle(color: Colors.black87),
            textAlign: TextAlign.end,
          ),
          leading: Icon(Icons.account_box),
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
        body:AdminPanel(),
        bottomNavigationBar: SizedBox(
          height: 60,
          child:Container(
            color: Colors.white,
          ) ,
        ));
  }
}

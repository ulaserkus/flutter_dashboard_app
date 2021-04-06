import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_app/data/login_data.dart';
import 'package:flutter_dashboard_app/views/Admin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final storage = new FlutterSecureStorage();
    TextEditingController _username = new TextEditingController();
    TextEditingController _password = new TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Enter Your Account',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.end,
          ),
        ),
        body: Container(
            color: Colors.white,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Username'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                    ),
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          Response res = await LoginData.postDataWithDio(
                              _username.text, _password.text);

                          if (res.statusCode == 200 || res.statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Giriş Yapıldı')));

                            Map<String, dynamic> output =
                                json.decode(res.toString());

                            await storage.write(
                                key: "token", value: output['token']);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminPage()),
                                (route) => false);
                          }
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(primary: Colors.grey)),
                  ),
                ],
              ),
            )));
  }
}

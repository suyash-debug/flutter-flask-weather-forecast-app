import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/detailPage.dart';

import 'Model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Weather Forecast'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = '';

  Future<http.Response> getData(String cityName) async {
    return http
        .post(
          'http://10.0.2.2:5000/get',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              'city': cityName,
            },
          ),
        )
        .then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detailed(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            Container(
              child: SizedBox(
                height: 500,
                child: Align(
                  alignment: Alignment.center,
                  child: FlareActor(
                    'assets/Untitled.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: 'Untitled',
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 80, left: 25, right: 25),
                  child: TextField(
                    onSubmitted: (value) => getData(value),
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    style: TextStyle(color: Colors.green),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red, //this has no effect
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Enter Your City",
                        hintStyle: TextStyle(color: Colors.purple)),
                  ),
                ),
              ],
            ),
          ],
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

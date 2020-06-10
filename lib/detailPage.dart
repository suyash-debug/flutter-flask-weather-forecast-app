import 'dart:convert';

import 'package:flutter/material.dart';

import 'Model.dart';
import 'package:http/http.dart' as http;

class Detailed extends StatefulWidget {
  @override
  _DetailedState createState() => _DetailedState();
}

class _DetailedState extends State<Detailed> {
  Future<Weather> futureAlbum;
  Weather weather;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Future<Weather> fetchAlbum() async {
    final response = await http.get('http://10.0.2.2:5000/gets');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      weather = Weather.fromJson(json.decode(response.body));
      return Weather.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Weather details'),
        backgroundColor: Colors.transparent,
        elevation: 5,
      ),
      body: Center(
        child: FutureBuilder(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 370,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple,
                              blurRadius: 25.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                15.0, // Move to right 10  horizontally
                                15.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          color: Colors.green[500],
                          border: Border.all(
                            color: Colors.red[500],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  weather.region,
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  weather.weather_now,
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  weather.temp_now + '\u2103',
                                  style: TextStyle(
                                      fontSize: 45, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Column(children: [
                              Text(
                                'Humidity :' + weather.humidity,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                'Wind Speed :' + weather.wind,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                'Precipitation :' + weather.precipitation,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    daysCard(0),
                    SizedBox(
                      height: 25,
                    ),
                    daysCard(1),
                    SizedBox(
                      height: 25,
                    ),
                    daysCard(2),
                    SizedBox(
                      height: 25,
                    ),
                    daysCard(3),
                    SizedBox(
                      height: 25,
                    ),
                    daysCard(4),
                    SizedBox(
                      height: 25,
                    ),
                    daysCard(5),
                    SizedBox(
                      height: 20,
                    ),
                    daysCard(6),
                    SizedBox(
                      height: 20,
                    ),
                    daysCard(7),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget daysCard(i) {
    return Container(
      width: 370,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.green,
            blurRadius: 25.0, // soften the shadow
            spreadRadius: 2.0, //extend the shadow
            offset: Offset(
              7.0, // Move to right 10  horizontally
              7.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        color: Colors.purpleAccent[500],
        border: Border.all(
          color: Colors.lightGreen,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      // color: Colors.purple,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 14),
          child: Row(
            children: [
              Text(
                weather.next_days[i].name,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('MAX :'),
              SizedBox(width: 10),
              Text(
                weather.next_days[i].max_temp + '\u2103',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(width: 40),
              Text('MIN :'),
              SizedBox(width: 10),
              Text(
                weather.next_days[i].min_temp + '\u2103',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                weather.next_days[i].weather,
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

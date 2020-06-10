class Weather {
  final String dayhour;
  final String humidity;
  final String precipitation;
  final String region;
  final String temp_now;
  final String weather_now;
  final String wind;
  final List<Next_days> next_days;

  Weather(
      {this.dayhour,
      this.humidity,
      this.precipitation,
      this.region,
      this.temp_now,
      this.weather_now,
      this.wind,
      this.next_days});

  factory Weather.fromJson(Map<String, dynamic> json) {
    // var list = json['nex_days'] as List;
    // List<Next_days> next_day_list = list.map<Next_days>((i) => Next_days.fromJson(i)).toList();

    List<Next_days> parseDays(daysJson) {
      var list = daysJson['next_days'] as List;
      List<Next_days> daysList =
          list.map((data) => Next_days.fromJson(data)).toList();
      return daysList;
    }

    // list.map<Next_days>(Closure: (dynamic) => Next_days)

    return Weather(
      dayhour: json['dayhour'],
      humidity: json['humidity'],
      precipitation: json['precipitation'],
      region: json['region'],
      temp_now: json['temp_now'],
      weather_now: json['weather_now'],
      wind: json['wind'],
      next_days: parseDays(json),
    );
  }
}

class Next_days {
  final max_temp;
  final min_temp;
  final name;
  final weather;

  Next_days({
    this.max_temp,
    this.min_temp,
    this.name,
    this.weather,
  });

  factory Next_days.fromJson(Map<String, dynamic> json) {
    return Next_days(
      max_temp: json['max_temp'],
      min_temp: json['min_temp'],
      name: json['name'],
      weather: json['weather'],
    );
  }
}

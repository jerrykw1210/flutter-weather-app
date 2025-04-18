import 'dart:developer';

import 'package:flutter_weather_app/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<dynamic> fetchWeather(String lat, String long) async {
    final response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=907e43c20b102aa0e5c1029de75ef3e8",
      ),
    );
    log("re ${response.body} $lat $long");
    if (response.statusCode == 200) {
      log("repsonse ${response.body} $lat $long");
      final json = weatherFromJson(response.body);
      log("weather json $json");
      return json;
    } else {
      throw Exception('Failed to fetch initial value');
    }
  }
}

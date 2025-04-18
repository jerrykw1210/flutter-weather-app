// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<Minutely> minutely;
  final List<CurrentWeather> hourly;
  final List<Daily> daily;

  Weather({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    timezone: json["timezone"],
    timezoneOffset: json["timezone_offset"],
    current: CurrentWeather.fromJson(json["current"]),
    minutely: List<Minutely>.from(
      json["minutely"].map((x) => Minutely.fromJson(x)),
    ),
    hourly: List<CurrentWeather>.from(
      json["hourly"].map((x) => CurrentWeather.fromJson(x)),
    ),
    daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "timezone_offset": timezoneOffset,
    "current": current.toJson(),
    "minutely": List<dynamic>.from(minutely.map((x) => x.toJson())),
    "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
    "daily": List<dynamic>.from(daily.map((x) => x.toJson())),
  };
}

class CurrentWeather {
  final int dt;
  final int? sunrise;
  final int? sunset;
  final int temp;
  final int feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final List<WeatherElement> weather;
  final double? windGust;
  final double? pop;
  final Rain? rain;

  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
     this.windGust,
     this.pop,
     this.rain,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
    dt: json["dt"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    temp: ((json["temp"]?.toDouble() - 273.15)).toInt(),
    feelsLike: ((json["feels_like"]?.toDouble() - 273.15)).toInt(),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"]?.toDouble(),
    uvi: json["uvi"]?.toDouble(),
    clouds: json["clouds"],
    visibility: json["visibility"],
    windSpeed: json["wind_speed"]?.toDouble(),
    windDeg: json["wind_deg"],
    weather: List<WeatherElement>.from(
      json["weather"].map((x) => WeatherElement.fromJson(x)),
    ),
    windGust: json["wind_gust"]?.toDouble(),
    pop: json["pop"]?.toDouble(),
    rain:json["rain"] == null ? null : Rain.fromJson(json["rain"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "sunrise": sunrise,
    "sunset": sunset,
    "temp": temp,
    "feels_like": feelsLike,
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "uvi": uvi,
    "clouds": clouds,
    "visibility": visibility,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "wind_gust": windGust,
    "pop": pop,
    "rain": rain?.toJson(),
  };
}

class Rain {
  final double the1H;

  Rain({required this.the1H});

  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(the1H: json["1h"]?.toDouble());

  Map<String, dynamic> toJson() => {"1h": the1H};
}

class WeatherElement {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherElement({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}


class Daily {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final String summary;
  final Temp temp;
  final FeelsLike feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final List<WeatherElement> weather;
  final int clouds;
  final double? pop;
  final double? rain;
  final double uvi;

  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.summary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json["dt"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"]?.toDouble(),
    summary: json["summary"],
    temp: Temp.fromJson(json["temp"]),
    feelsLike: FeelsLike.fromJson(json["feels_like"]),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"]?.toDouble(),
    windSpeed: json["wind_speed"]?.toDouble(),
    windDeg: json["wind_deg"],
    windGust: json["wind_gust"]?.toDouble(),
    weather: List<WeatherElement>.from(
      json["weather"].map((x) => WeatherElement.fromJson(x)),
    ),
    clouds: json["clouds"],
    pop: json["pop"]?.toDouble(),
    rain: json["rain"]?.toDouble(),
    uvi: json["uvi"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "summary": summary,
    "temp": temp.toJson(),
    "feels_like": feelsLike.toJson(),
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "wind_gust": windGust,
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds,
    "pop": pop,
    "rain": rain,
    "uvi": uvi,
  };
}

class FeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
    day: json["day"]?.toDouble(),
    night: json["night"]?.toDouble(),
    eve: json["eve"]?.toDouble(),
    morn: json["morn"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}

class Temp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: json["day"]?.toDouble(),
    min: json["min"]?.toDouble(),
    max: json["max"]?.toDouble(),
    night: json["night"]?.toDouble(),
    eve: json["eve"]?.toDouble(),
    morn: json["morn"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "min": min,
    "max": max,
    "night": night,
    "eve": eve,
    "morn": morn,
  };
}

class Minutely {
  final int dt;
  final int precipitation;

  Minutely({required this.dt, required this.precipitation});

  factory Minutely.fromJson(Map<String, dynamic> json) =>
      Minutely(dt: json["dt"], precipitation: json["precipitation"]);

  Map<String, dynamic> toJson() => {"dt": dt, "precipitation": precipitation};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

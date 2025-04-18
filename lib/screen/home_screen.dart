import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubit/weather_cubit.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:bloc/bloc.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Location location = Location();

  bool _loading = false;

  LocationData? _location;
  String? _error;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _getLocation();
    _controller = VideoPlayerController.asset('assets/background/cloudy.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final locationResult = await location.getLocation();
      context.read<WeatherCubit>().fetchWeather(
        locationResult.latitude.toString() ?? "",
        locationResult.longitude.toString() ?? "",
      );
      // setState(() {
      //   _location = locationResult;
      //   _loading = false;
      // });
      log("get location $locationResult");
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state.fetchWeatherStatus == FetchWeatherStatus.success) {
            return Stack(
              children: [
                // SizedBox.expand(
                //   child: FittedBox(
                //     fit: BoxFit.cover,
                //     child: SizedBox(
                //       width: _controller.value.size?.width ?? 0,
                //       height: _controller.value.size?.height ?? 0,
                //       child: VideoPlayer(_controller),
                //     ),
                //   ),
                // ),
                Column(
                  children: [
                    Text(
                      state.weather?.current.temp.toString() ?? "",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        state.weather?.current.weather[0].main ?? "",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Text(
                      "Updated as of ${DateFormat('yyyy-MM-dd h:mm a').format(DateTime.fromMillisecondsSinceEpoch((state.weather?.current.dt ?? 0) * 1000))}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 2.0,
                        shrinkWrap: true,
                        children: [
                          WeatherDetailCard(
                            icon: Icons.thermostat,
                            title: "Feels Like",
                            value: "${state.weather?.current.feelsLike} \u2103",
                          ),
                          WeatherDetailCard(
                            icon: Icons.wind_power,

                            title: "Wind",
                            value:
                                state.weather?.current.windSpeed.toString() ??
                                "",
                          ),
                          WeatherDetailCard(
                            icon: Icons.water_drop,

                            title: "Humidity",
                            value: "${state.weather?.current.humidity}%",
                          ),

                          WeatherDetailCard(
                            icon: Icons.visibility,

                            title: "Visibility",
                            value:
                                state.weather?.current.visibility.toString() ??
                                "",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 200,
                      child: Card(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  "Hourly Forecast",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Flexible(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.weather?.hourly.length ?? 0,
                                  separatorBuilder:
                                      (context, index) =>
                                          Padding(padding: EdgeInsets.all(5.0)),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('h:mm a').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              (state
                                                          .weather
                                                          ?.hourly[index]
                                                          .dt ??
                                                      0) *
                                                  1000,
                                            ),
                                          ),
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.labelMedium,
                                        ),

                                        Image.network(
                                          "https://openweathermap.org/img/wn/${state.weather?.hourly[index].weather[0].icon}.png",
                                        ),
                                        Text(
                                          "${state.weather?.hourly[index].temp} \u2103",
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.labelLarge,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return SizedBox();
          Column(
            children: [
              Text("23", style: Theme.of(context).textTheme.headlineMedium),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Partly Cloudy",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Text(
                "Updated as of 2:30pm",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          );
        },
      ),
    );
  }
}

class WeatherDetailCard extends StatelessWidget {
  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });
  final IconData icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Icon(icon), Text(title)]),
            Padding(padding: const EdgeInsets.all(8.0), child: Text(value)),
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/model/weather.dart';
import 'package:flutter_weather_app/service/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherState());

  Future<void> fetchWeather(String latitude, String longitude) async {
    emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.loading));
    try {
      final weather = await WeatherService().fetchWeather(latitude, longitude);
      if (weather is Weather) {
        log("is weather or not oh");
        emit(
          state.copyWith(
            fetchWeatherStatus: FetchWeatherStatus.success,
            weather: weather,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.fail));
    }
  }
}

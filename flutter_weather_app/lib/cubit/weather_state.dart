part of 'weather_cubit.dart';

enum FetchWeatherStatus { initial, success, fail, loading, empty }

class WeatherState extends Equatable {
  const WeatherState({
    this.fetchWeatherStatus = FetchWeatherStatus.initial,
    this.weather,
  });
  final FetchWeatherStatus fetchWeatherStatus;
  final Weather? weather;

  WeatherState copyWith({
    FetchWeatherStatus? fetchWeatherStatus,
    Weather? weather,
  }) {
    return WeatherState(
      fetchWeatherStatus: fetchWeatherStatus ?? this.fetchWeatherStatus,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [fetchWeatherStatus, weather];
}

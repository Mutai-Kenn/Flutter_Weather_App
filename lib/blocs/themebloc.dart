import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/models.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  const WeatherChanged({@required this.condition}) : assert(condition != null);

  @override
  List<Object> get props => [condition];
}

class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  const ThemeState({@required this.theme, @required this.color})
      : assert(theme != null),
        assert(color != null);

  @override
  List<Object> get props => [theme, color];
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(theme: ThemeData.light(), color: Colors.lightBlue));

  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is WeatherChanged) {
      yield _mapWeatherConditionToThemeData(event.condition);
    }
  }

  ThemeState _mapWeatherConditionToThemeData(WeatherCondition condition) {
    ThemeState theme;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.orangeAccent),
            color: Colors.yellow);
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.lightBlueAccent),
            color: Colors.lightBlue);
        break;
      case WeatherCondition.heavyCloud:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.blueGrey),
            color: Colors.grey);
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.indigoAccent),
            color: Colors.indigo);
        break;
      case WeatherCondition.thunderstorm:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
            color: Colors.deepPurple);
        break;
      case WeatherCondition.unknown:
        theme = ThemeState(theme: ThemeData.light(), color: Colors.lightBlue);
        break;
    }
    return theme;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/blocs.dart';
import 'package:weather/blocs/themebloc.dart';
import 'package:weather/repositories/repositories.dart';
import 'package:weather/weather_bloc_obsever.dart';
import 'package:http/http.dart' as http;
import 'package:weather/widgets/widgets.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient:
        WeatherApiClient(HttpClient: http.Client(), httpClient: null),
  );
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(),
    child: App(weatherRepository: weatherRepository),
  ));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        title: 'Flutter Weather',
        home: BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
          child: Weather(),
        ),
      );
    });
  }
}

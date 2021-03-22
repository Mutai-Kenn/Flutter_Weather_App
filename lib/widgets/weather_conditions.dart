import 'package:flutter/cupertino.dart';
import 'package:weather/models/models.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;

  WeatherConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
      case WeatherCondition.heavyCloud:
        image = Image.asset('icons/clear.png');
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        image = Image.asset('icons/snow.png');
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        image = Image.asset('icons/rainy.png');
        break;
      case WeatherCondition.thunderstorm:
        image = Image.asset('icons/thunderstorm.png');
        break;
      case WeatherCondition.unknown:
        image = Image.asset('icons/clear.png');
        break;
    }
    return image;
  }
}

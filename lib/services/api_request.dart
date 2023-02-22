import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class DataRequest {
  final dio = Dio();
  final apikey = 'f60aee0cb01f476b9ab0c6e2d02d46ad';
  final BASE_URL = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherModel> getWeather(double lat, double long) async {
    final requestUrl =
        '$BASE_URL/weather?lat=$lat&lon=$long&appid=$apikey&units=metric';

    final response = await dio.get(requestUrl);
    final weatherData = WeatherModel.fromJson(json.decode(response.toString()));

    return Future(() => weatherData);
    // print(_weather);
  }

  Future<List<WeatherModel>> getForecast(double lat, double long) async {
    final requestUrl =
        '$BASE_URL/forecast?lat=$lat&lon=$long&id=524901&appid=$apikey&units=metric';

    final response = await dio.get(requestUrl);
    final jsonData = json.decode(response.toString());

    final List<dynamic> data = jsonData["list"];
    final List<WeatherModel> forecastData =
        data.map<WeatherModel>((e) => WeatherModel.fromJson(e)).toList();

    // print(data);
    // print(forecastData);

    return Future(() => forecastData);
  }
}

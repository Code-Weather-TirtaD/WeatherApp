import 'package:flutter/material.dart';

import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/api_request.dart';

import 'package:weather_app/views/search_page.dart';
import 'package:weather_app/views/setting_page.dart';

import 'package:weather_app/widgets/daily_forecast.dart';
import 'package:weather_app/widgets/hourly_forecast.dart';
import 'package:weather_app/widgets/loading.dart';

class HomePage extends StatefulWidget {
  final double lat;
  final double long;

  const HomePage({super.key, required this.lat, required this.long});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // double lat = -6.3687594;
  // double long = 106.8624118;

  Future<WeatherModel>? _weather;
  Future<List<WeatherModel>>? _forecast;

  @override
  void initState() {
    _weather = DataRequest().getWeather(widget.lat, widget.long);
    _forecast = DataRequest().getForecast(widget.lat, widget.long);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('WeatherApp'),
              IconButton(
                  icon: const Icon(Icons.settings_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingPage()));
                  })
            ],
          )),
      body: FutureBuilder(
          future: _weather,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            } else {
              final data = snapshot.data as WeatherModel;
              final iconUrl =
                  'http://openweathermap.org/img/wn/${data.weatherIcon}@2x.png';
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    // Temperature Degrees
                    Container(
                      color: Colors.indigo[100],
                      height: size.height * 0.25,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  NetworkImage(iconUrl),
                                  size: 70,
                                ),
                                Column(children: [
                                  Text(data.weather),
                                  Text(data.weatherDescription)
                                ])
                              ],
                            ),
                            Text(
                              "${data.temperature.round()} \u2103",
                              style: const TextStyle(
                                  fontSize: 70, fontWeight: FontWeight.w200),
                            ),
                            Text(
                                "Temperature Feel: ${data.temperatureFeel.round()} \u2103"),
                          ]),
                    ),
                    // Wind Description
                    SizedBox(
                      height: size.height * 0.13,
                      child: Card(
                        elevation: 0,
                        color: Colors.grey[100],
                        shape: const OutlineInputBorder(),
                        child: GridView(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: 30,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2),
                          children: [
                            Text("Wind: ${data.windSpeed} m/s"),
                            Text("Humidity: ${data.humidity} %"),
                            Text(
                                "Min Temp: ${data.temperatureMin.round()} \u2103"),
                            Text("Pressure: ${data.pressure} hPa"),
                            Text("Visibility: ${(data.visibility / 1000)} KM"),
                            Text(
                                "Max Temp: ${data.temparatureMax.round()} \u2103"),
                          ],
                        ),
                      ),
                    ),
                    // Forecast Data
                    FutureBuilder(
                      future: _forecast,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Loading();
                        } else {
                          final data = snapshot.data as List<WeatherModel>;
                          const iconUrl = 'http://openweathermap.org/img/wn/';

                          return Column(
                            children: [
                              // Hourly forecast
                              HourlyForecast(
                                  size: size, iconUrl: iconUrl, data: data),
                              // Daily forecast
                              DailyForecast(iconUrl: iconUrl, data: data)
                            ],
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}

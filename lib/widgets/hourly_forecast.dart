import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_model.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({
    Key? key,
    required this.size,
    required this.iconUrl,
    required this.data,
  }) : super(key: key);

  final Size size;
  final String iconUrl;
  final List<WeatherModel> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length < 15 ? data.length : 15,
        itemBuilder: (context, index) {
          var icon = '$iconUrl${data[index].weatherIcon}@2x.png';
          var timestamp =
              DateTime.fromMillisecondsSinceEpoch(data[index].dt * 1000);
          var date = DateFormat.MMMd('en_US').format(timestamp);
          var time = DateFormat.Hm().format(timestamp);

          return SizedBox(
            width: 100,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(time == '01:00' ? date : time),
                  ImageIcon(NetworkImage(icon), size: 50),
                  Text("${data[index].temparatureMax.round()} \u2103"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

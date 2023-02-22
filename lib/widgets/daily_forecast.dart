import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_model.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    Key? key,
    required this.iconUrl,
    required this.data,
  }) : super(key: key);

  final String iconUrl;
  final List<WeatherModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        var icon = '$iconUrl${data[index].weatherIcon}@2x.png';
        var timestamp =
            DateTime.fromMillisecondsSinceEpoch(data[index].dt * 1000);
        var date = DateFormat('EEE MMM d', 'en_US').format(timestamp);
        var time = DateFormat.jm().format(timestamp);

        // condition for using free plan API
        if (time == '7:00 AM') {
          return ListTile(
            shape: const Border(top: BorderSide()),
            leading: Text(date),
            title: Text(
              "${data[index].temparatureMax} / ${data[index].temperatureMin} \u2103",
              textAlign: TextAlign.end,
            ),
            trailing: ImageIcon(NetworkImage(icon)),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

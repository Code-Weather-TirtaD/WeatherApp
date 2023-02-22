import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  final String creditDetail =
      "All data in this app is provided by OpenWeather API\u2122. OpenWeather aggregates and processes meteorological data from tens of thousand weather stations, on-ground radars and satelites to bring accurate and actionable weather data for any location worldwide.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: true,
      ),
      body: Column(children: [
        ListTile(
          title: Text('Different weather?'),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          shape: UnderlineInputBorder(),
          onTap: () {
            print('different weather');
          },
        ),
        ListTile(
          title: Text('Customize units'),
          trailing: Icon(Icons.arrow_forward_ios_rounded),
          shape: UnderlineInputBorder(),
          onTap: () {
            print('units');
          },
        ),
        const ListTile(
            title: Text('Credit to: '),
            trailing: Text('Open Weather API\u2122')),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(creditDetail, textAlign: TextAlign.justify),
        )
      ]),
    );
  }
}

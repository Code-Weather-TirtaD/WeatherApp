import 'package:flutter/material.dart';
import 'package:weather_app/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final double initLat = 0.0;
  final double initLong = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(lat: initLat, long: initLong),
      debugShowCheckedModeBanner: false,
    );
  }
}

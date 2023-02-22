class WeatherModel {
  final String weather;
  final String weatherDescription;
  final String weatherIcon;

  final double temperature;
  final double temperatureFeel;
  final double temperatureMin;
  final double temparatureMax;

  final int humidity;
  final int pressure;
  final int visibility;
  final num windSpeed;
  final int windDirection;

  final int dt;

  WeatherModel.fromJson(Map<String, dynamic> json)
      : weather = json['weather'][0]['main'],
        weatherDescription = json['weather'][0]['description'],
        weatherIcon = json['weather'][0]['icon'],
        temperature = json['main']['temp'],
        temperatureFeel = json['main']['feels_like'],
        temperatureMin = json['main']['temp_min'],
        temparatureMax = json['main']['temp_max'],
        humidity = json['main']['humidity'],
        pressure = json['main']['pressure'],
        visibility = json['visibility'],
        windSpeed = json['wind']['speed'],
        windDirection = json['wind']['deg'],
        dt = json['dt'];
}

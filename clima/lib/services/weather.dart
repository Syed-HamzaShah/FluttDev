import '../services/networking.dart';
import '../services/location.dart';

const apiKey = "eb85a1e02fc415e8615ff8d2ccda8720";

class WeatherModel {
  Future<dynamic> getLocationByName(String city) async {
    Networking networking = Networking(
        url:
            'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    var weatherData = await networking.getData();

    return weatherData;
  }

  Future<dynamic> getlocation() async {
    Jagah jagah = Jagah();
    await jagah.getCurrentLocation();

    double latitude = jagah.latitude!;
    double longitude = jagah.longitude!;

    Networking networking = Networking(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    var weatherData = await networking.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

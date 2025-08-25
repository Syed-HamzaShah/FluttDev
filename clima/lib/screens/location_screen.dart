import 'loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int? temperature;
  String? weatherIcon;
  String? weatherMsg;
  String? cityName;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic data) {
    if (data == null) {
      temperature = 0;
      weatherIcon = 'null';
      weatherMsg = 'No data';
      cityName = '';
      return;
    }
    double temp = data['main']['temp'];
    temperature = temp.toInt();
    int cond = data['weather'][0]['id'];
    weatherIcon = weatherModel.getWeatherIcon(cond);
    weatherMsg = weatherModel.getMessage(temp.toInt());
    cityName = data['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await WeatherModel().getlocation();
                      updateUI(weatherData);
                    },
                    child: Icon(Icons.near_me, size: 40.0),
                  ),
                  TextButton(
                    onPressed: () async {
                      var name = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (name != null) {
                        var d = await WeatherModel().getLocationByName(name);
                        updateUI(d);
                      }
                    },
                    child: Icon(Icons.location_city, size: 40.0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text('$temperature', style: kTempTextStyle),
                    Text('$weatherIcon', style: kConditionTextStyle),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: Text(
                  "$weatherMsg in $cityName!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

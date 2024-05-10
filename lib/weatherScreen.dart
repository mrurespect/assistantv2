import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart'; // Importez DateFormat depuis le package intl
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String city = 'settat';
  double _latitude = 0.0;
  double _longitude = 0.0;

  @override
  void initState() {
    super.initState();
    fetchWeather();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
      _getAddressFromLating();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getAddressFromLating() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(_latitude, _longitude);
      Placemark place = placemarks[0];
      print("${place.locality}");
      setState(() {
        city = "${place.locality}";
      });
    } catch (e) {
      setState(() {
        city = 'settat';
      });
    }
  }

  final String apiKey = '929e16e1b33d4d9cb6b42021d168e393';
  List<dynamic> forecastData = [];

  Future<void> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$_latitude&lon=$_longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      setState(() {
        forecastData = jsonDecode(response.body)['list'];
      });
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Weather  $city',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: forecastData.length,
                itemBuilder: (context, index) {
                  var forecast = forecastData[index];
                  var date = DateTime.fromMillisecondsSinceEpoch(
                      forecast['dt'] * 1000);
                  var temperature = forecast['main']['temp'];
                  var description = forecast['weather'][0]['description'];
                  var iconCode = forecast['weather'][0]['icon'];
                  var iconUrl =
                      'http://openweathermap.org/img/wn/$iconCode.png';

                  return Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), 
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            '$description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                '$iconUrl',
                                fit: BoxFit.contain,
                              ),
                              Text(
                                '$temperature°C',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '$city',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            '${DateFormat('EEEE').format(date)}  ${DateFormat('dd/MM').format(date)}  ${DateFormat.Hm().format(date)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

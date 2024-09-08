import 'package:day3/model/weather_response.dart';
import 'package:day3/network/api_service.dart';
import 'package:day3/network/constants.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<WeatherResponse>(
        future: ApiService.api.fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Weather> weather = snapshot.data!.weather;
            MainWeather? mainWeather = snapshot.data!.mainWeather;
            return ListView.builder(
              itemCount: weather.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(weather[index].description),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${mainWeather!.temp}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.network('$iconImg${weather[index].icon}@2x.png'),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}

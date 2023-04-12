import 'package:flutter/material.dart';
import 'package:sensor_app/core/services/env/environment.service.dart';
import 'package:sensor_app/in_app/home.screen.dart';
import 'package:sensor_app/shared/sensor_theme.dart';

void main() async {
  await EnvironmentService.load();
  runApp(const SensorApp());
}

class SensorApp extends StatelessWidget {
  const SensorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor App',
      debugShowCheckedModeBanner: false,
      theme: sensorTheme(),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}

import 'package:sensor_app/core/models/sensor.dart';

class MySensors {
  List<Sensor> sensors = [
    Sensor("c1-envoi-temperature", "Capteur 1"),
    Sensor("c2-envoi-temperature", "Capteur 2"),
  ];

  List<Sensor> get getSensors => sensors;
}
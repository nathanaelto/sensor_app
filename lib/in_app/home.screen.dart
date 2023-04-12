import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sensor_app/core/constants/my_sensors.dart';
import 'package:sensor_app/core/models/sensor.dart';
import 'package:sensor_app/core/services/mqtt/mqtt.service.dart';
import 'package:sensor_app/in_app/components/sensor.widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MySensors mySensors = MySensors();
  MqttService mqttService = MqttService();
  List<Sensor> sensors = [];
  List<double> values = [];

  @override
  void initState() {
    sensors = mySensors.getSensors;
    values = List.filled(sensors.length, 0);
    setupMqttClient();
    setupUpdatesListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monitoring',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: sensors.length,
          itemBuilder: (context, index) {
            return SensorWidget(
              topicName: sensors[index].topicName,
              sensorName: sensors[index].sensorName,
              value: values[index],
            );
          },
        ),
      ),
    );
  }

  Future<void> setupMqttClient() async {
    await mqttService.connect();
    for (var element in sensors) {
      mqttService.subscribe(element.topicName);
    }
    return;
  }

  void setupUpdatesListener() {
    mqttService
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      print('From topic: ${recMess.variableHeader?.topicName}');
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          "Sensor: ${recMess.variableHeader?.topicName} --------- value: ${double.parse(pt)}");

      for (var topic in sensors) {
        if (topic.topicName == recMess.variableHeader?.topicName) {
          setState(() {
            values[sensors.indexOf(topic)] = double.parse(pt);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    mqttService.disconnect();
    super.dispose();
  }
}

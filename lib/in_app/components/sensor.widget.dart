import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

class SensorWidget extends StatelessWidget {
  final String topicName;
  final String sensorName;
  final double value;

  const SensorWidget({
    Key? key,
    required this.topicName,
    required this.sensorName,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.3,
              child: RadialGauge(
                axes: [
                  RadialGaugeAxis(
                    color: Colors.transparent,
                    minValue: -20,
                    maxValue: 40,
                    pointers: [
                      RadialNeedlePointer(
                        value: value,
                        color: Colors.blue,
                        length: 0.8,
                      )
                    ],
                    ticks: [
                      RadialTicks(
                          color: Colors.white,
                          length: 0.4,
                          interval: 10,
                          alignment: RadialTickAxisAlignment.inside,
                          children: [
                            RadialTicks(
                              ticksInBetween: 5,
                              length: 0.3,
                              color: Colors.white,
                            )
                          ]),
                    ],
                    segments: [
                      const RadialGaugeSegment(
                        minValue: -20,
                        maxValue: 2,
                        minAngle: -150,
                        maxAngle: -60,
                        color: Colors.red,
                        gradient: SweepGradient(
                          colors: [
                            Colors.red,
                            Colors.red,
                            Colors.amber,
                          ],
                        ),
                      ),
                      const RadialGaugeSegment(
                        minValue: 2,
                        maxValue: 4,
                        minAngle: -60,
                        maxAngle: -30,
                        color: Colors.amber,
                      ),
                      const RadialGaugeSegment(
                        minValue: 4,
                        maxValue: 40,
                        minAngle: -30,
                        maxAngle: 150,
                        color: Colors.green,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: Text(
                '${value.toStringAsFixed(1) ?? 0}°C',
                style: Theme.of(context).textTheme?.headline3,
              ),
            ),
            Text(
              sensorName,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

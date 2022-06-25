import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProfileGauge extends StatelessWidget {
  final String title;
  final double currentValue;

  const ProfileGauge({
    Key? key,
    required this.title,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: SfRadialGauge(
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: .2,
              cornerStyle: CornerStyle.bothCurve,
              color: Colors.lightBlue.shade300,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: [
              RangePointer(
                value: currentValue,
                cornerStyle: CornerStyle.bothCurve,
                width: .2,
                sizeUnit: GaugeSizeUnit.factor,
                color: Colors.blue.shade700,
                enableAnimation: true,
              ),
            ],
            annotations: [
              GaugeAnnotation(
                positionFactor: .9,
                angle: 90,
                widget: Column(
                  children: [
                    Text('$title'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Countup(
                          begin: 0,
                          end: currentValue.toDouble(),
                          duration: const Duration(milliseconds: 1000),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                          ),
                        ),
                        const Text(
                          '/100%',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //           text: currentValue.toStringAsFixed(0),
                    //           style: const TextStyle(
                    //               fontSize: 40.0, fontWeight: FontWeight.bold)),
                    //       const TextSpan(
                    //           text: '/100%', style: TextStyle(fontSize: 20.0)),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

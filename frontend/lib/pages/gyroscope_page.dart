import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/config/project_settings.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopePage extends StatefulWidget {
  const GyroscopePage({super.key});

  @override
  State<GyroscopePage> createState() => _GyroscopePageState();
}

enum Apps { webPage, excel, whatsappWeb }

class _GyroscopePageState extends State<GyroscopePage> {
  final _streamSubscription = <StreamSubscription<GyroscopeEvent?>>[];
  static const Duration _ignoreDuration = Duration(milliseconds: 100);
  DateTime? _gyroscopeUpdateTime;
  int? _gyroscopeLastInterval;
  Duration sensorInterval = SensorInterval.normalInterval;
  double? x = 0.0;
  double? y = 0.0;
  double? z = 0.0;
  final String _apiUrl = dotenv.get('API_URL');

  @override
  void initState() {
    super.initState();
    _streamSubscription.add(
      gyroscopeEventStream(samplingPeriod: sensorInterval).listen(
        (GyroscopeEvent event) {
          final now = DateTime.now();
          setState(() {
            if (_gyroscopeUpdateTime != null) {
              final interval = now.difference(_gyroscopeUpdateTime!);
              if (interval > _ignoreDuration) {
                _gyroscopeLastInterval = interval.inMilliseconds;
                x = event.x.roundToDouble();
                y = event.y.roundToDouble();
                z = event.z.roundToDouble();
              }
            }
          });
          _gyroscopeUpdateTime = now;
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Gyroscope Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (z! <= -4.0) {
      _openApp(Apps.excel);
    } else if (z! >= 4.0) {
      _openApp(Apps.webPage);
    } else if (ProjectSettings.openWhatsappWeb && x! <= -4) {
      _openApp(Apps.whatsappWeb);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giroscopio"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(children: [
            Text("x = $x"),
            Text("y = $y"),
            Text("z = $z"),
            Text("Intervalo = $_gyroscopeLastInterval"),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Abrir whatsapp web"),
              Switch(
                  value: ProjectSettings.openWhatsappWeb,
                  onChanged: (newValue) =>
                      ProjectSettings.openWhatsappWeb = newValue)
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    for (final subscription in _streamSubscription) {
      subscription.cancel();
    }
  }

  void _openApp(Apps app) {
    switch (app) {
      case Apps.webPage:
        http.get(Uri.parse("$_apiUrl/web_page"));
        break;

      case Apps.excel:
        http.get(Uri.parse("$_apiUrl/excel"));
        break;

      case Apps.whatsappWeb:
        http.get(Uri.parse("$_apiUrl/whatsapp"));
        break;

      default:
        break;
    }
  }
}

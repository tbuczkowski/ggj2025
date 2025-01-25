import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:ggj2025_flutter/game.dart';

void main() {
  runApp(const MyApp());
}

enum SerialMessageType {
  incoming,
  outgoing,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SerialPort port;
  late SerialPortReader reader;

  final List<(SerialMessageType, String)> receivedData = [];

  @override
  void initState() {
    super.initState();
     initPorts();
  }

  Future<void> initPorts() async {
    // port = SerialPort('/dev/cu.usbmodem11201');
    port = SerialPort('COM3');
    port.openReadWrite();
    // this reboots the python program running on rpi
    port.write(Uint8List.fromList('\x03\x04'.codeUnits));
    await Future.delayed(const Duration(seconds: 1));
    reader = SerialPortReader(port)
      ..stream.listen((data) {
        final String dataString = String.fromCharCodes(data).replaceAll(RegExp(r"\s+"), '');
        if (dataString.isEmpty) {
          return;
        }
        // receivedData.add((SerialMessageType.incoming, dataString));
        if (dataString == 'greenOn') {
          game.greenButtonOn();
        }
        if (dataString == 'greenOff') {
          game.greenButtonOff();
        }
        if (dataString == 'redOn') {
          game.redButtonOn();
        }
        if (dataString == 'redOff') {
          game.redButtonOff();
        }
        // setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GGJ25GameWidget();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: receivedData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    children: [
                      Icon(receivedData[index].$1 == SerialMessageType.incoming
                          ? Icons.arrow_downward
                          : Icons.arrow_upward),
                      Flexible(child: Text(receivedData[index].$2)),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.sizeOf(context).width,
            child: TextField(
              onSubmitted: (String text) {
                port.write(Uint8List.fromList(text.codeUnits + '\r\n'.codeUnits));
                receivedData.add((SerialMessageType.outgoing, text));
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}

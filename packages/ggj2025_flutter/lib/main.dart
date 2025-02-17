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

  var future;

  @override
  void initState() {
    super.initState();
    try {
      future = initPorts();
    } catch (e) {
      print(e);
    }
  }

  bool started = false;

  Future<void> initPorts() async {
    print(SerialPort.availablePorts);
    port = SerialPort('/dev/cu.usbmodem11401');
    // port = SerialPort('COM3');
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
        if (dataString == 'cartridge') {
          started = true;
          setState(() {});
        }
        // setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return !started
        ? Scaffold(
            body: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                  child: Image(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.fill,
                  )),
              Column(
                children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  Text(
                    'WŁÓŻ KARTRIDŻ ABY ROZPOCZĄĆ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.teal),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          started = true;
                        });
                      },
                      child: Text('debug start'))
                ],
              ),
            ],
          )
            // Center(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Spacer(),
            //       Text('ZBRODNIAGE ENTERTAINMENT SYSTEM'),
            //       Text('INSERT CARTRIDGE TO CONTINUE'),
            //       const Spacer(),
            //       ElevatedButton(
            //           onPressed: () {
            //             setState(() {
            //               started = true;
            //             });
            //           },
            //           child: Text('start')),
            //     ],
            //   ),
            // ),
            )
        : GGJ25GameWidget();
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

class ResponsiveScreen extends StatelessWidget {
  /// This is the "hero" of the screen. It's more or less square, and will
  /// be placed in the visual "center" of the screen.
  final Widget squarishMainArea;

  /// The second-largest area after [squarishMainArea]. It can be narrow
  /// or wide.
  final Widget rectangularMenuArea;

  /// An area reserved for some static text close to the top of the screen.
  final Widget topMessageArea;

  const ResponsiveScreen({
    required this.squarishMainArea,
    required this.rectangularMenuArea,
    this.topMessageArea = const SizedBox.shrink(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // This widget wants to fill the whole screen.
        final size = constraints.biggest;
        final padding = EdgeInsets.all(size.shortestSide / 30);

        if (size.height >= size.width) {
          // "Portrait" / "mobile" mode.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: padding,
                  child: topMessageArea,
                ),
              ),
              Expanded(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  minimum: padding,
                  child: squarishMainArea,
                ),
              ),
              SafeArea(
                top: false,
                maintainBottomViewPadding: true,
                child: Padding(
                  padding: padding,
                  child: Center(
                    child: rectangularMenuArea,
                  ),
                ),
              ),
            ],
          );
        } else {
          // "Landscape" / "tablet" mode.
          final isLarge = size.width > 900;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Spacer(
                      flex: 5,
                    ),
                    rectangularMenuArea,
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abdelilah Hijazi Torch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> torchLightOn() async {
    try {
      await TorchLight.enableTorch();
    } on EnableTorchExistentUserException {
      //camera in use
    } on EnableTorchNotAvailableException {
      //torch not available
    } on EnableTorchException {
      //something went wrong
    }
  }

  Future<void> torchLightOff() async {
    try {
      await TorchLight.disableTorch();
    } on DisableTorchExistentUserException {
      //camera in use
    } on DisableTorchNotAvailableException {
      //torch not available
    } on DisableTorchException {
      //something went wrong
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Abdelilah Hijazi Torch",
            style: TextStyle(
                fontFamily: "CarterOne",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 189, 240, 7))),
        backgroundColor: const Color.fromARGB(233, 1, 200, 233),
        shadowColor: const Color.fromARGB(255, 245, 245, 9),
        elevation: 50,
        toolbarHeight: 50,
        titleSpacing: 10,
      ),
      body: Stack(
        children: [
          Image.asset(
            "images/flashlight.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Center(
              child: LiteRollingSwitch(
                width: 200,
                colorOff: const Color.fromARGB(186, 66, 220, 244),
                colorOn: const Color.fromARGB(255, 174, 243, 117),
                iconOn: CupertinoIcons.lightbulb_fill,
                iconOff: CupertinoIcons.lightbulb_slash,
                textOff: "Torch Off",
                textOn: "Torch On",
                textOnColor: Colors.white,
                textOffColor: Colors.white,
                textSize: 30,
                animationDuration: const Duration(milliseconds: 100),
                onChanged: (val) {
                  if (val) {
                    torchLightOn();
                  } else {
                    torchLightOff();
                  }
                },
                onDoubleTap: () {},
                onSwipe: () {},
                onTap: () {},
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              backgroundColor: const Color.fromARGB(255, 247, 101, 90),
              child: const Icon(Icons.close),
            ),
          )
        ],
      ),
    );
  }
}

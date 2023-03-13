import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class AudioPlayer {
  static const platform = MethodChannel('audio_player');
  static Future<void> play(String url) async {
    try {
      await platform.invokeMethod('play', {'url': url});
    } on PlatformException catch (e) {
      print("Failed to play audio: '${e.message}'.");
    }
  }

  static Future<void> pause() async {
    try {
      await platform.invokeMethod('pause');
    } on PlatformException catch (e) {
      print("Failed to pause audio: '${e.message}'.");
    }
  }

  static Future<void> stop() async {
    try {
      await platform.invokeMethod('stop');
    } on PlatformException catch (e) {
      print("Failed to stop audio: '${e.message}'.");
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  AudioPlayer.play(
                      'https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3');
                },
                child: const Text('Play')),
            ElevatedButton(
              onPressed: () {
                AudioPlayer.pause();
              },
              child: const Text("Pause"),
            ),
            ElevatedButton(
                onPressed: () {
                  AudioPlayer.stop();
                },
                child: const Text('Stop')),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

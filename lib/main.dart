import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Crash list',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Firebase Crash list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Crashlytics example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                  child: const Text('Key'),
                  onPressed: () {
                    Crashlytics.instance.setString('foo', 'bar');
                  }),
              FlatButton(
                  child: const Text('Log'),
                  onPressed: () {
                    Crashlytics.instance.log('baz');
                  }),
              FlatButton(
                  child: const Text('Crash'),
                  onPressed: () {
                    // Use Crashlytics to throw an error. Use this for
                    // confirmation that errors are being correctly reported.
                    Crashlytics.instance.crash();
                  }),
              FlatButton(
                  child: const Text('Throw Error'),
                  onPressed: () {
                    // Example of thrown error, it will be caught and sent to
                    // Crashlytics.
                    throw StateError('Uncaught error thrown by app.');
                  }),
              FlatButton(
                  child: const Text('Async out of bounds'),
                  onPressed: () {
                    // Example of an exception that does not get caught
                    // by `FlutterError.onError` but is caught by the `onError` handler of
                    // `runZoned`.
                    Future<void>.delayed(const Duration(seconds: 2), () {
                      final List<int> list = <int>[];
                      print(list[100]);
                    });
                  }),
              FlatButton(
                  child: const Text('Record Error'),
                  onPressed: () {
                    try {
                      throw 'error_example';
                    } catch (e, s) {
                      print("$e = $s");
                      // "context" will append the word "thrown" in the
                      // Crashlytics console.
                      Crashlytics.instance
                          .recordError(e, s, context: 'as an example');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

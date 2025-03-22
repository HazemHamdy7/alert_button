<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Alert Button

**Alert Button** is a Flutter package that provides a customizable alert button with animated wave effects.

![Alert Button Demo](assets/alert_button_demo.png)

## Features

- Customizable button size.
- Customizable wave colors and gradients.
- Adjustable number of animated waves.
- Configurable durations for wave and press animations.
- Customizable main and sub labels with text styling.

<!-- ## Installation

1. Add the package to your project's `pubspec.yaml` file:

   ```yaml
   dependencies:
     alert_button:
       git:
         url: https://github.com/HazemHamdy7/alert_button
         ref: main -->

## Example Usage

Below is a simple example that demonstrates how to integrate the Alert Button into your Flutter app. Simply copy and paste this code into your project's main file to see the Alert Button in action:

```dart
import 'package:flutter/material.dart';
import 'package:alert_button/alert_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert Button Demo',
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AlertButton(
          size: 250, // Overall button size (width and height)
          waveColors: [Colors.blue, Colors.lightBlueAccent], // Wave gradient colors
          waveCount: 4, // Number of animated waves
          waveDuration: const Duration(seconds: 3), // Duration of the wave animation
          pressDuration: const Duration(milliseconds: 200), // Duration of the press animation
          activeDuration: const Duration(seconds: 4), // Duration for which the animation remains active after pressing
          label: 'HELP', // Main label text
          subLabel: 'Hold for 4 sec', // Sub-label text
          labelTextStyle: const TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          subLabelTextStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

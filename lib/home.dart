import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:technical_test/notification_services.dart';
import 'package:technical_test/repository/repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color backgroundColor = Colors.white;
  double turns = 0;
  bool isRandomActive = false;
  final player = AudioPlayer();
  bool isPlaying = false;
  int randomNumber = 0;
  static List<String> soundsUrls = [
    'https://actions.google.com/sounds/v1/alarms/alarm_clock.ogg',
    'https://actions.google.com/sounds/v1/alarms/dinner_bell_triangle.ogg',
    'https://actions.google.com/sounds/v1/alarms/mechanical_clock_ring.ogg',
    'https://actions.google.com/sounds/v1/alarms/phone_alerts_and_rings.ogg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: InkWell(
          onTap: () => changeBackground(),
          child: Center(
            child: AnimatedRotation(
              turns: turns,
              duration: const Duration(seconds: 1),
              child: const Text('Hello there'),
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isRandomActive,
        child: FloatingActionButton(
          onPressed: () => randomAction(),
          backgroundColor: Colors.blue,
          child: Icon(
            randomNumber % 3 == 0
                ? Icons.refresh
                : randomNumber % 3 == 1
                    ? Icons.music_note
                    : Icons.sentiment_very_satisfied,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  changeBackground() {
    setState(() => backgroundColor = randomColor());
    activeRandom();
  }

  activeRandom() {
    randomNumber = Random().nextInt(100);
    if (isPlaying) player.stop();
    setState(() {
      isRandomActive = Random().nextInt(2) == 1;
    });
  }

  randomAction() async {
    switch (randomNumber % 3) {
      case 0:
        setState(() => turns += 1);
        break;
      case 1:
        if (!isPlaying) {
          player.play(
            UrlSource(soundsUrls[Random().nextInt(soundsUrls.length)]),
          );
        } else {
          player.stop();
        }
        setState(() => isPlaying = !isPlaying);
        break;
      case 2:
        String joke = await Repository().getJoke();
        showNotification(
          'A Joke',
          joke,
        );
        break;
    }
  }

  static Color randomColor() {
    return Color(Random().nextInt(0xffffffff));
  }
}

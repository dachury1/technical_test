import 'package:flutter/material.dart';
import 'package:technical_test/home.dart';

import 'notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

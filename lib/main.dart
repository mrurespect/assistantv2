import 'package:flutter/material.dart';
import 'package:intelligentassistant/chat_screen.dart';
import 'package:intelligentassistant/homePage.dart';
import 'package:intelligentassistant/priereScreen.dart';
import 'package:intelligentassistant/weatherScreen.dart';

void main() {
  runApp(const MyApp());
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
      home: HomePage(),
      routes: {
        '/chatscreen': (context) => ChatScreen(),
        '/weatherpage': (context) => WeatherPage(),
        '/prierScreen': (context) => PriereScreen(),
      },
    );
  }
}

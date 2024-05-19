import 'package:flutter/material.dart';
import 'package:intelligentassistant/chat_screen.dart';
import 'package:intelligentassistant/homePage.dart';
import 'package:intelligentassistant/priereScreen.dart';
import 'package:intelligentassistant/tasks/presentation/screens/home_screen.dart';
import 'package:intelligentassistant/weatherScreen.dart';
import 'package:intelligentassistant/positionAndNearbyPlaces/position.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
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
        '/location': (context) => GetUserLocation(),
        '/prierScreen': (context) => PriereScreen(),
        '/todo': (context) => HomeScreen(),
      },
    );
  }
}

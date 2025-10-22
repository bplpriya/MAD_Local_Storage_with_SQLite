import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CardOrganizerApp());
}

class CardOrganizerApp extends StatelessWidget {
  const CardOrganizerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Organizer App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

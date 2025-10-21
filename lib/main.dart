import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FluffyFrills());
}

class FluffyFrills extends StatelessWidget {
  const FluffyFrills({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluffy Frills',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: false,
      ),
      // SplashScreen muncul pertama kali
      home: const SplashScreen(),
      routes: {
        
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

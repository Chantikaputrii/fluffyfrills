import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginpage.dart'; // file LoginPage kamu yang kompleks

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

// =================== SPLASH SCREEN ===================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Loading 3 detik sebelum pindah ke LoginPage
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4EC), Color(0xFFE1BEE7)], // pink pastel ke ungu pastel
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                "assets/logo_fashion.png",
                height: 150,
              ),
              const SizedBox(height: 20),

              // Teks utama dengan GoogleFonts.pinyonScript dan bayangan
              Text(
                "Fluffy Frills",
                textAlign: TextAlign.center,
                style: GoogleFonts.pinyonScript(
                  fontSize: 64,
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Nama pembuat, lebih kecil dan abu-abu
              Text(
                "- Chantika Putri Meunasah",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.normal,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
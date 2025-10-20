import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart';
import 'dasboardpage.dart';

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

    // ✅ Cek login status ketika splash dimulai
    _checkLoginStatus();
  }

  // 🔍 CEK STATUS LOGIN (Versi Final & Benar)
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();

    // Tampilkan splash dulu selama 3 detik
    await Future.delayed(const Duration(seconds: 3));

    // Setelah splash tampil → baru cek apakah user masih login
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (isLoggedIn) {
      // Ambil data user
      final userEmail = prefs.getString('savedEmail') ?? '';
      final userName = prefs.getString('savedUsername') ?? '';

      // Jika masih login → langsung ke dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardPage(
            userEmail: userEmail,
            userName: userName,
          ),
        ),
      );
    } else {
      // Jika belum login atau sudah logout → ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // =================== UI SPLASH ===================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4EC), Color(0xFFE1BEE7)], // pink pastel → ungu pastel
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

              // Judul Aplikasi
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

              // Nama Pembuat
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

              // Animasi Loading
              const SpinKitFadingCircle(
                color: Colors.pinkAccent,
                size: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

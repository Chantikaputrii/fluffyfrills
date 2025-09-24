import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/dasboardpage.dart'; // ganti sesuai nama file dashboardmu

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const SplashScreen(),
    );
  }
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4EC), Color(0xFFE1BEE7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo_fashion.png",
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "Fluffy Frills",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Fashion Trend Masa Kini",
                style: TextStyle(fontSize: 16, color: Colors.black54),
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

// =================== BUBBLE MODEL ===================
class Bubble {
  final Offset startPos;
  final double size;
  final List<Color> colors;
  final double speed;
  final double opacity;
  final double phase;
  final bool horizontal;

  Bubble(
    this.startPos,
    this.size,
    this.colors,
    this.speed,
    this.opacity,
    this.phase,
    this.horizontal,
  );
}

// =================== LOGIN PAGE ===================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _circleCtrl;
  final List<Bubble> _bubbles = [];
  final Random _rnd = Random();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _circleCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 12))
          ..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      for (int i = 0; i < 25; i++) {
        double dx = _rnd.nextDouble() * size.width;
        double dy = _rnd.nextDouble() * size.height;

        _bubbles.add(Bubble(
          Offset(dx, dy),
          20 + _rnd.nextDouble() * 40,
          [
            [const Color(0xFFE91E63), const Color(0xFF9C27B0)],
            [const Color(0xFFF06292), const Color(0xFFAB47BC)],
            [const Color(0xFFD81B60), const Color(0xFF8E24AA)],
          ][_rnd.nextInt(3)],
          5 + _rnd.nextDouble() * 8,
          0.7 + _rnd.nextDouble() * 0.3,
          _rnd.nextDouble() * 2 * pi,
          _rnd.nextBool(),
        ));
      }

      _bubbles.add(Bubble(
        const Offset(-100, -80),
        280,
        [const Color(0xFFF06292), const Color(0xFFBA68C8)],
        5,
        1.0,
        0,
        false,
      ));

      _bubbles.add(Bubble(
        Offset(size.width - 220, size.height - 220),
        260,
        [const Color(0xFFE91E63), const Color(0xFF9C27B0)],
        5,
        1.0,
        0,
        true,
      ));

      setState(() {});
    });
  }

  @override
  void dispose() {
    _circleCtrl.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCircle(double size, List<Color> colors, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors.map((c) => c.withOpacity(opacity)).toList(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  // =================== VALIDASI LOGIN ===================
  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // ✅ Cek email kosong
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password tidak boleh kosong')),
      );
      return;
    }

    // ✅ Validasi email harus pakai @gmail.com
    if (!email.endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email harus menggunakan @gmail.com')),
      );
      return;
    }

    // ✅ Validasi password minimal 8 karakter
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password minimal 8 karakter')),
      );
      return;
    }

    // ✅ Kalau lolos validasi → lanjut login
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => DashboardPage(
          userEmail: email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE4EC), Color(0xFFE1BEE7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // bubbles
          ..._bubbles.map((bubble) {
            return AnimatedBuilder(
              animation: _circleCtrl,
              builder: (context, child) {
                final progress = _circleCtrl.value * 2 * pi + bubble.phase;
                final dx = bubble.horizontal
                    ? bubble.startPos.dx + sin(progress) * bubble.speed
                    : bubble.startPos.dx;

                final dy = bubble.horizontal
                    ? bubble.startPos.dy
                    : bubble.startPos.dy + sin(progress) * bubble.speed;

                return Positioned(
                  left: dx,
                  top: dy,
                  child: _buildCircle(bubble.size, bubble.colors, bubble.opacity),
                );
              },
            );
          }).toList(),

          // login content
          Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      'assets/logo_fashion.png',
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    width: 360,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "User Login",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2)
                                : const Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Create Your Account",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.g_mobiledata,
                                size: 36, color: Colors.red),
                            SizedBox(width: 20),
                            Icon(Icons.camera_alt,
                                size: 30, color: Colors.purple),
                            SizedBox(width: 20),
                            Icon(Icons.facebook,
                                size: 30, color: Colors.blue),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Discover a collection of cute, unique, and comfortable clothing "
                        "designed to make you look stylish while feeling cozy all day. "
                        "From playful patterns to vibrant colors, our outfits let you "
                        "express your personality effortlessly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

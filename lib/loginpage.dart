import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dasboardpage.dart';
import 'registerpage.dart';

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

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _circleCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 12))
          ..repeat();
    _loadBubbles();
  }

  /// 🫧 Background animasi bubble
  void _loadBubbles() {
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
      setState(() {});
    });
  }

  /// 🔐 Fungsi login
  Future<void> _submit() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('savedUsername');
    final savedPassword = prefs.getString('savedPassword');
    final savedEmail = prefs.getString('savedEmail') ?? '';

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password tidak boleh kosong')),
      );
      return;
    }

    if (savedUsername == null || savedPassword == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belum ada akun terdaftar. Silakan daftar dulu.'),
        ),
      );
      return;
    }

    if (username != savedUsername || password != savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password salah')),
      );
      return;
    }

    // ✅ Simpan status login agar Splash tahu user login
    await prefs.setBool('isLoggedIn', true);

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);

    if (!mounted) return;
    
    // ✅ SUDAH BENAR - pushReplacement menghapus login dari stack
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => DashboardPage(
        userEmail: savedEmail,
        userName: username,
      ),
    ));
  }

  @override
  void dispose() {
    _circleCtrl.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌸 Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE4EC), Color(0xFFE1BEE7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🫧 Bubble animation
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

          // 🩰 Login form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo_fashion.png', height: 120),
                  const SizedBox(height: 20),
                  Container(
                    width: 360,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
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

                        // Username
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: "Username",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
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

                        // Tombol login
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
                        const SizedBox(height: 16),

                        // ✅ PERBAIKAN DI SINI - ke register
                        TextButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterPage()),
                            );

                            if (result == true && mounted) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final username =
                                  prefs.getString('savedUsername') ?? '';
                              final email =
                                  prefs.getString('savedEmail') ?? '';
                              await prefs.setBool('isLoggedIn', true);

                              // ✅ GANTI pushReplacement JADI pushAndRemoveUntil
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DashboardPage(
                                    userEmail: email,
                                    userName: username,
                                  ),
                                ),
                                (route) => false, // Hapus SEMUA halaman sebelumnya
                              );
                            }
                          },
                          child: const Text(
                            "Belum punya akun? Daftar di sini",
                            style: TextStyle(color: Colors.pinkAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🫧 Class Bubble
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
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfilPage({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              userName, // 🔥 ambil dari data login
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              userEmail, // 🔥 ambil dari data login
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

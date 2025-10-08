import 'package:flutter/material.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(leading: Icon(Icons.palette), title: Text("Tema")),
        Divider(),
        ListTile(leading: Icon(Icons.notifications), title: Text("Notifikasi")),
        Divider(),
        ListTile(
          leading: Icon(Icons.security),
          title: Text("Privasi & Keamanan"),
        ),
      ],
    );
  }
}

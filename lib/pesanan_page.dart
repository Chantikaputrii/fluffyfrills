import 'package:flutter/material.dart';

class PesananPage extends StatelessWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.receipt_long),
            title: Text("Pesanan #${index + 1001}"),
            subtitle: const Text("Status: Diproses"),
          ),
        );
      },
    );
  }
}

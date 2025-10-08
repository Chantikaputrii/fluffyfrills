import 'package:flutter/material.dart';
import 'dasboardpage.dart'; // supaya globalCart bisa dipakai

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Saya")),
      body: globalCart.isEmpty
          ? const Center(
              child: Text("Keranjang masih kosong 🛒"),
            )
          : ListView.builder(
              itemCount: globalCart.length,
              itemBuilder: (context, index) {
                final item = globalCart[index];
                return ListTile(
                  leading: Image.asset(
                    item['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['name']),
                  subtitle: Text("Rp${item['price']} | Ukuran: ${item['size']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        globalCart.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}

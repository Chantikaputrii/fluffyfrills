import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class PesananPage extends StatefulWidget {
  final String userName;
  final String userEmail;

  const PesananPage({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  List<Map<String, dynamic>> _orders = [];
  final currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final dateFormat = DateFormat('dd MMM yyyy, HH:mm'); // format timestamp

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final storedOrders = prefs.getStringList('orders') ?? [];

    final List<Map<String, dynamic>> decodedOrders = storedOrders.map((e) {
      final decoded = jsonDecode(e);
      return Map<String, dynamic>.from(decoded);
    }).toList();

    setState(() {
      _orders = decodedOrders.reversed.toList(); // terbaru di atas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7AA2),
        centerTitle: true,
        automaticallyImplyLeading: false, // Menghapus tombol back
        title: const Text(
          "Pesanan Saya 🧾",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _orders.isEmpty
          ? const Center(
              child: Text(
                "Belum ada pesanan 😢",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];

                // ambil timestamp
                final timestamp = order['timestamp'] != null
                    ? DateTime.parse(order['timestamp'])
                    : null;

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  child: ExpansionTile(
                    leading: const Icon(Icons.receipt_long,
                        color: Colors.pinkAccent),
                    title: Text(
                      "Pesanan #${order['id']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status: ${order['status'] ?? 'Diproses'}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                        if (timestamp != null)
                          Text(
                            "Tanggal: ${dateFormat.format(timestamp)}",
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 12),
                          ),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: const Text("Nama Penerima"),
                        subtitle: Text(order['nama'] ?? '-'),
                      ),
                      ListTile(
                        title: const Text("Alamat"),
                        subtitle: Text(order['alamat'] ?? '-'),
                      ),
                      ListTile(
                        title: const Text("Nomor HP"),
                        subtitle: Text(order['telepon'] ?? '-'),
                      ),
                      ListTile(
                        title: const Text("Metode Pembayaran"),
                        subtitle: Text(
                          order['metode'] == 'transfer'
                              ? "Transfer Bank"
                              : "COD (Bayar di Tempat)",
                        ),
                      ),
                      ListTile(
                        title: const Text("Total Pembayaran"),
                        subtitle: Text(
                          currencyFormat.format(order['total']),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent),
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Detail Barang:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      ...List<Map<String, dynamic>>.from(order['items'])
                          .map((item) => ListTile(
                                leading: Image.asset(
                                  item['image'],
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(item['name']),
                                subtitle: Text(
                                  "Ukuran: ${item['size'] ?? '-'} | Warna: ${item['color'] ?? '-'}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                trailing: Text(
                                  currencyFormat.format(item['price']),
                                  style: const TextStyle(
                                      color: Colors.pinkAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
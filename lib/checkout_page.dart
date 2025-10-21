import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final String userEmail;
  final String userName;

  const CheckoutPage({
    Key? key,
    required this.items,
    required this.totalPrice,
    required this.userEmail,
    required this.userName,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _paymentMethod = 'transfer';

  final currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
  }

  /// Simpan pesanan ke SharedPreferences
  Future<void> _saveOrder() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> existingOrders = prefs.getStringList('orders') ?? [];

    final orderData = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "nama": _nameController.text,
      "email": widget.userEmail,
      "alamat": _addressController.text,
      "telepon": _phoneController.text,
      "metode": _paymentMethod,
      "total": widget.totalPrice,
      "items": widget.items,
      "status": "Diproses",
      "tanggal": DateTime.now().toString(),
    };

    existingOrders.add(jsonEncode(orderData));
    await prefs.setStringList('orders', existingOrders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7AA2),
        title: const Text(
          "Isi Alamat & Pembayaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                "Detail Pengiriman",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama Penerima",
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? "Nama wajib diisi" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Alamat Lengkap",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (val) =>
                    val == null || val.isEmpty ? "Alamat wajib diisi" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Nomor HP",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.isEmpty ? "Nomor HP wajib diisi" : null,
              ),
              const SizedBox(height: 20),
              const Divider(),
              const Text(
                "Metode Pembayaran",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                value: 'transfer',
                groupValue: _paymentMethod,
                activeColor: const Color(0xFFFF7AA2),
                title: const Text("Transfer Bank"),
                subtitle: const Text("Bayar melalui transfer ke rekening toko"),
                onChanged: (value) => setState(() => _paymentMethod = value),
              ),
              RadioListTile<String>(
                value: 'cod',
                groupValue: _paymentMethod,
                activeColor: const Color(0xFFFF7AA2),
                title: const Text("COD (Bayar di Tempat)"),
                subtitle:
                    const Text("Bayar langsung ke kurir saat barang tiba"),
                onChanged: (value) => setState(() => _paymentMethod = value),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const Text(
                "Ringkasan Pesanan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...widget.items.map((item) => ListTile(
                    leading: Image.asset(item['image'], width: 50, height: 50),
                    title: Text(item['name']),
                    subtitle: Text(
                      "Ukuran: ${item['size'] ?? '-'} | Warna: ${item['color'] ?? '-'}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Text(
                      currencyFormat.format(item['price']),
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              const Divider(),
              ListTile(
                title: const Text(
                  "Total Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  currencyFormat.format(widget.totalPrice),
                  style: const TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7AA2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: const Text("Konfirmasi Pembayaran"),
                    content: Text(
                      "Metode: ${_paymentMethod == 'transfer' ? 'Transfer Bank' : 'COD'}\n"
                      "Total: ${currencyFormat.format(widget.totalPrice)}\n\n"
                      "Apakah Anda yakin ingin melanjutkan pembayaran?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Batal"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7AA2),
                        ),
                        onPressed: () async {
                          // Tutup dialog
                          Navigator.pop(context);
                          
                          // Simpan pesanan
                          await _saveOrder();

                          // ✅ PERBAIKAN: Pop dengan return true untuk memberitahu CartPage
                          Navigator.pop(context, true);

                          // Tampilkan snackbar di halaman sebelumnya (CartPage/DashboardPage)
                          // Note: Snackbar akan muncul di halaman yang ada di bawah CheckoutPage
                        },
                        child: const Text(
                          "Bayar Sekarang",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text(
              "💳 Bayar Sekarang",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
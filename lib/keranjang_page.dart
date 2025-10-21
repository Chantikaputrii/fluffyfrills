import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/checkout_page.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final String userEmail;
  final String userName;

  const CartPage({
    Key? key,
    required this.userEmail,
    required this.userName,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  // Simpan status pilihan item dan qty
  final Map<String, bool> selectedItems = {};
  final Map<String, int> itemQuantities = {};

  @override
  void initState() {
    super.initState();
    // Refresh setiap kali halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  // Gabungkan item yang sama
  List<Map<String, dynamic>> get groupedItems {
    final Map<String, Map<String, dynamic>> grouped = {};

    for (var item in Cart().items) {
      final key = '${item['name']}_${item['size']}_${item['color']}';
      
      if (grouped.containsKey(key)) {
        grouped[key]!['quantity'] = (grouped[key]!['quantity'] ?? 1) + 1;
      } else {
        grouped[key] = Map<String, dynamic>.from(item);
        grouped[key]!['quantity'] = 1;
        grouped[key]!['key'] = key;
      }
    }

    return grouped.values.toList();
  }

  double get totalPrice {
    double total = 0;
    for (var item in groupedItems) {
      final key = item['key'];
      if (selectedItems[key] ?? true) {
        final qty = itemQuantities[key] ?? item['quantity'];
        total += (item['price'] as num).toDouble() * qty;
      }
    }
    return total;
  }

  void _updateQuantity(String key, int change, Map<String, dynamic> item) {
    setState(() {
      final currentQty = itemQuantities[key] ?? item['quantity'];
      final newQty = currentQty + change;

      if (newQty > 0) {
        itemQuantities[key] = newQty;
      } else {
        // Hapus semua item dengan key ini
        _removeAllItemsByKey(key, item);
      }
    });
  }

  void _removeAllItemsByKey(String key, Map<String, dynamic> item) {
    // Hapus semua item yang cocok dari Cart
    final itemsToRemove = Cart().items.where((cartItem) {
      return '${cartItem['name']}_${cartItem['size']}_${cartItem['color']}' == key;
    }).toList();

    for (var itemToRemove in itemsToRemove) {
      Cart().removeItem(itemToRemove);
    }

    selectedItems.remove(key);
    itemQuantities.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = groupedItems;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7AA2),
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Keranjang 🛒",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            // Badge otomatis update
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${Cart().items.length}',
                style: const TextStyle(
                  color: Color(0xFFFF7AA2),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Keranjang masih kosong 💔",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final key = item['key'];
                selectedItems.putIfAbsent(key, () => true);
                final qty = itemQuantities[key] ?? item['quantity'];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade100.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Checkbox
                        Checkbox(
                          value: selectedItems[key],
                          activeColor: const Color(0xFFFF7AA2),
                          onChanged: (val) {
                            setState(() {
                              selectedItems[key] = val!;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item['image'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Item Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Ukuran: ${item['size'] ?? '-'} | Warna: ${item['color'] ?? '-'}",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    currencyFormat.format(item['price']),
                                    style: const TextStyle(
                                      color: Color(0xFF7A0045),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  // Qty Controls + Delete
                                  Row(
                                    children: [
                                      // Minus Button
                                      Material(
                                        color: const Color(0xFFFF7AA2),
                                        borderRadius: BorderRadius.circular(6),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(6),
                                          onTap: () => _updateQuantity(key, -1, item),
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '−',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Quantity
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color(0xFFFF7AA2),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          '$qty',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Plus Button
                                      Material(
                                        color: const Color(0xFFFF7AA2),
                                        borderRadius: BorderRadius.circular(6),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(6),
                                          onTap: () => _updateQuantity(key, 1, item),
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '+',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Delete Button
                                      Material(
                                        color: const Color(0xFFFF7AA2),
                                        borderRadius: BorderRadius.circular(6),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(6),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                  title: const Text(
                                                    "Hapus Produk?",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  content: Text(
                                                    "Apakah Anda yakin ingin menghapus ${item['name']} dari keranjang?",
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(context),
                                                      child: const Text(
                                                        "Batal",
                                                        style: TextStyle(color: Colors.grey),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.redAccent,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        setState(() {
                                                          _removeAllItemsByKey(key, item);
                                                        });
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              "${item['name']} dihapus dari keranjang",
                                                            ),
                                                            backgroundColor: Colors.redAccent,
                                                            duration: const Duration(seconds: 2),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        "Hapus",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '🗑️',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.08),
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          currencyFormat.format(totalPrice),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7A0045),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7AA2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          final itemsToBuy = <Map<String, dynamic>>[];
                          final itemsToRemove = <String>[]; // Track keys yang mau dihapus
                          
                          for (var item in cartItems) {
                            final key = item['key'];
                            if (selectedItems[key] ?? true) {
                              itemsToRemove.add(key); // Simpan key untuk dihapus nanti
                              final qty = itemQuantities[key] ?? item['quantity'];
                              // Tambahkan item sebanyak qty
                              for (int i = 0; i < qty; i++) {
                                itemsToBuy.add({
                                  'name': item['name'],
                                  'price': item['price'],
                                  'image': item['image'],
                                  'size': item['size'],
                                  'color': item['color'],
                                });
                              }
                            }
                          }

                          if (itemsToBuy.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Pilih minimal 1 item untuk dibeli!"),
                              ),
                            );
                            return;
                          }

                          // Navigate ke checkout dan tunggu hasilnya
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CheckoutPage(
                                items: itemsToBuy,
                                totalPrice: totalPrice,
                                userEmail: widget.userEmail,
                                userName: widget.userName,
                              ),
                            ),
                          );

                          // ✅ PERBAIKAN: Jika checkout berhasil, hapus item dari cart
                          if (result == true && mounted) {
                            setState(() {
                              // Hapus item yang sudah dibeli berdasarkan key yang disimpan
                              for (var key in itemsToRemove) {
                                // Cari item dengan key ini
                                final itemToRemove = cartItems.firstWhere(
                                  (item) => item['key'] == key,
                                  orElse: () => {},
                                );
                                
                                if (itemToRemove.isNotEmpty) {
                                  _removeAllItemsByKey(key, itemToRemove);
                                }
                              }
                            });

                            // Tampilkan notifikasi sukses
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('✅ Pesanan berhasil! Cek menu Pesanan'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "💳",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Bayar Sekarang",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
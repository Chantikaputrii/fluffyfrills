import 'package:flutter/material.dart';

/// ================== MODEL PRODUK AKSESORIS ==================
// Encapsulation: properti produk hanya bisa di-set melalui constructor
abstract class ProdukAksesoris {
  final String nama;
  final String gambar;
  final int harga;
  final String deskripsi;

  ProdukAksesoris(this.nama, this.gambar, this.harga, this.deskripsi);

  // Polymorphism: setiap subclass akan override method ini
  String getKategori();
}

// Inheritance: Topi mewarisi properti & method dari ProdukAksesoris
class Topi extends ProdukAksesoris {
  Topi(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Topi"; // Polymorphism
}

// Inheritance: Kacamata mewarisi properti & method dari ProdukAksesoris
class Kacamata extends ProdukAksesoris {
  Kacamata(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Kacamata"; // Polymorphism
}

// Inheritance: JamTangan mewarisi properti & method dari ProdukAksesoris
class JamTangan extends ProdukAksesoris {
  JamTangan(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Jam Tangan"; // Polymorphism
}

/// ================== DATA PRODUK AKSESORIS ==================
// Global list produk aksesoris (Encapsulation)
final List<ProdukAksesoris> semuaProdukAksesoris = [
  Topi("Topi Baseball", "assets/image/topi1.jpeg", 75000,
      "Topi baseball sporty cocok untuk sehari-hari."),
  Topi("Topi Snapback", "assets/image/topi2.jpeg", 85000,
      "Topi snapback keren untuk gaya kasual."),
  Topi("Topi Bucket", "assets/image/topi3.jpeg", 65000,
      "Topi bucket trendi cocok untuk outdoor."),
  Topi("Topi Fedora", "assets/image/topi4.jpeg", 120000,
      "Topi fedora elegan untuk tampilan stylish."),
  Kacamata("Kacamata Hitam", "assets/image/kacamata1.jpeg", 95000,
      "Kacamata hitam klasik untuk melindungi dari sinar matahari."),
  Kacamata("Kacamata Fashion", "assets/image/kacamata2.jpeg", 110000,
      "Kacamata stylish untuk menunjang gaya modern."),
  Kacamata("Kacamata Bening", "assets/image/kacamata3.jpeg", 100000,
      "Kacamata lensa bening cocok untuk gaya kasual."),
  Kacamata("Kacamata Bulat", "assets/image/kacamata4.jpeg", 105000,
      "Kacamata bulat retro untuk tampilan unik."),
  JamTangan("Jam Analog", "assets/image/jam1.jpeg", 250000,
      "Jam tangan analog klasik dan elegan."),
  JamTangan("Jam Digital", "assets/image/jam2.jpeg", 230000,
      "Jam digital sporty dengan fitur modern."),
  JamTangan("Jam Kulit", "assets/image/jam3.jpeg", 280000,
      "Jam tangan dengan tali kulit elegan."),
  JamTangan("Jam Fashion", "assets/image/jam4.jpeg", 300000,
      "Jam tangan stylish untuk menunjang penampilan."),
];

/// ================== HALAMAN PRODUK AKSESORIS ==================
class ProdukAksesorisPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart; // Encapsulation
  const ProdukAksesorisPage({Key? key, required this.onAddToCart})
      : super(key: key);

  @override
  State<ProdukAksesorisPage> createState() => _ProdukAksesorisPageState();
}

class _ProdukAksesorisPageState extends State<ProdukAksesorisPage> {
  final List<ProdukAksesoris> semuaProduk = semuaProdukAksesoris; // Encapsulation
  String query = ""; // Encapsulation
  List<Map<String, dynamic>> cartItems = []; // Encapsulation
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  /// ================== HAPUS ITEM DI CART ==================
  void _removeFromCart(int index) {
    final removedItem = cartItems[index];
    cartItems.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ListTile(
          leading: AspectRatio(
            aspectRatio: 1,
            child: Image.asset(removedItem['image'], fit: BoxFit.cover),
          ),
          title: Text(removedItem['name']),
          subtitle: Text(
              "Rp ${removedItem['price']} | Warna: ${removedItem['warna']}"),
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
    setState(() {});
  }

  /// ================== SHOW CART ==================
  void _showCart() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: cartItems.isEmpty
            ? const Center(child: Text("Keranjang masih kosong 🛒"))
            : AnimatedList(
                key: _listKey,
                initialItemCount: cartItems.length,
                itemBuilder: (context, index, animation) {
                  final item = cartItems[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      leading: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(item['image'], fit: BoxFit.cover),
                      ),
                      title: Text(item['name']),
                      subtitle: Text(
                          "Rp ${item['price']} | Warna: ${item['warna']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeFromCart(index),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  /// ================== DETAIL PRODUK ==================
  void _openDetail(ProdukAksesoris produk) {
    final List<String> warnaPilihan = [
      "Putih",
      "Cream",
      "Hitam",
      "Navy",
      "Maroon"
    ];
    String? selectedWarna;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateModal) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(produk.gambar,
                      height: 200, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                Text(produk.nama,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Rp ${produk.harga}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(produk.deskripsi),
                const SizedBox(height: 12),
                const Text("Pilih Warna:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 10,
                  children: warnaPilihan.map((w) {
                    final isSelected = selectedWarna == w;
                    return ChoiceChip(
                      label: Text(w),
                      selected: isSelected,
                      selectedColor: Colors.pinkAccent,
                      onSelected: (_) =>
                          setStateModal(() => selectedWarna = w), // Pilih warna
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text("Keranjang"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          if (selectedWarna != null) {
                            cartItems.add({
                              "name": produk.nama,
                              "price": produk.harga,
                              "image": produk.gambar,
                              "warna": selectedWarna!,
                              "kategori": produk.getKategori(), // Polymorphism
                            });
                            widget.onAddToCart(cartItems.last);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.payment),
                        label: const Text("Beli Sekarang"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent),
                        onPressed: () {
                          if (selectedWarna != null) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Beli ${produk.nama} berhasil 🚀")));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔎 Filter produk sesuai query search
    final produkFiltered = semuaProduk.where((p) {
      final lowerQuery = query.toLowerCase();
      return p.nama.toLowerCase().contains(lowerQuery) ||
          p.getKategori().toLowerCase().contains(lowerQuery) ||
          p.deskripsi.toLowerCase().contains(lowerQuery);
    }).toList();

    // Kelompokkan produk berdasarkan kategori
    Map<String, List<ProdukAksesoris>> kategoriMap = {};
    for (var p in produkFiltered) {
      kategoriMap.putIfAbsent(p.getKategori(), () => []).add(p); // Polymorphism
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 4.5; // Lebar tiap item

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Aksesoris"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                  icon: const Icon(Icons.shopping_cart), onPressed: _showCart),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Text('${cartItems.length}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 11)), // Jumlah item
                  ),
                )
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔎 Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari aksesoris...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => setState(() => query = val),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: kategoriMap.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(entry.key,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: itemWidth + 60,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: entry.value.map((produk) {
                            return GestureDetector(
                              onTap: () => _openDetail(produk),
                              child: Container(
                                width: itemWidth,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(produk.gambar,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(produk.nama,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    Text("Rp ${produk.harga}",
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

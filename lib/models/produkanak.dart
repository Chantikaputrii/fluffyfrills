import 'package:flutter/material.dart';

/// ================== MODEL PRODUK ==================
// Encapsulation: properti produk hanya bisa di-set melalui constructor
abstract class Produk {
  final String nama;
  final String gambar;
  final int harga;
  final String deskripsi;

  Produk(this.nama, this.gambar, this.harga, this.deskripsi);

  // Polymorphism: setiap subclass akan override method ini
  String getKategori();
}

// Inheritance: Sepatu mewarisi properti & method dari Produk
class Sepatu extends Produk {
  Sepatu(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Sepatu"; // Polymorphism
}

// Inheritance: Kemeja mewarisi properti & method dari Produk
class Kemeja extends Produk {
  Kemeja(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Kemeja"; // Polymorphism
}

// Inheritance: Dress mewarisi properti & method dari Produk
class Dress extends Produk {
  Dress(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Dress"; // Polymorphism
}

// Inheritance: T-shirt mewarisi properti & method dari Produk
class Tshirt extends Produk {
  Tshirt(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "T-Shirt"; // Polymorphism
}

// Inheritance: Skirt mewarisi properti & method dari Produk
class Skirt extends Produk {
  Skirt(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Skirt"; // Polymorphism
}

// Inheritance: Celana mewarisi properti & method dari Produk
class Celana extends Produk {
  Celana(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Celana"; // Polymorphism
}

/// ================== DATA PRODUK ANAK ==================
// Global list produk anak (Encapsulation)
final List<Produk> semuaProdukAnak = [
  Sepatu("Sepatu Sport Anak", "assets/image/sepatuanak1.jpeg", 200000,
      "Sepatu sport ringan untuk olahraga anak."),
  Sepatu("Sepatu Casual Anak", "assets/image/sepatuanak2.jpeg", 180000,
      "Sepatu casual nyaman dipakai sehari-hari."),
  Sepatu("Sepatu Sekolah", "assets/image/sepatuanak3.jpeg", 190000,
      "Sepatu hitam formal untuk keperluan sekolah."),
  Sepatu("Sepatu Sneaker Anak", "assets/image/sepatuanak4.jpeg", 210000,
      "Sneaker trendy untuk gaya kasual anak."),
  Kemeja("Kemeja Kotak", "assets/image/kemejanak1.jpeg", 120000,
      "Kemeja motif kotak trendi untuk anak laki-laki."),
  Kemeja("Kemeja Denim", "assets/image/kemejanak2.jpeg", 150000,
      "Kemeja denim kasual yang stylish."),
  Kemeja("Kemeja Putih", "assets/image/kemejanak3.jpeg", 110000,
      "Kemeja putih simple untuk acara formal."),
  Kemeja("Kemeja Batik Anak", "assets/image/kemejanak4.jpeg", 140000,
      "Kemeja batik khas budaya Indonesia untuk anak."),
  Dress("Dress Bunga", "assets/image/dressanak1.jpeg", 150000,
      "Dress motif bunga cantik untuk anak perempuan."),
  Dress("Dress Pesta", "assets/image/dressanak2.jpeg", 200000,
      "Dress pesta elegan cocok untuk acara spesial."),
  Dress("Dress Kasual", "assets/image/dressanak3.jpeg", 130000,
      "Dress kasual ringan dan nyaman dipakai sehari-hari."),
  Dress("Dress Pink", "assets/image/dressanak4.jpeg", 160000,
      "Dress warna pink lembut yang manis untuk si kecil."),
  Dress("Dress Princess", "assets/image/dressanak5.jpeg", 250000,
      "Dress ala princess yang indah dan mewah."),
  Tshirt("T-Shirt Kartun", "assets/image/tshirtanak1.jpeg", 80000,
      "Kaos bergambar kartun lucu untuk anak."),
  Tshirt("T-Shirt Polos", "assets/image/tshirtanak2.jpeg", 60000,
      "Kaos polos nyaman untuk aktivitas sehari-hari."),
  Tshirt("T-Shirt Sport", "assets/image/tshirtanak3.jpeg", 90000,
      "Kaos sporty yang cocok untuk bermain."),
  Tshirt("T-Shirt Warna-warni", "assets/image/tshirtanak4.jpeg", 95000,
      "Kaos warna cerah yang ceria untuk anak-anak."),
  Skirt("Skirt Polkadot", "assets/image/skirtanak1.jpeg", 100000,
      "Rok polkadot lucu untuk gaya kasual anak."),
  Skirt("Skirt Denim", "assets/image/skirtanak2.jpeg", 130000,
      "Rok denim trendy dan nyaman dipakai."),
  Skirt("Skirt Pink", "assets/image/skirtanak3.jpeg", 120000,
      "Rok pink manis cocok untuk acara santai."),
  Skirt("Skirt Bunga", "assets/image/skirtanak4.jpeg", 125000,
      "Rok motif bunga ceria untuk si kecil."),
  Celana("Celana Pendek", "assets/image/celanaanak1.jpeg", 85000,
      "Celana pendek nyaman untuk bermain."),
  Celana("Celana Jeans", "assets/image/celanaanak2.jpeg", 150000,
      "Celana jeans keren untuk gaya kasual anak."),
  Celana("Celana Jogger", "assets/image/celanaanak3.jpeg", 120000,
      "Celana jogger sporty dan nyaman dipakai."),
  Celana("Celana Panjang", "assets/image/celanaanak4.jpeg", 130000,
      "Celana panjang simple untuk kegiatan sehari-hari."),
];

/// ================== HALAMAN PRODUK ANAK ==================
class ProdukAnakPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart; // Encapsulation

  const ProdukAnakPage({Key? key, required this.onAddToCart}) : super(key: key);

  @override
  State<ProdukAnakPage> createState() => _ProdukAnakPageState();
}

class _ProdukAnakPageState extends State<ProdukAnakPage> {
  List<Produk> semuaProduk = semuaProdukAnak; // Encapsulation
  String query = ""; // Encapsulation

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> cartItems = []; // Encapsulation
  String? selectedSize; // Encapsulation

  /// ================== DETAIL PRODUK ==================
  void _openDetail(Produk produk) {
    List<String> sizes;
    switch (produk.getKategori()) { // Polymorphism
      case "Sepatu":
        sizes = ["28", "29", "30", "31"];
        break;
      case "Kemeja":
      case "T-Shirt":
      case "Dress":
      case "Skirt":
        sizes = ["S", "M", "L", "XL"];
        break;
      case "Celana":
        sizes = ["28", "29", "30", "31"];
        break;
      default:
        sizes = [];
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String? localSize = selectedSize;
        return StatefulBuilder(
          builder: (context, setStateModal) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(produk.gambar, fit: BoxFit.cover), // Encapsulation
                  ),
                ),
                const SizedBox(height: 12),
                Text(produk.nama,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)), // Encapsulation
                Text("Rp ${produk.harga}"), // Encapsulation
                const SizedBox(height: 10),
                Text(produk.deskripsi), // Encapsulation
                if (sizes.isNotEmpty)
                  DropdownButton<String>(
                    value: localSize,
                    hint: const Text("Pilih Ukuran"),
                    items: sizes
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) => setStateModal(() => localSize = val),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        setState(() {
                          cartItems.add({
                            "name": produk.nama,
                            "price": produk.harga,
                            "image": produk.gambar,
                            "category": produk.getKategori(), // Polymorphism
                            "size": localSize ?? "-",
                          });
                        });
                        widget.onAddToCart({
                          "name": produk.nama,
                          "price": produk.harga,
                          "image": produk.gambar,
                          "category": produk.getKategori(), // Polymorphism
                          "size": localSize ?? "-",
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Keranjang",
                          style: TextStyle(color: Colors.black)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Beli ${produk.nama} berhasil 🚀")), // Encapsulation
                        );
                      },
                      child: const Text("Beli Sekarang"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// ================== HAPUS ITEM DI CART ==================
  void _removeFromCart(int index) {
    final removedItem = cartItems[index];
    cartItems.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        child: ListTile(
          leading: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(removedItem['image'], fit: BoxFit.cover)),
          title: Text(removedItem['name']),
          subtitle:
              Text("Rp ${removedItem['price']} | Ukuran: ${removedItem['size']}"),
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
                    axis: Axis.vertical,
                    child: ListTile(
                      leading: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(item['image'], fit: BoxFit.cover)),
                      title: Text(item['name']),
                      subtitle: Text(
                          "Rp ${item['price']} | Ukuran: ${item['size']}"),
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

  /// ================== BUILD UI ==================
  @override
  Widget build(BuildContext context) {
    // 🔎 Filter produk berdasarkan query search
    final produkFiltered = semuaProduk.where((p) {
      final lowerQuery = query.toLowerCase();
      return p.nama.toLowerCase().contains(lowerQuery) ||
          p.getKategori().toLowerCase().contains(lowerQuery) ||
          p.deskripsi.toLowerCase().contains(lowerQuery);
    }).toList();

    // Kelompokkan produk berdasarkan kategori
    Map<String, List<Produk>> kategoriMap = {};
    for (var p in produkFiltered) {
      kategoriMap.putIfAbsent(p.getKategori(), () => []).add(p); // Polymorphism
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Anak"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _showCart,
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    constraints:
                        const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
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
                hintText: "Cari produk anak...",
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
                        padding: const EdgeInsets.all(12.0),
                        child: Text(entry.key,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: itemWidth + 60,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: entry.value.map((produk) {
                              return GestureDetector(
                                onTap: () => _openDetail(produk),
                                child: Container(
                                  width: itemWidth,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 2),
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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

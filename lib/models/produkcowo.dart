import 'package:flutter/material.dart';

/// ================== MODEL PRODUK ==================
abstract class Produk {
  // Encapsulation: properti dibungkus dalam class dan hanya bisa di-set lewat constructor
  final String nama;
  final String gambar;
  final int harga;
  final String deskripsi;

  // Encapsulation: constructor membungkus inisialisasi properti
  Produk(this.nama, this.gambar, this.harga, this.deskripsi);

  // Polymorphism: method abstrak yang akan di-override oleh subclass
  String getKategori();
}

// Inheritance: Sepatu mewarisi properti & method dari Produk
class Sepatu extends Produk {
  Sepatu(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Sepatu"; // Polymorphism: override method getKategori
}

// Inheritance: Kemeja mewarisi properti & method dari Produk
class Kemeja extends Produk {
  Kemeja(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Kemeja"; // Polymorphism
}

// Inheritance: Tshirt mewarisi properti & method dari Produk
class Tshirt extends Produk {
  Tshirt(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "T-Shirt"; // Polymorphism
}

// Inheritance: Celana mewarisi properti & method dari Produk
class Celana extends Produk {
  Celana(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);

  @override
  String getKategori() => "Celana"; // Polymorphism
}

/// ================== DATA PRODUK COWO ==================
final List<Produk> semuaProdukCowo = [
  Sepatu("Sepatu Cowo 1", "assets/image/sepatucowo1.jpeg", 350000,
      "Sepatu keren untuk aktivitas harian."),
  Sepatu("Sepatu Cowo 2", "assets/image/sepatucowo2.jpeg", 420000,
      "Sepatu sporty nyaman dipakai."),
  Sepatu("Sepatu Cowo 3", "assets/image/sepatucowo3.jpeg", 390000,
      "Sepatu casual trendi."),
  Sepatu("Sepatu Cowo 4", "assets/image/sepatucowo4.jpeg", 450000,
      "Sepatu kulit elegan."),
  Sepatu("Sepatu Cowo 5", "assets/image/sepatucowo5.jpeg", 480000,
      "Sepatu premium kualitas tinggi."),
  Kemeja("Kemeja Cowo 1", "assets/image/kemejacowo1.jpeg", 220000,
      "Kemeja formal elegan."),
  Kemeja("Kemeja Cowo 2", "assets/image/kemejacowo2.jpeg", 200000,
      "Kemeja santai untuk aktivitas harian."),
  Kemeja("Kemeja Cowo 3", "assets/image/kemejacowo3.jpeg", 210000,
      "Kemeja motif modern."),
  Kemeja("Kemeja Cowo 4", "assets/image/kemejacowo4.jpeg", 240000,
      "Kemeja slim fit."),
  Kemeja("Kemeja Cowo 5", "assets/image/kemejacowo5.jpeg", 230000,
      "Kemeja casual stylish."),
  Tshirt("T-Shirt Cowo 1", "assets/image/tshirtcowo1.jpeg", 120000,
      "Kaos casual bahan lembut."),
  Tshirt("T-Shirt Cowo 2", "assets/image/tshirtcowo2.jpeg", 110000,
      "Kaos simple cocok untuk sehari-hari."),
  Tshirt("T-Shirt Cowo 3", "assets/image/tshirtcowo3.jpeg", 115000,
      "Kaos trendy desain unik."),
  Tshirt("T-Shirt Cowo 4", "assets/image/tshirtcowo4.jpeg", 130000,
      "Kaos sporty breathable."),
  Tshirt("T-Shirt Cowo 5", "assets/image/tshirtcowo5.jpeg", 125000,
      "Kaos nyaman kualitas tinggi."),
  Celana("Celana Cowo 1", "assets/image/celanacowo1.jpeg", 180000,
      "Celana jeans slimfit."),
  Celana("Celana Cowo 2", "assets/image/celanacowo2.jpeg", 175000,
      "Celana bahan stretch nyaman."),
  Celana("Celana Cowo 3", "assets/image/celanacowo3.jpeg", 185000,
      "Celana chino modern."),
  Celana("Celana Cowo 4", "assets/image/celanacowo4.jpeg", 190000,
      "Celana santai stylish."),
];

/// ================== HALAMAN PRODUK COWO ==================
class ProdukCowoPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart; // Encapsulation: properti dikontrol lewat widget
  final String searchQuery; // Encapsulation

  const ProdukCowoPage({
    Key? key,
    required this.onAddToCart,
    this.searchQuery = "",
  }) : super(key: key);

  @override
  State<ProdukCowoPage> createState() => _ProdukCowoPageState();
}

class _ProdukCowoPageState extends State<ProdukCowoPage> {
  late List<Produk> semuaProduk; // Encapsulation: data produk dikontrol oleh state

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>(); // Encapsulation
  List<Map<String, dynamic>> cartItems = []; // Encapsulation
  String? selectedSize; // Encapsulation

  @override
  void initState() {
    super.initState();
    _applyFilter();
  }

  @override
  void didUpdateWidget(covariant ProdukCowoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() => _applyFilter());
    }
  }

  void _applyFilter() {
    semuaProduk = semuaProdukCowo
        .where((p) =>
            p.nama.toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();
  }

  /// ========== DETAIL PRODUK ==========
  void _openDetail(Produk produk) {
    List<String> sizes;
    switch (produk.getKategori()) { // Polymorphism: hasil tergantung subclass produk
      case "Sepatu":
        sizes = ["40", "41", "42", "43"];
        break;
      case "Kemeja":
      case "T-Shirt":
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
                    child: Image.asset(produk.gambar, fit: BoxFit.cover), // Encapsulation: akses properti produk
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
                        backgroundColor: Colors.amber,
                      ),
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
                      child: const Text(
                        "Keranjang",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Beli ${produk.nama} berhasil 🚀")), // Encapsulation
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

  /// ========== HAPUS ITEM DI KERANJANG ==========
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

  /// ========== SHOW CART ==========
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

  /// ========== BUILD UI ==========
  @override
  Widget build(BuildContext context) {
    Map<String, List<Produk>> kategoriMap = {};
    for (var p in semuaProduk) {
      kategoriMap.putIfAbsent(p.getKategori(), () => []).add(p); // Polymorphism
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 5; // tampil 5 produk per layar

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Cowo"),
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
      body: SingleChildScrollView(
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
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(produk.gambar,
                                        fit: BoxFit.cover), // Encapsulation
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  produk.nama, // Encapsulation
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Rp ${produk.harga}", // Encapsulation
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
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
    );
  }
}

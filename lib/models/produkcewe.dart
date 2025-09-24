import 'package:flutter/material.dart';

/// ================== MODEL PRODUK ==================
abstract class Produk {
  final String nama;
  final String gambar;
  final int harga;
  final String deskripsi;

  Produk(this.nama, this.gambar, this.harga, this.deskripsi);

  String getKategori();
}

class Sepatu extends Produk {
  Sepatu(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);
  @override
  String getKategori() => "Sepatu";
}

class Kemeja extends Produk {
  Kemeja(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);
  @override
  String getKategori() => "Kemeja";
}

class Tshirt extends Produk {
  Tshirt(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);
  @override
  String getKategori() => "T-Shirt";
}

class Dress extends Produk {
  Dress(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);
  @override
  String getKategori() => "Dress";
}

class Skirt extends Produk {
  Skirt(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);
  @override
  String getKategori() => "Skirt";
}

class Celana extends Produk {
  Celana(String nama, String gambar, int harga, String deskripsi)
      : super(nama, gambar, harga, deskripsi);
  @override
  String getKategori() => "Celana";
}

/// ================== DATA PRODUK CEWE ==================
final List<Produk> semuaProdukCewe = [
  // Sepatu
  Sepatu("Sepatu Heels", "assets/image/sepatucewe1.jpeg", 400000,
      "Heels elegan untuk acara formal."),
  Sepatu("Sepatu Flat", "assets/image/sepatucewe2.jpeg", 250000,
      "Sepatu flat nyaman dipakai sehari-hari."),
  Sepatu("Sepatu Sport", "assets/image/sepatucewe3.jpeg", 350000,
      "Sepatu sport ringan cocok untuk olahraga."),
  Sepatu("Sepatu Sneaker", "assets/image/sepatucewe4.jpeg", 320000,
      "Sneaker trendy cocok untuk casual."),
  Sepatu("Sepatu Boots", "assets/image/sepatucewe5.jpeg", 500000,
      "Sepatu boots stylish dan modern."),
  // Kemeja
  Kemeja("Kemeja Putih", "assets/image/kemejacewe1.jpeg", 180000,
      "Kemeja putih simple untuk formal maupun casual."),
  Kemeja("Kemeja Hitam", "assets/image/kemejacewe2.jpeg", 190000,
      "Kemeja hitam elegan dan serbaguna."),
  Kemeja("Kemeja Polkadot", "assets/image/kemejacewe3.jpeg", 200000,
      "Kemeja polkadot lucu dan feminin."),
  Kemeja("Kemeja Flanel", "assets/image/kemejacewe4.jpeg", 210000,
      "Kemeja flanel hangat cocok untuk santai."),
  Kemeja("Kemeja Batik", "assets/image/kemejacewe5.jpeg", 250000,
      "Kemeja batik khas budaya Indonesia."),
  // Dress
  Dress("Dress Merah", "assets/image/dress1.jpeg", 300000,
      "Dress merah elegan untuk pesta."),
  Dress("Dress Hitam", "assets/image/dress2.jpeg", 320000,
      "Dress hitam simpel tapi classy."),
  Dress("Dress Bunga", "assets/image/dress3.jpeg", 280000,
      "Dress motif bunga segar dan feminin."),
  Dress("Dress Pink", "assets/image/dress4.jpeg", 310000,
      "Dress pink manis untuk acara casual."),
  Dress("Dress Putih", "assets/image/dress5.jpeg", 350000,
      "Dress putih simple cocok untuk formal."),
  // T-Shirt
  Tshirt("T-Shirt Putih", "assets/image/tshirtcewe1.jpeg", 120000,
      "T-Shirt putih simple untuk sehari-hari."),
  Tshirt("T-Shirt Hitam", "assets/image/tshirtcewe2.jpeg", 125000,
      "T-Shirt hitam elegan dan kasual."),
  Tshirt("T-Shirt Oversize", "assets/image/tshirtcewe3.jpeg", 140000,
      "T-Shirt oversize trendy dan nyaman."),
  Tshirt("T-Shirt Crop", "assets/image/tshirtcewe4.jpeg", 150000,
      "Crop tee modis untuk tampilan kekinian."),
  Tshirt("T-Shirt Motif", "assets/image/tshirtcewe5.jpeg", 160000,
      "T-Shirt motif stylish dan modern."),
  // Skirt
  Skirt("Rok Mini", "assets/image/skirtcewe1.jpeg", 170000,
      "Rok mini feminim untuk casual."),
  Skirt("Rok Plisket", "assets/image/skirtcewe2.jpeg", 180000,
      "Rok plisket trendy dan nyaman."),
  Skirt("Rok Maxi", "assets/image/skirtcewe3.jpeg", 190000,
      "Rok maxi elegan dan sopan."),
  // Celana
  Celana("Celana Jeans", "assets/image/celanacewe1.jpeg", 200000,
      "Celana jeans nyaman dipakai sehari-hari."),
  Celana("Celana Kulot", "assets/image/celanacewe2.jpeg", 210000,
      "Celana kulot lebar cocok untuk casual."),
  Celana("Celana Legging", "assets/image/celanacewe3.jpeg", 150000,
      "Celana legging elastis nyaman untuk olahraga."),
  Celana("Celana Formal", "assets/image/celanacewe4.jpeg", 220000,
      "Celana panjang formal untuk kantor."),
];

/// ================== HALAMAN PRODUK CEWE ==================
class ProdukCewePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  final String searchQuery;

  const ProdukCewePage({
    Key? key,
    required this.onAddToCart,
    this.searchQuery = "",
  }) : super(key: key);

  @override
  State<ProdukCewePage> createState() => _ProdukCewePageState();
}

class _ProdukCewePageState extends State<ProdukCewePage> {
  late List<Produk> semuaProduk;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> cartItems = [];
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    _applyFilter();
  }

  @override
  void didUpdateWidget(covariant ProdukCewePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() => _applyFilter());
    }
  }

  void _applyFilter() {
    semuaProduk = semuaProdukCewe
        .where((p) =>
            p.nama.toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();
  }

  /// ================== DETAIL PRODUK ==================
  void _openDetail(Produk produk) {
    List<String> sizes;
    switch (produk.getKategori()) {
      case "Sepatu":
        sizes = ["36", "37", "38", "39", "40"];
        break;
      case "Kemeja":
      case "T-Shirt":
      case "Dress":
        sizes = ["S", "M", "L", "XL"];
        break;
      case "Skirt":
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
                    child: Image.asset(produk.gambar, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 12),
                Text(produk.nama,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Rp ${produk.harga}"),
                const SizedBox(height: 10),
                Text(produk.deskripsi),
                if (sizes.isNotEmpty)
                  DropdownButton<String>(
                    value: localSize,
                    hint: const Text("Pilih Ukuran"),
                    items: sizes
                        .map((s) =>
                            DropdownMenuItem(value: s, child: Text(s)))
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
                            "category": produk.getKategori(),
                            "size": localSize ?? "-",
                          });
                        });
                        widget.onAddToCart({
                          "name": produk.nama,
                          "price": produk.harga,
                          "image": produk.gambar,
                          "category": produk.getKategori(),
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
                                  Text("Beli ${produk.nama} berhasil 🚀")),
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
    Map<String, List<Produk>> kategoriMap = {};
    for (var p in semuaProduk) {
      kategoriMap.putIfAbsent(p.getKategori(), () => []).add(p);
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Cewe"),
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
    );
  }
}

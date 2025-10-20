import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:getwidget/getwidget.dart';
import '/models/produk.dart';
import '/widget/detail_produk.dart';
import '../cart.dart';

// ================== MODEL PRODUK AKSESORIS ==================
class ProdukAksesoris extends Produk {
  final String kategori;
  final double rating;
  final int terjual;

  ProdukAksesoris(
    String nama,
    String gambar,
    int harga,
    this.kategori, {
    required String deskripsi,
    this.rating = 5.0,
    this.terjual = 100,
  }) : super(
          nama: nama,
          gambar: gambar,
          harga: harga,
          deskripsi: deskripsi,
        );

  @override
  String getKategori() => "Aksesoris";

  @override
  String getInfo() => "$kategori: $nama - Rp$harga";
}

// ================== DATA PRODUK AKSESORIS ==================
final List<ProdukAksesoris> semuaProdukAksesoris = [
  // 🧢 TOPI
  ProdukAksesoris(
    "Topi Baseball",
    "assets/image/topi1.jpeg",
    75000,
    "Topi",
    deskripsi: "Topi baseball sporty cocok untuk sehari-hari.",
    rating: 4.7,
    terjual: 120,
  ),
  ProdukAksesoris(
    "Topi Snapback",
    "assets/image/topi2.jpeg",
    85000,
    "Topi",
    deskripsi: "Topi snapback keren untuk gaya kasual.",
    rating: 4.5,
    terjual: 95,
  ),
  ProdukAksesoris(
    "Topi Bucket",
    "assets/image/topi3.jpeg",
    65000,
    "Topi",
    deskripsi: "Topi bucket trendi cocok untuk outdoor.",
    rating: 4.6,
    terjual: 80,
  ),
  ProdukAksesoris(
    "Topi Fedora",
    "assets/image/topi4.jpeg",
    120000,
    "Topi",
    deskripsi: "Topi fedora elegan untuk tampilan stylish.",
    rating: 4.8,
    terjual: 60,
  ),

  // 🕶️ KACAMATA
  ProdukAksesoris(
    "Kacamata Hitam",
    "assets/image/kacamata1.jpeg",
    95000,
    "Kacamata",
    deskripsi:
        "Kacamata hitam klasik untuk melindungi dari sinar matahari.",
    rating: 4.7,
    terjual: 110,
  ),
  ProdukAksesoris(
    "Kacamata Fashion",
    "assets/image/kacamata2.jpeg",
    110000,
    "Kacamata",
    deskripsi: "Kacamata stylish untuk menunjang gaya modern.",
    rating: 4.8,
    terjual: 90,
  ),
  ProdukAksesoris(
    "Kacamata Bening",
    "assets/image/kacamata3.jpeg",
    100000,
    "Kacamata",
    deskripsi: "Kacamata lensa bening cocok untuk gaya kasual.",
    rating: 4.5,
    terjual: 75,
  ),
  ProdukAksesoris(
    "Kacamata Bulat",
    "assets/image/kacamata4.jpeg",
    105000,
    "Kacamata",
    deskripsi: "Kacamata bulat retro untuk tampilan unik.",
    rating: 4.6,
    terjual: 80,
  ),

  // ⌚ JAM TANGAN
  ProdukAksesoris(
    "Jam Analog",
    "assets/image/jam1.jpeg",
    250000,
    "Jam Tangan",
    deskripsi: "Jam tangan analog klasik dan elegan.",
    rating: 4.8,
    terjual: 70,
  ),
  ProdukAksesoris(
    "Jam Digital",
    "assets/image/jam2.jpeg",
    230000,
    "Jam Tangan",
    deskripsi: "Jam digital sporty dengan fitur modern.",
    rating: 4.7,
    terjual: 60,
  ),
  ProdukAksesoris(
    "Jam Kulit",
    "assets/image/jam3.jpeg",
    280000,
    "Jam Tangan",
    deskripsi: "Jam tangan dengan tali kulit elegan.",
    rating: 4.9,
    terjual: 50,
  ),
  ProdukAksesoris(
    "Jam Fashion",
    "assets/image/jam4.jpeg",
    300000,
    "Jam Tangan",
    deskripsi: "Jam tangan stylish untuk menunjang penampilan.",
    rating: 4.8,
    terjual: 65,
  ),
];

// ================== HALAMAN PRODUK AKSESORIS ==================
class ProdukAksesorisPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  const ProdukAksesorisPage({Key? key, required this.onAddToCart})
      : super(key: key);

  List<String> getKategoriUnik() =>
      semuaProdukAksesoris.map((p) => p.kategori).toSet().toList();

  String formatHarga(int harga) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(harga);
  }

  Widget _buildGridKategori(
      BuildContext context, String kategori, List<ProdukAksesoris> produkList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            kategori,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemCount: produkList.length,
          itemBuilder: (context, index) {
            final produk = produkList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailProdukPage(
                      produk: produk,
                      onAddToCart: (cartItem) {
                        Cart().addItem(cartItem);
                      },
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          produk.gambar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        produk.nama,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        formatHarga(produk.harga),
                        style: const TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: RatingStars(
                        value: produk.rating,
                        starCount: 5,
                        starSize: 18,
                        starColor: Colors.amber,
                        valueLabelVisibility: false,
                        maxValue: 5,
                        starSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Center(
                      child: Text(
                        produk.rating.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "${produk.terjual}+ Terjual",
                      style:
                          const TextStyle(fontSize: 10, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GFButton(
                        onPressed: () {
                          Cart().addItem({
                            "name": produk.nama,
                            "price": produk.harga,
                            "image": produk.gambar,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "${produk.nama} ditambahkan ke keranjang!"),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        text: "Tambah",
                        color: Colors.pinkAccent,
                        fullWidthButton: true,
                        size: GFSize.SMALL,
                        shape: GFButtonShape.pills,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final kategoriList = getKategoriUnik();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Aksesoris 💍"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/keranjang');
            },
          ),
        ],
      ),
      body: ListView(
        children: kategoriList.map((kategori) {
          final produkPerKategori =
              semuaProdukAksesoris.where((p) => p.kategori == kategori).toList();
          return _buildGridKategori(context, kategori, produkPerKategori);
        }).toList(),
      ),
    );
  }
}
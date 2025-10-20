import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:getwidget/getwidget.dart';
import '/models/produk.dart';
import '/widget/detail_produk.dart';
import '../cart.dart'; // <- import Cart singleton

// ================== MODEL PRODUK CEWE ==================
class ProdukCewe extends Produk {
  final String kategori;
  final double rating;
  final int terjual;

  ProdukCewe(
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
  String getKategori() => "Cewe";

  @override
  String getInfo() => "$kategori: $nama - Rp$harga";
}

// ================== DATA PRODUK CEWE ==================
final List<ProdukCewe> semuaProdukCewe = [
  // 👠 SEPATU
  ProdukCewe(
    "Sepatu Elegant Heels",
    "assets/image/sepatucewe1.jpeg",
    420000,
    "Sepatu",
    deskripsi:
        "Sepatu hak tinggi elegan yang dibuat dari bahan sintetis premium. Memiliki sol yang nyaman dan stabil untuk dipakai seharian, cocok untuk acara formal, pesta, atau dinner. Desainnya klasik dengan sentuhan modern sehingga tetap stylish dan memberikan kesan anggun pada kaki Anda.",
    rating: 4.8,
    terjual: 180,
  ),
  ProdukCewe(
    "Sepatu Casual Flat Shoes",
    "assets/image/sepatucewe2.jpeg",
    280000,
    "Sepatu",
    deskripsi:
        "Flat shoes dengan desain simpel dan modern, sangat nyaman untuk digunakan sehari-hari. Terbuat dari bahan lembut dan ringan, cocok untuk berjalan-jalan, kerja, maupun aktivitas santai. Mudah dipadukan dengan berbagai jenis outfit kasual.",
    rating: 4.7,
    terjual: 150,
  ),
  ProdukCewe(
    "Sepatu Running Sneakers",
    "assets/image/sepatucewe3.jpeg",
    350000,
    "Sepatu",
    deskripsi:
        "Sneakers sporty yang ringan dan fleksibel, dirancang untuk aktivitas olahraga maupun casual wear. Memiliki bantalan yang empuk untuk menopang kaki saat lari atau jogging. Sol anti-slip membuatnya aman digunakan di berbagai permukaan.",
    rating: 4.9,
    terjual: 120,
  ),
  ProdukCewe(
    "Sepatu White Platform Shoes",
    "assets/image/sepatucewe4.jpeg",
    320000,
    "Sepatu",
    deskripsi:
        "Sepatu platform berwarna putih dengan desain trendy dan stylish. Memberikan tambahan tinggi dan bentuk kaki yang proporsional. Terbuat dari bahan sintetis berkualitas tinggi yang nyaman digunakan dalam jangka waktu lama. Cocok untuk hangout atau acara santai.",
    rating: 4.6,
    terjual: 100,
  ),
  ProdukCewe(
    "Sepatu Leather Boots",
    "assets/image/sepatucewe5.jpeg",
    480000,
    "Sepatu",
    deskripsi:
        "Boots kulit asli dengan kualitas premium, cocok untuk cuaca dingin maupun musim hujan. Memiliki sol tebal yang kuat dan nyaman untuk jalan jauh. Desainnya elegan namun tetap kasual, pas untuk dipadukan dengan jeans atau rok panjang.",
    rating: 5.0,
    terjual: 80,
  ),

  // 👚 KEMEJA
  ProdukCewe(
    "Kemeja Floral Blouse",
    "assets/image/kemejacewe1.jpeg",
    200000,
    "Kemeja",
    deskripsi:
        "Blouse bermotif bunga yang feminin dan elegan, terbuat dari bahan katun lembut dan breathable. Cocok dipakai ke kantor, acara santai, atau kumpul bersama teman. Memiliki potongan pas di badan sehingga memberikan tampilan rapi dan stylish.",
    rating: 4.8,
    terjual: 140,
  ),
  ProdukCewe(
    "Kemeja Classic Linen Shirt",
    "assets/image/kemejacewe2.jpeg",
    210000,
    "Kemeja",
    deskripsi:
        "Kemeja linen klasik dengan potongan longgar namun tetap terlihat rapi. Bahan linen yang ringan dan sejuk membuat nyaman digunakan sepanjang hari, cocok untuk kegiatan outdoor maupun indoor. Warna netral mudah dipadukan dengan berbagai bawahan.",
    rating: 4.7,
    terjual: 120,
  ),
  ProdukCewe(
    "Kemeja Casual Cotton Top",
    "assets/image/kemejacewe3.jpeg",
    190000,
    "Kemeja",
    deskripsi:
        "Atasan casual berbahan katun yang lembut dan nyaman. Cocok untuk aktivitas santai sehari-hari maupun hangout dengan teman. Desain simple namun modis, memberikan kesan stylish tanpa berlebihan.",
    rating: 4.6,
    terjual: 100,
  ),
  ProdukCewe(
    "Kemeja Formal White Shirt",
    "assets/image/kemejacewe4.jpeg",
    230000,
    "Kemeja",
    deskripsi:
        "Kemeja putih formal yang cocok untuk acara resmi, kerja, maupun meeting penting. Terbuat dari bahan katun premium yang nyaman dan mudah menyerap keringat. Memiliki potongan yang rapi sehingga tampak elegan dan profesional.",
    rating: 5.0,
    terjual: 90,
  ),
  ProdukCewe(
    "Kemeja Denim Overshirt",
    "assets/image/kemejacewe5.jpeg",
    250000,
    "Kemeja",
    deskripsi:
        "Overshirt berbahan denim ringan, cocok untuk gaya kasual dan layered outfit. Bisa dipadukan dengan kaos atau dress untuk tampilan lebih stylish. Bahan denim yang lentur membuat nyaman dipakai sepanjang hari.",
    rating: 4.7,
    terjual: 70,
  ),

  // 👗 DRESS
  ProdukCewe(
    "Summer Floral Dress",
    "assets/image/dress1.jpeg",
    350000,
    "Dress",
    deskripsi:
        "Dress motif bunga yang cantik dan feminin, terbuat dari bahan chiffon ringan dan nyaman. Cocok untuk acara pesta, jalan-jalan, atau acara formal di musim panas. Model flowy memberikan tampilan elegan dan anggun.",
    rating: 4.9,
    terjual: 160,
  ),
  ProdukCewe(
    "Elegant Maxi Dress",
    "assets/image/dress2.jpeg",
    420000,
    "Dress",
    deskripsi:
        "Maxi dress panjang dengan desain elegan dan mewah. Terbuat dari bahan satin premium yang lembut dan jatuh dengan indah. Cocok untuk acara pesta, formal, atau foto-foto. Memberikan siluet tubuh yang proporsional.",
    rating: 5.0,
    terjual: 140,
  ),
  ProdukCewe(
    "Casual Midi Dress",
    "assets/image/dress3.jpeg",
    330000,
    "Dress",
    deskripsi:
        "Midi dress santai dengan bahan katun lembut yang nyaman. Cocok untuk hangout, bekerja dari rumah, atau aktivitas sehari-hari. Desain simpel tapi tetap stylish, mudah dipadukan dengan sepatu flat atau sneakers.",
    rating: 4.7,
    terjual: 120,
  ),
  ProdukCewe(
    "Evening Party Dress",
    "assets/image/dress4.jpeg",
    480000,
    "Dress",
    deskripsi:
        "Dress pesta malam yang glamor dengan bahan satin dan detail manik-manik. Cocok untuk acara formal, gala dinner, atau pesta pernikahan. Memberikan kesan anggun dan elegan bagi pemakainya.",
    rating: 4.8,
    terjual: 100,
  ),
  ProdukCewe(
    "Vintage Polkadot Dress",
    "assets/image/dress5.jpeg",
    360000,
    "Dress",
    deskripsi:
        "Dress dengan motif polkadot vintage, bahan katun lembut, nyaman dipakai sehari-hari. Cocok untuk tampilan casual dan retro, mudah dipadukan dengan sepatu flat atau heels.",
    rating: 4.6,
    terjual: 80,
  ),

  // 👕 T-SHIRT
  ProdukCewe(
    "T-Shirt Basic Tee",
    "assets/image/tshirtcewe1.jpeg",
    110000,
    "T-Shirt",
    deskripsi:
        "Kaos basic dengan bahan katun lembut yang nyaman. Cocok dipakai sehari-hari, mudah dipadukan dengan jeans, rok, atau celana pendek. Desain minimalis yang timeless.",
    rating: 4.7,
    terjual: 200,
  ),
  ProdukCewe(
    "T-Shirt Pastel Oversized Tee",
    "assets/image/tshirtcewe2.jpeg",
    130000,
    "T-Shirt",
    deskripsi:
        "Kaos oversized dengan warna pastel lembut, memberikan kesan santai dan modis. Bahan katun ringan membuat nyaman digunakan sepanjang hari.",
    rating: 4.6,
    terjual: 150,
  ),
  ProdukCewe(
    "T-Shirt Minimalist Print Tee",
    "assets/image/tshirtcewe3.jpeg",
    120000,
    "T-Shirt",
    deskripsi:
        "Kaos dengan print minimalis, cocok untuk tampilan casual dan modern. Bahan katun berkualitas tinggi, nyaman dan tahan lama.",
    rating: 4.8,
    terjual: 130,
  ),
  ProdukCewe(
    "T-Shirt Casual Crop Tee",
    "assets/image/tshirtcewe4.jpeg",
    125000,
    "T-Shirt",
    deskripsi:
        "Kaos crop top casual yang nyaman, cocok dipadukan dengan high-waist jeans atau skirt. Memberikan kesan stylish dan trendi.",
    rating: 4.7,
    terjual: 110,
  ),
  ProdukCewe(
    "T-Shirt Graphic Street Tee",
    "assets/image/tshirtcewe5.jpeg",
    135000,
    "T-Shirt",
    deskripsi:
        "Kaos dengan motif grafis street style, memberikan tampilan urban yang kekinian. Bahan katun lembut, nyaman dipakai untuk aktivitas sehari-hari.",
    rating: 5.0,
    terjual: 90,
  ),

  // 👗 ROK
  ProdukCewe(
    "Pleated Long Skirt",
    "assets/image/skirtcewe1.jpeg",
    170000,
    "Rok",
    deskripsi:
        "Rok panjang dengan model plisket, terbuat dari bahan chiffon yang ringan dan nyaman. Cocok untuk tampilan formal maupun casual, mudah dipadukan dengan blouse atau kaos.",
    rating: 4.8,
    terjual: 100,
  ),
  ProdukCewe(
    "A-Line Mini Skirt",
    "assets/image/skirtcewe2.jpeg",
    160000,
    "Rok",
    deskripsi:
        "Rok mini model A-line yang stylish dan nyaman. Cocok untuk aktivitas santai, hangout, atau jalan-jalan. Bahan katun yang lentur membuat mudah bergerak.",
    rating: 4.7,
    terjual: 90,
  ),
  ProdukCewe(
    "Denim Midi Skirt",
    "assets/image/skirtcewe3.jpeg",
    185000,
    "Rok",
    deskripsi:
        "Rok midi berbahan denim berkualitas tinggi, cocok untuk tampilan kasual dan semi-formal. Bisa dipadukan dengan sneakers atau flat shoes.",
    rating: 4.6,
    terjual: 80,
  ),

  // 👖 CELANA
  ProdukCewe(
    "Celana High Waist Jeans",
    "assets/image/celanacewe1.jpeg",
    190000,
    "Celana",
    deskripsi:
        "Jeans model high waist dengan bahan denim elastis, nyaman untuk aktivitas sehari-hari. Memberikan tampilan kaki lebih panjang dan proporsional.",
    rating: 4.8,
    terjual: 120,
  ),
  ProdukCewe(
    "Celana Wide Leg Pants",
    "assets/image/celanacewe2.jpeg",
    200000,
    "Celana",
    deskripsi:
        "Celana panjang model wide leg yang trendy dan nyaman. Bahan ringan dan breathable cocok untuk cuaca panas maupun santai.",
    rating: 4.7,
    terjual: 100,
  ),
  ProdukCewe(
    "Celana Skinny Fit Jeans",
    "assets/image/celanacewe3.jpeg",
    210000,
    "Celana",
    deskripsi:
        "Jeans model skinny fit berbahan denim elastis, cocok untuk tampilan kasual dan modern. Memberikan siluet kaki yang ramping.",
    rating: 4.9,
    terjual: 90,
  ),
  ProdukCewe(
    "Celana Casual Cotton Pants",
    "assets/image/celanacewe4.jpeg",
    180000,
    "Celana",
    deskripsi:
        "Celana panjang katun santai, nyaman dipakai untuk aktivitas sehari-hari. Cocok dipadukan dengan kaos atau blouse casual.",
    rating: 4.7,
    terjual: 80,
  ),
];

// ================== HALAMAN PRODUK CEWE ==================
class ProdukCewePage extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  const ProdukCewePage({Key? key, required this.onAddToCart}) : super(key: key);

  List<String> getKategoriUnik() =>
      semuaProdukCewe.map((p) => p.kategori).toSet().toList();

  String formatHarga(int harga) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(harga);
  }

  Widget _buildGridKategori(
      BuildContext context, String kategori, List<ProdukCewe> produkList) {
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
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
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
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
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
        title: const Text("Produk Wanita 👗"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/keranjang'); // route ke halaman keranjang
            },
          ),
        ],
      ),
      body: ListView(
        children: kategoriList.map((kategori) {
          final produkPerKategori =
              semuaProdukCewe.where((p) => p.kategori == kategori).toList();
          return _buildGridKategori(context, kategori, produkPerKategori);
        }).toList(),
      ),
    );
  }
}
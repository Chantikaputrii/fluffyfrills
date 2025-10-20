import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:getwidget/getwidget.dart';
import '/models/produk.dart';
import '/widget/detail_produk.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '../cart.dart'; // <- import Cart singleton



// ================== MODEL PRODUK COWO ==================
class ProdukCowo extends Produk {
  final String kategori;
  final double rating;
  final int terjual;
  

  ProdukCowo(
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
  String getKategori() => "Cowo";

  @override
  String getInfo() => "$kategori: $nama - Rp$harga";
}

// ================== DATA PRODUK COWO ==================
final List<ProdukCowo> semuaProdukCowo = [
  // 🟦 Sepatu
  ProdukCowo(
    "Sepatu AirStride Sneakers",
    "assets/image/sepatucowo1.jpeg",
    350000,
    "Sepatu",
    deskripsi:
        "AirStride Sneakers hadir dengan desain modern yang stylish dan sol empuk yang memberikan kenyamanan maksimal. Material breathable memastikan kaki tetap sejuk, cocok untuk aktivitas harian maupun olahraga ringan. Sepatu ini juga mudah dipadukan dengan berbagai gaya fashion casual maupun sporty, sehingga tampil trendi sepanjang hari.",
    rating: 4.8,
    terjual: 250,
  ),
  ProdukCowo(
    "Sepatu UrbanFlex Runner",
    "assets/image/sepatucowo2.jpeg",
    420000,
    "Sepatu",
    deskripsi:
        "UrbanFlex Runner adalah sepatu lari urban dengan teknologi fleksibel yang mengikuti gerakan kaki secara natural. Desain minimalis namun tetap stylish membuatnya cocok dipakai untuk jalan santai, gym, maupun olahraga outdoor ringan. Sol anti-slip memberikan stabilitas ekstra di berbagai permukaan.",
    rating: 4.7,
    terjual: 200,
  ),
  ProdukCowo(
    "Sepatu StreetWave High",
    "assets/image/sepatucowo3.jpeg",
    390000,
    "Sepatu",
    deskripsi: 
        "StreetWave High hadir dengan desain high-top yang modern dan edgy, cocok untuk kamu yang ingin tampil standout. Bahan berkualitas tinggi membuatnya nyaman dipakai seharian, sementara sol yang lentur mendukung mobilitas aktif. Ideal untuk hangout, jalan-jalan, atau sekadar menambah gaya casual urban kamu.",
    rating: 4.9,
    terjual: 180,
  ),
  ProdukCowo(
    "Sepatu Vortex Trail",
    "assets/image/sepatucowo4.jpeg",
    450000,
    "Sepatu",
    deskripsi:
        "Vortex Trail merupakan sepatu outdoor yang tangguh dengan grip maksimal, cocok untuk hiking, trekking, maupun aktivitas fisik di luar ruangan. Material tahan lama dan sol anti-slip memberikan kenyamanan serta keamanan saat melangkah di medan apa pun. Desain sporty juga membuatnya tetap stylish untuk penggunaan kasual.",
    rating: 4.6,
    terjual: 150,
  ),
  ProdukCowo(
    "Seapatu Nova Classic",
    "assets/image/sepatucowo5.jpeg",
    480000,
    "Sepatu",
    deskripsi:
        "Nova Classic adalah sepatu elegan dengan desain timeless yang cocok untuk berbagai kesempatan, dari formal hingga casual. Bahan premium dipadukan dengan sol empuk memberikan kenyamanan optimal. Penampilan yang rapi dan modern membuatmu percaya diri di kantor, acara resmi, maupun hangout santai.",
    rating: 5.0,
    terjual: 120,
  ),
  // 👔 KEMEJA
  ProdukCowo(
    "Kemeja Oxford Slim Fit",
    "assets/image/kemejacowo1.jpeg",
    220000,
    "Kemeja",
    deskripsi:
        "Oxford Slim Fit adalah kemeja formal yang dirancang untuk pria modern. Bahan katun lembut memberikan kenyamanan sepanjang hari, sementara potongan slim fit menampilkan siluet rapi dan stylish. Cocok untuk ke kantor, meeting, atau acara semi-formal, mudah dipadukan dengan jas maupun celana chino.",
    rating: 4.9,
    terjual: 180,
  ),
  ProdukCowo(
    "Kemeja Classic Linen Shirt",
    "assets/image/kemejacowo2.jpeg",
    200000,
    "Kemeja",
    deskripsi:
        "Classic Linen Shirt menghadirkan kesan santai tapi tetap elegan. Terbuat dari bahan linen berkualitas tinggi yang breathable, membuatmu nyaman saat cuaca panas. Cocok dipakai untuk hangout, liburan, maupun casual office look. Warnanya natural dan mudah dipadukan dengan celana jeans maupun chino.",
    rating: 4.8,
    terjual: 160,
  ),
  ProdukCowo(
    "Kemeja Urban Denim Shirt",
    "assets/image/kemejacowo3.jpeg",
    210000,
    "Kemeja",
    deskripsi:
        "Urban Denim Shirt adalah kemeja denim modern dengan nuansa kasual yang stylish. Material denim berkualitas memberikan tampilan maskulin dan tahan lama. Bisa dipakai untuk street style, hangout, atau casual meeting. Desainnya fleksibel sehingga bisa dipadukan dengan celana panjang, jeans, maupun celana chino.",
    rating: 4.7,
    terjual: 140,
  ),
  ProdukCowo(
    "Kemeja Pure White Formal",
    "assets/image/kemejacowo4.jpeg",
    240000,
    "Kemeja",
    deskripsi:
        "Pure White Formal adalah kemeja klasik warna putih yang wajib dimiliki setiap pria. Bahan katun premium membuatnya nyaman dan breathable, sementara desain formalnya cocok untuk kantor, presentasi, maupun acara resmi. Mudah dipadukan dengan jas, blazer, atau celana formal apa pun.",
    rating: 5.0,
    terjual: 130,
  ),
  ProdukCowo(
    "Kemeja Tropical Breeze",
    "assets/image/kemejacowo5.jpeg",
    230000,
    "Kemeja",
    deskripsi:
        "Tropical Breeze adalah kemeja motif tropis yang ceria dan fresh. Cocok untuk liburan, pantai, atau acara santai. Bahan ringan dan breathable membuatmu tetap nyaman saat cuaca panas, sementara desain motif tropical menambahkan kesan fun dan stylish pada penampilanmu.",
    rating: 4.6,
    terjual: 110,
  ),
  // 👕 T-SHIRT
  ProdukCowo(
    "T-shirt Basic Cotton Tee",
    "assets/image/tshirtcowo1.jpeg",
    120000,
    "T-Shirt",
    deskripsi:
        "Basic Cotton Tee adalah kaos sehari-hari yang nyaman dan stylish. Terbuat dari katun lembut berkualitas tinggi, memberikan kenyamanan maksimal sepanjang hari. Bisa dipadukan dengan celana jeans, short pants, atau layering dengan jaket favoritmu untuk tampilan casual yang effortless.",
    rating: 4.9,
    terjual: 300,
  ),
  ProdukCowo(
    "T-shirt Retro Print Tee",
    "assets/image/tshirtcowo2.jpeg",
    110000,
    "T-Shirt",
    deskripsi:
        "Retro Print Tee hadir dengan desain vintage yang unik dan eye-catching. Terbuat dari katun lembut, nyaman untuk aktivitas sehari-hari. Cocok dipakai untuk hangout, nongkrong, atau tampil casual keren dengan sneakers favoritmu.",
    rating: 4.8,
    terjual: 250,
  ),
  ProdukCowo(
    "T-shirt Oversized Street Tee",
    "assets/image/tshirtcowo3.jpeg",
    115000,
    "T-Shirt",
    deskripsi:
        "Oversized Street Tee memberikan vibe urban street style yang trendy. Potongan longgar memberikan kenyamanan dan kebebasan bergerak. Cocok dipadukan dengan jogger pants, sneakers, dan aksesori street style lainnya.",
    rating: 4.7,
    terjual: 200,
  ),
  ProdukCowo(
    "T-shirt Minimalist Core Tee",
    "assets/image/tshirtcowo4.jpeg",
    130000,
    "T-Shirt",
    deskripsi:
        "Minimalist Core Tee hadir dengan desain simpel namun elegan, cocok untuk pria yang menyukai tampilan clean dan minimalis. Terbuat dari katun premium yang nyaman, mudah dipadukan dengan celana jeans atau chino untuk tampilan smart casual.",
    rating: 4.9,
    terjual: 180,
  ),
  ProdukCowo(
    "T-shirt Signature Graphic Tee",
    "assets/image/tshirtcowo5.jpeg",
    125000,
    "T-Shirt",
    deskripsi:
        "Signature Graphic Tee menampilkan desain grafis unik yang standout. Material katun lembut memastikan kenyamanan, sementara desain bold memberikan kesan fashionable dan modern. Cocok dipakai untuk street style maupun casual hangout.",
    rating: 5.0,
    terjual: 150,
  ),
  // 👖 CELANA
  ProdukCowo(
    "Celana Chino Slim Fit",
    "assets/image/celanacowo1.jpeg",
    180000,
    "Celana",
    deskripsi:
        "Chino Slim Fit adalah celana formal-casual yang nyaman dipakai sepanjang hari. Potongan slim fit menampilkan siluet rapi, cocok dipadukan dengan kemeja atau t-shirt. Bahan ringan namun berkualitas memastikan kenyamanan di berbagai kegiatan.",
    rating: 4.8,
    terjual: 140,
  ),
  ProdukCowo(
    "Celana Denim Classic Blue",
    "assets/image/celanacowo2.jpeg",
    175000,
    "Celana",
    deskripsi:
        "Denim Classic Blue, celana jeans klasik dengan warna biru timeless. Material denim berkualitas tinggi, tahan lama, dan nyaman dipakai seharian. Cocok untuk tampilan kasual maupun semi-formal dengan padu padan yang fleksibel.",
    rating: 4.9,
    terjual: 160,
  ),
  ProdukCowo(
    "Celana Cargo Utility Pants",
    "assets/image/celanacowo3.jpeg",
    185000,
    "Celana",
    deskripsi:
        "Cargo Utility Pants hadir dengan desain multifungsi dan kantong tambahan yang stylish. Terbuat dari bahan berkualitas dan nyaman dipakai, ideal untuk aktivitas outdoor maupun street style casual. Memberikan kesan maskulin dan praktis.",
    rating: 4.7,
    terjual: 130,
  ),
  ProdukCowo(
    "Celana Tapered Black Jeans",
    "assets/image/celanacowo4.jpeg",
    190000,
    "Celana",
    deskripsi:
        "Tapered Black Jeans, celana hitam modern dengan potongan taper yang rapi. Terbuat dari bahan denim nyaman dan fleksibel, cocok untuk gaya casual maupun semi-formal. Mudah dipadukan dengan t-shirt atau kemeja favoritmu.",
    rating: 4.9,
    terjual: 120,
  ),
];

// ================== HALAMAN PRODUK COWO ==================
class ProdukCowoPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  const ProdukCowoPage({Key? key, required this.onAddToCart}) : super(key: key);

  List<String> getKategoriUnik() =>
      semuaProdukCowo.map((p) => p.kategori).toSet().toList();

  String formatHarga(int harga) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(harga);
  }

  Widget _buildGridKategori(
      BuildContext context, String kategori, List<ProdukCowo> produkList) {
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
                    // Gambar produk
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

                    // Nama produk
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

                    // Harga
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        formatHarga(produk.harga),
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Rating
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
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Text(
                      "${produk.terjual}+ Terjual",
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),

                    // Tombol tambah ke keranjang
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
                              content:
                                  Text("${produk.nama} ditambahkan ke keranjang!"),
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
        title: const Text("Produk Pria 👕"),
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
              semuaProdukCowo.where((p) => p.kategori == kategori).toList();
          return _buildGridKategori(context, kategori, produkPerKategori);
        }).toList(),
      ),
    );
  }
}
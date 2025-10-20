import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:getwidget/getwidget.dart';
import '/models/produk.dart';
import '/widget/detail_produk.dart';
import '../cart.dart';

// ================== MODEL PRODUK ANAK ==================
class ProdukAnak extends Produk {
  final String kategori;
  final double rating;
  final int terjual;

  ProdukAnak(
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
  String getKategori() => "Anak";

  @override
  String getInfo() => "$kategori: $nama - Rp$harga";
}

// ================== DATA PRODUK ANAK ==================
final List<ProdukAnak> semuaProdukAnak = [
  // 👟 SEPATU
  ProdukAnak(
    "Sepatu Sport Anak",
    "assets/image/sepatuanak1.jpeg",
    200000,
    "Sepatu",
    deskripsi:
        "Sepatu sport yang ringan dan nyaman untuk aktivitas anak sehari-hari. Sol anti-slip menjaga keselamatan saat bermain atau berlari. Desain trendy dengan warna ceria untuk semangat anak.",
    rating: 4.8,
    terjual: 120,
  ),
  ProdukAnak(
    "Sepatu Casual Anak",
    "assets/image/sepatuanak2.jpeg",
    180000,
    "Sepatu",
    deskripsi:
        "Sepatu casual dengan bahan lembut dan breathable, cocok untuk kegiatan sekolah maupun hangout. Tersedia dalam warna-warna cerah yang disukai anak-anak.",
    rating: 4.5,
    terjual: 150,
  ),
  ProdukAnak(
    "Sepatu Sekolah",
    "assets/image/sepatuanak3.jpeg",
    190000,
    "Sepatu",
    deskripsi:
        "Sepatu sekolah resmi yang nyaman dipakai sepanjang hari. Sol empuk dan desain pas di kaki memastikan aktivitas belajar dan bermain tetap nyaman.",
    rating: 4.6,
    terjual: 100,
  ),
  ProdukAnak(
    "Sepatu Sneaker Anak",
    "assets/image/sepatuanak4.jpeg",
    210000,
    "Sepatu",
    deskripsi:
        "Sneaker sporty dengan bantalan empuk, ideal untuk anak aktif. Bahan ringan dan fleksibel membuat anak bebas bergerak tanpa rasa lelah.",
    rating: 4.7,
    terjual: 130,
  ),

  // 👕 KEMEJA
  ProdukAnak(
    "Kemeja Kotak",
    "assets/image/kemejanak1.jpeg",
    120000,
    "Kemeja",
    deskripsi:
        "Kemeja kotak lucu untuk anak, nyaman dipakai sehari-hari. Bahan katun lembut menjaga kulit sensitif tetap aman. Cocok untuk sekolah atau acara santai.",
    rating: 4.5,
    terjual: 90,
  ),
  ProdukAnak(
    "Kemeja Denim",
    "assets/image/kemejanak2.jpeg",
    150000,
    "Kemeja",
    deskripsi:
        "Kemeja denim casual yang stylish. Bahan kuat dan lentur, nyaman untuk bermain aktif. Tampilan keren dan trendi untuk anak-anak modern.",
    rating: 4.6,
    terjual: 100,
  ),
  ProdukAnak(
    "Kemeja Putih",
    "assets/image/kemejanak3.jpeg",
    110000,
    "Kemeja",
    deskripsi:
        "Kemeja putih formal untuk anak, nyaman untuk sekolah atau acara resmi. Bahan katun premium yang mudah dicuci dan tetap awet.",
    rating: 4.7,
    terjual: 80,
  ),
  ProdukAnak(
    "Kemeja Batik Anak",
    "assets/image/kemejanak4.jpeg",
    140000,
    "Kemeja",
    deskripsi:
        "Kemeja batik anak dengan motif ceria dan warna menarik. Cocok untuk acara formal maupun perayaan budaya, nyaman dan fleksibel dipakai seharian.",
    rating: 4.8,
    terjual: 70,
  ),

  // 👗 DRESS
  ProdukAnak(
    "Dress Bunga",
    "assets/image/dressanak1.jpeg",
    150000,
    "Dress",
    deskripsi:
        "Dress cantik motif bunga, ringan dan nyaman untuk anak. Cocok untuk pesta ulang tahun atau jalan-jalan santai. Memberikan kesan manis dan playful.",
    rating: 4.9,
    terjual: 60,
  ),
  ProdukAnak(
    "Dress Pesta",
    "assets/image/dressanak2.jpeg",
    200000,
    "Dress",
    deskripsi:
        "Dress pesta elegan untuk anak perempuan, bahan satin lembut dan desain mewah. Memberikan tampilan manis dan percaya diri saat tampil di acara spesial.",
    rating: 4.8,
    terjual: 55,
  ),
  ProdukAnak(
    "Dress Kasual",
    "assets/image/dressanak3.jpeg",
    130000,
    "Dress",
    deskripsi:
        "Dress kasual nyaman untuk aktivitas sehari-hari. Bahan katun lembut dan desain simpel namun tetap stylish untuk anak-anak aktif.",
    rating: 4.6,
    terjual: 70,
  ),
  ProdukAnak(
    "Dress Pink",
    "assets/image/dressanak4.jpeg",
    160000,
    "Dress",
    deskripsi:
        "Dress pink manis dengan aksen ruffle. Cocok untuk bermain, sekolah, maupun acara santai. Nyaman dan fleksibel dipakai seharian.",
    rating: 4.7,
    terjual: 65,
  ),
  ProdukAnak(
    "Dress Princess",
    "assets/image/dressanak5.jpeg",
    250000,
    "Dress",
    deskripsi:
        "Dress bergaya princess dengan bahan berkualitas, cocok untuk pesta atau acara spesial. Memberikan kesan anggun dan lucu bagi anak perempuan.",
    rating: 4.9,
    terjual: 50,
  ),

  // 👕 T-SHIRT
  ProdukAnak(
    "T-Shirt Kartun",
    "assets/image/tshirtanak1.jpeg",
    80000,
    "T-Shirt",
    deskripsi:
        "Kaos motif kartun favorit anak, nyaman dan ringan. Cocok untuk aktivitas bermain atau sekolah. Warna cerah membuat anak semakin semangat.",
    rating: 4.5,
    terjual: 120,
  ),
  ProdukAnak(
    "T-Shirt Polos",
    "assets/image/tshirtanak2.jpeg",
    60000,
    "T-Shirt",
    deskripsi:
        "Kaos polos nyaman untuk anak-anak. Bahan katun lembut dan breathable, ideal untuk dipakai sehari-hari.",
    rating: 4.4,
    terjual: 100,
  ),
  ProdukAnak(
    "T-Shirt Sport",
    "assets/image/tshirtanak3.jpeg",
    90000,
    "T-Shirt",
    deskripsi:
        "Kaos sporty ringan dan fleksibel untuk anak aktif. Cocok untuk olahraga ringan maupun aktivitas outdoor.",
    rating: 4.6,
    terjual: 90,
  ),
  ProdukAnak(
    "T-Shirt Warna-warni",
    "assets/image/tshirtanak4.jpeg",
    95000,
    "T-Shirt",
    deskripsi:
        "Kaos warna-warni ceria untuk anak. Membuat tampilan lebih playful dan menyenangkan, nyaman dipakai sepanjang hari.",
    rating: 4.7,
    terjual: 85,
  ),

  // 👗 ROK
  ProdukAnak(
    "Pleated Long Skirt Anak",
    "assets/image/skirtanak1.jpeg",
    120000,
    "Rok",
    deskripsi:
        "Rok panjang dengan model plisket, nyaman untuk anak. Bisa dipakai untuk sekolah maupun acara santai.",
    rating: 4.7,
    terjual: 60,
  ),
  ProdukAnak(
    "A-Line Mini Skirt Anak",
    "assets/image/skirtanak2.jpeg",
    100000,
    "Rok",
    deskripsi:
        "Rok mini model A-line, cocok untuk bermain dan aktivitas sehari-hari. Nyaman dan ringan dipakai anak-anak.",
    rating: 4.6,
    terjual: 50,
  ),
  ProdukAnak(
    "Denim Midi Skirt Anak",
    "assets/image/skirtanak3.jpeg",
    110000,
    "Rok",
    deskripsi:
        "Rok midi berbahan denim, pas untuk kegiatan santai maupun semi-formal anak-anak.",
    rating: 4.5,
    terjual: 40,
  ),

  // 👖 CELANA
  ProdukAnak(
    "High Waist Pants Anak",
    "assets/image/celanaanak1.jpeg",
    120000,
    "Celana",
    deskripsi:
        "Celana panjang model high waist yang nyaman dan elastis. Cocok untuk aktivitas sekolah dan bermain.",
    rating: 4.7,
    terjual: 70,
  ),
  ProdukAnak(
    "Wide Leg Pants Anak",
    "assets/image/celanaanak2.jpeg",
    130000,
    "Celana",
    deskripsi:
        "Celana panjang model wide leg yang trendy dan nyaman untuk anak-anak.",
    rating: 4.6,
    terjual: 60,
  ),
  ProdukAnak(
    "Skinny Jeans Anak",
    "assets/image/celanaanak3.jpeg",
    140000,
    "Celana",
    deskripsi:
        "Jeans model skinny fit, nyaman untuk kegiatan sehari-hari dan bermain anak.",
    rating: 4.8,
    terjual: 55,
  ),
  ProdukAnak(
    "Casual Pants Anak",
    "assets/image/celanaanak4.jpeg",
    110000,
    "Celana",
    deskripsi:
        "Celana panjang katun santai, cocok untuk bermain dan aktivitas sehari-hari anak.",
    rating: 4.6,
    terjual: 50,
  ),
];


// ================== HALAMAN PRODUK ANAK ==================
class ProdukAnakPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddToCart;

  const ProdukAnakPage({Key? key, required this.onAddToCart}) : super(key: key);

  List<String> getKategoriUnik() =>
      semuaProdukAnak.map((p) => p.kategori).toSet().toList();

  String formatHarga(int harga) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(harga);
  }

  Widget _buildGridKategori(
      BuildContext context, String kategori, List<ProdukAnak> produkList) {
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
        title: const Text("Produk Anak 👦👧"),
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
              semuaProdukAnak.where((p) => p.kategori == kategori).toList();
          return _buildGridKategori(context, kategori, produkPerKategori);
        }).toList(),
      ),
    );
  }
}
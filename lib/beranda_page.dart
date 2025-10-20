import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'produkpage.dart';
import 'models/produkcowo.dart';
import 'models/produkcewe.dart';
import 'models/produkanak.dart';
import 'models/produkaksesoris.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'widget/detail_produk.dart';
import 'cart.dart'; // <- import Cart singleton

class BerandaPage extends StatelessWidget {
  final String userName;     // Tambahkan userName
  final String userEmail;
  final String searchQuery;

  const BerandaPage({
    Key? key,
    required this.userName,   // wajib ada saat buat instance
    required this.userEmail,
    this.searchQuery = "",
  }) : super(key: key);

  // ================= Build Section Produk =================
  Widget _buildSectionProduk(
    BuildContext context,
    String title,
    List<dynamic> produkList,
    Widget pageTujuan,
  ) {
    if (produkList.isEmpty) return const SizedBox();

    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GFButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => pageTujuan),
                  );
                },
                text: "Lihat Semua",
                type: GFButtonType.outline2x,
                color: Colors.pinkAccent,
                size: GFSize.SMALL,
                shape: GFButtonShape.pills,
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: produkList.length,
          itemBuilder: (context, index) {
            final dynamic produkAsli = produkList[index];

            return GestureDetector(
              onTap: () {
                // Tetap bisa akses detail produk
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailProdukPage(
                      produk: produkAsli,
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
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.asset(
                          produkAsli.gambar,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        produkAsli.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        formatRupiah.format(produkAsli.harga),
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingStars(
                          value: produkAsli.rating,
                          starCount: 5,
                          starSize: 16,
                          maxValue: 5,
                          starColor: Colors.amber,
                          valueLabelVisibility: false,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          produkAsli.rating.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GFButton(
                        onPressed: () {
                          // Tambahkan ke keranjang
                          Cart().addItem({
                            'name': produkAsli.nama,
                            'price': produkAsli.harga,
                            'image': produkAsli.gambar,
                            'size': null,
                            'color': null,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "${produkAsli.nama} ditambahkan ke keranjang!"),
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
    final produkCowoPreview = semuaProdukCowo
        .where((p) => p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(4)
        .toList();

    final produkCewePreview = semuaProdukCewe
        .where((p) => p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(4)
        .toList();

    final produkAnakPreview = semuaProdukAnak
        .where((p) => p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(4)
        .toList();

    final produkAksesorisPreview = semuaProdukAksesoris
        .where((p) => p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(4)
        .toList();

    final List<String> bannerImages = [
      "assets/assets/image/banner1.jpeg",
      "assets/assets/image/banner2.jpeg",
      "assets/assets/image/banner3.jpeg",
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Beranda",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Halo user
          GFCard(
            color: Colors.pink.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            title: GFListTile(
              avatar: const GFAvatar(
                backgroundColor: Colors.pinkAccent,
                size: 20,
                child: Icon(Icons.person, color: Colors.white, size: 14),
              ),
              titleText: "Halo, $userName 💖",  // tampilkan nama user
              subTitleText: userEmail,
            ),
          ),
          const SizedBox(height: 8),

          // Banner Carousel
          CarouselSlider(
            items: bannerImages.map((path) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 260,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              autoPlayCurve: Curves.easeInOut,
              autoPlayAnimationDuration: const Duration(seconds: 2),
            ),
          ),
          const SizedBox(height: 16),

          // Lihat Semua Produk
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GFButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProdukPage()),
                );
              },
              text: "Lihat Semua Produk",
              color: Colors.pinkAccent,
              fullWidthButton: true,
              size: GFSize.LARGE,
              shape: GFButtonShape.pills,
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),

          // Sections Produk
          _buildSectionProduk(
              context,
              "Pria 👕",
              produkCowoPreview,
              ProdukCowoPage(onAddToCart: (item) {
                Cart().addItem(item);
              })),
          _buildSectionProduk(
              context,
              "Wanita 👗",
              produkCewePreview,
              ProdukCewePage(onAddToCart: (item) {
                Cart().addItem(item);
              })),
          _buildSectionProduk(
              context,
              "Anak 🧒",
              produkAnakPreview,
              ProdukAnakPage(onAddToCart: (item) {
                Cart().addItem(item);
              })),
          _buildSectionProduk(
              context,
              "Aksesoris ⌚",
              produkAksesorisPreview,
              ProdukAksesorisPage(onAddToCart: (item) {
                Cart().addItem(item);
              })),
        ],
      ),
    );
  }
}

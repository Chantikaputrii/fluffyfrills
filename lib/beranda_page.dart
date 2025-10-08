import 'package:flutter/material.dart';
import 'package:flutter_application_1/dasboardpage.dart';

// import produk untuk preview
import 'models/produkcowo.dart';
import 'models/produkcewe.dart';
import 'models/produkanak.dart';
import 'models/produkaksesoris.dart';

// import halaman produk detail
import 'produkpage.dart'; 
import 'keranjang_page.dart';
import 'widget/cart_icon.dart'; // widget keranjang


class BerandaPage extends StatelessWidget {
  final String userEmail;
  final String searchQuery;

  const BerandaPage({
    Key? key,
    required this.userEmail,
    this.searchQuery = "",
  }) : super(key: key);

  Widget _buildSectionResponsive(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> produkList,
    Widget pageTujuan,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    final bigImageHeight = screenWidth * 0.35;
    const childAspectRatio = 1.0;

    if (produkList.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul + tombol "Lihat Semua"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => pageTujuan),
                  );
                },
                child: const Text("Lihat Semua"),
              ),
            ],
          ),
        ),
        // Gambar besar di atas grid
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: bigImageHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(produkList.first['image']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Grid produk preview
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: produkList.length - 1,
          itemBuilder: (context, index) {
            final item = produkList[index + 1];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Rp${item['price']}",
                    style: const TextStyle(fontSize: 11, color: Colors.green),
                  ),
                ],
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
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    final produkCewePreview = semuaProdukCewe
        .where((p) => p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    final produkAnakPreview = semuaProdukAnak
        .where((p) => p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    final produkAksesorisPreview = semuaProdukAksesoris
        .where((p) => p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
        actions: [
          CartIcon(
            itemCount: globalCart.length,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const KeranjangPage()),
              ).then((_) => (context as Element).markNeedsBuild());
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Halo, selamat datang $userEmail 💖",
              style: const TextStyle(fontSize: 20),
            ),
          ),

          // 🔥 Tombol ke ProdukPage (biar import kepakai)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProdukPage(), 
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "Lihat Semua Produk",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          _buildSectionResponsive(context, "Pria 👕", produkCowoPreview,
              ProdukCowoPage(onAddToCart: (_) {})),
          _buildSectionResponsive(context, "Wanita 👗", produkCewePreview,
              ProdukCewePage(onAddToCart: (_) {})),
          _buildSectionResponsive(context, "Anak 🧒", produkAnakPreview,
              ProdukAnakPage(onAddToCart: (_) {})),
          _buildSectionResponsive(context, "Aksesoris ⌚", produkAksesorisPreview,
              ProdukAksesorisPage(onAddToCart: (_) {})),
        ],
      ),
    );
  }
}

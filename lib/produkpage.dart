import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/detail_produk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Import halaman kategori (pastikan file dan class sudah ada)
import 'models/produkcowo.dart';
import 'models/produkcewe.dart';
import 'models/produkanak.dart';
import 'models/produkaksesoris.dart';
import 'models/produk.dart';

// Import Cart
import 'cart.dart';

class ProdukPage extends StatefulWidget {
  final String searchQuery;
  final bool showAllProducts; // ✅ PARAMETER BARU
  
  const ProdukPage({
    Key? key, 
    this.searchQuery = "",
    this.showAllProducts = false, // ✅ DEFAULT FALSE
  }) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final String query = widget.searchQuery.toLowerCase();

    final List<Produk> allProducts = [
      ...semuaProdukCowo,
      ...semuaProdukCewe,
      ...semuaProdukAnak,
      ...semuaProdukAksesoris,
    ];

    final List<Produk> filteredProducts = allProducts
        .where((p) => p.nama.toLowerCase().contains(query))
        .toList();

    final bool isSearching = query.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        automaticallyImplyLeading: false, // ✅ Tombol back disembunyikan
        title: isSearching
            ? Text(
                'Hasil pencarian: "$query"',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              )
            : widget.showAllProducts // ✅ CEK PARAMETER
                ? const Text('Semua Produk')
                : const Text('Kategori Produk'),
        centerTitle: true,
        actions: [],
      ),
      body: isSearching
          ? _buildSearchResult(filteredProducts)
          : widget.showAllProducts // ✅ JIKA TRUE, TAMPILKAN SEMUA PRODUK
              ? _buildAllProducts(allProducts)
              : _buildKategoriGrid(),
    );
  }

  // ✅ WIDGET BARU - Tampilkan semua produk
  Widget _buildAllProducts(List<Produk> allProducts) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.6,
      ),
      itemCount: allProducts.length,
      itemBuilder: (context, index) {
        final produk = allProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailProdukPage(
                  produk: produk,
                  onAddToCart: _addToCart,
                ),
              ),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    produk.gambar,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produk.nama,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        currencyFormat.format(produk.harga),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        onPressed: () => _addToCart({
                          "name": produk.nama,
                          "price": produk.harga,
                          "image": produk.gambar,
                          "quantity": 1,
                        }),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        child: const Text(
                          "Tambah",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Grid kategori produk
  Widget _buildKategoriGrid() {
    final List<Map<String, dynamic>> kategoriList = [
      {
        "nama": "Man",
        "gambar": "assets/image/kategoricowo.jpeg",
      },
      {
        "nama": "Women",
        "gambar": "assets/image/kategoricewe.jpeg",
      },
      {
        "nama": "Kids",
        "gambar": "assets/image/kategorianak.jpeg",
      },
      {
        "nama": "Aksesoris",
        "gambar": "assets/image/kategoriaksesoris.jpeg",
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: kategoriList.length,
      itemBuilder: (context, index) {
        final kategori = kategoriList[index];
        return GestureDetector(
          onTap: () {
            Widget page;

            switch (kategori["nama"].toString().toLowerCase()) {
              case "man":
                page = ProdukCowoPage(onAddToCart: _addToCart);
                break;
              case "women":
                page = ProdukCewePage(onAddToCart: _addToCart);
                break;
              case "kids":
                page = ProdukAnakPage(onAddToCart: _addToCart);
                break;
              case "aksesoris":
                page = ProdukAksesorisPage(onAddToCart: _addToCart);
                break;
              default:
                page = Scaffold(
                  appBar: AppBar(title: Text(kategori["nama"])),
                  body: const Center(child: Text('Halaman kategori belum dibuat')),
                );
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    kategori["gambar"],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      kategori["nama"],
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Grid hasil pencarian produk
  Widget _buildSearchResult(List<Produk> filteredProducts) {
    if (filteredProducts.isEmpty) {
      return Center(
        child: Text(
          "Produk tidak ditemukan 😔",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.6,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final produk = filteredProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailProdukPage(
                  produk: produk,
                  onAddToCart: _addToCart,
                ),
              ),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    produk.gambar,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produk.nama,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        currencyFormat.format(produk.harga),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        onPressed: () => _addToCart({
                          "name": produk.nama,
                          "price": produk.harga,
                          "image": produk.gambar,
                          "quantity": 1,
                        }),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        child: const Text(
                          "Tambah",
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addToCart(Map<String, dynamic> produk) {
    Cart().addItem(produk);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${produk["name"]} ditambahkan ke keranjang 💖"),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
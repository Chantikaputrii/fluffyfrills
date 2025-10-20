import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/detail_produk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // <<-- import intl

// Import halaman kategori
import 'models/produkcowo.dart';
import 'models/produkcewe.dart';
import 'models/produkanak.dart';
import 'models/produkaksesoris.dart';
import 'models/produk.dart';

// Import Cart
import 'cart.dart';

class ProdukPage extends StatefulWidget {
  final String searchQuery;
  const ProdukPage({Key? key, this.searchQuery = ""}) : super(key: key);

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
        title: isSearching
            ? Text(
                'Hasil pencarian: "$query"',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              )
            : const Text('Kategori Produk'),
        centerTitle: true,
        actions: [],
      ),
      body: isSearching
          ? _buildSearchResult(filteredProducts)
          : _buildKategoriGrid(),
    );
  }

  // Grid kategori
  Widget _buildKategoriGrid() {
    final List<Map<String, dynamic>> kategoriList = [
      {
        "nama": "Man",
        "gambar": "assets/image/kategoricowo.jpeg",
        "list": semuaProdukCowo,
      },
      {
        "nama": "Women",
        "gambar": "assets/image/kategoricewe.jpeg",
        "list": semuaProdukCewe,
      },
      {
        "nama": "Kids",
        "gambar": "assets/image/kategorianak.jpeg",
        "list": semuaProdukAnak,
      },
      {
        "nama": "Aksesoris",
        "gambar": "assets/image/kategoriaksesoris.jpeg",
        "list": semuaProdukAksesoris,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text(kategori["nama"]),
                    backgroundColor: Colors.pinkAccent,
                  ),
                  body: _buildCategoryProductGrid(kategori["list"]),
                ),
              ),
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

  // Grid produk per kategori
  Widget _buildCategoryProductGrid(List<Produk> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final produk = products[index];
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
                        currencyFormat.format(produk.harga), // <<-- format harga
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
                          style: TextStyle(fontSize: 11),
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

  // Grid hasil pencarian
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
                        currencyFormat.format(produk.harga), // <<-- format harga
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
                          style: TextStyle(fontSize: 11),
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

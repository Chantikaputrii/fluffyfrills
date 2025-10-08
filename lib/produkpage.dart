import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import halaman kategori
import 'models/produkcowo.dart';
import 'models/produkcewe.dart';
import 'models/produkanak.dart';
import 'models/produkaksesoris.dart';

// Import globalCart dari dashboard
import 'dasboardpage.dart';

class ProdukPage extends StatefulWidget {
  final String searchQuery;
  const ProdukPage({Key? key, this.searchQuery = ""}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late String query;

  @override
  void initState() {
    super.initState();
    query = widget.searchQuery.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    // Daftar kategori + data produk
    final List<Map<String, dynamic>> kategoriList = [
      {
        "nama": "Man",
        "gambar": "assets/image/kategoricowo.jpeg",
        "page": ProdukCowoPage(onAddToCart: (item) {
          setState(() => globalCart.add(item));
        }),
      },
      {
        "nama": "Women",
        "gambar": "assets/image/kategoricewe.jpeg",
        "page": ProdukCewePage(onAddToCart: (item) {
          setState(() => globalCart.add(item));
        }),
      },
      {
        "nama": "Kids",
        "gambar": "assets/image/kategorianak.jpeg",
        "page": ProdukAnakPage(onAddToCart: (item) {
          setState(() => globalCart.add(item));
        }),
      },
      {
        "nama": "Aksesoris",
        "gambar": "assets/image/kategoriaksesoris.jpeg",
        "page": ProdukAksesorisPage(onAddToCart: (item) {
          setState(() => globalCart.add(item));
        }),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Produk",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: GridView.builder(
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
                MaterialPageRoute(builder: (_) => kategori["page"]),
              ).then((_) => setState(() {})); // refresh keranjang
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
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
                          Colors.black.withOpacity(0.6),
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
                          shadows: const [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

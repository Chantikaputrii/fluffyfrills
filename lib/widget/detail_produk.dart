import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import '/models/produk.dart';
import '/models/produkcowo.dart';
import '/models/produkcewe.dart';
import '/models/produkanak.dart';
import '/models/produkaksesoris.dart';

// Import komponen kategori
import 'detail_produkcowo.dart';
import 'detail_produkcewe.dart';
import 'detail_produkanak.dart';
import 'detail_produkaksesoris.dart';

class DetailProdukPage extends StatefulWidget {
  final Produk produk;
  final Function(Map<String, dynamic>) onAddToCart;

  const DetailProdukPage({
    Key? key,
    required this.produk,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  String? selectedSize;
  String? selectedColor;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          widget.produk.nama,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Gambar Produk
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(widget.produk.gambar, fit: BoxFit.cover),
                ),
              ),
            ),

            // 🏷️ Nama, Harga, Rating, Terjual
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.produk.nama,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    currencyFormat.format(widget.produk.harga),
                    style: const TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ⭐ Rating + Terjual
                  if (widget.produk is ProdukCowo)
                    _buildRatingTerjual(widget.produk as ProdukCowo),
                  if (widget.produk is ProdukCewe)
                    _buildRatingTerjual(widget.produk as ProdukCewe),
                  if (widget.produk is ProdukAnak)
                    _buildRatingTerjual(widget.produk as ProdukAnak),
                  if (widget.produk is ProdukAksesoris)
                    _buildRatingTerjual(widget.produk as ProdukAksesoris),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(thickness: 1),

            // 📖 Deskripsi Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "DESKRIPSI PRODUK",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.produk.deskripsi.isNotEmpty
                        ? widget.produk.deskripsi
                        : "Produk berkualitas tinggi dan nyaman digunakan untuk aktivitas sehari-hari.",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🎨 Pilihan ukuran & warna kategori spesifik
            _buildKategoriSpesifik(),

            const SizedBox(height: 20),

            // 🔢 Pilih Jumlah Barang
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Jumlah:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  // Tombol -, Angka, +
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Tombol -
                      GestureDetector(
                        onTap: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "-", // lebih jelas daripada icon remove
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32, // lebih besar biar kelihatan
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Angka jumlah
                      Container(
                        width: 55,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.pinkAccent, width: 1.5),
                        ),
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Tombol +
                      GestureDetector(
                        onTap: () {
                          setState(() => quantity++);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // 🛒 Tombol bawah
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          border:
              const Border(top: BorderSide(color: Colors.grey, width: 0.1)),
        ),
        child: Row(
          children: [
            // Tombol Keranjang
            Expanded(
              child: GFButton(
                onPressed: () {
                  if ((selectedColor == null &&
                          widget.produk.getKategori() != "aksesoris") ||
                      selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Pilih warna dan ukuran terlebih dahulu!")),
                    );
                    return;
                  }
                  final item = {
                    "name": widget.produk.nama,
                    "price": widget.produk.harga,
                    "image": widget.produk.gambar,
                    "color": selectedColor,
                    "size": selectedSize,
                    "quantity": quantity,
                  };
                  widget.onAddToCart(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "${widget.produk.nama} ditambahkan ke keranjang 🛒")),
                  );
                },
                color: const Color(0xFFF49906),
                fullWidthButton: true,
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("🛒", style: TextStyle(fontSize: 18)),
                    SizedBox(width: 8),
                    Text(
                      "Keranjang",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Tombol Beli Sekarang
            Expanded(
              child: GFButton(
                onPressed: () {
                  if ((selectedColor == null &&
                          widget.produk.getKategori() != "aksesoris") ||
                      selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              "Pilih warna dan ukuran terlebih dahulu!")),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Berhasil membeli ${widget.produk.nama} 🎉")),
                  );
                },
                text: "Beli Sekarang",
                textColor: Colors.white,
                color: Colors.pinkAccent,
                fullWidthButton: true,
                shape: GFButtonShape.pills,
                size: GFSize.LARGE,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ⭐ Widget Rating dan Terjual
  Widget _buildRatingTerjual(dynamic produk) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingStars(
          value: produk.rating,
          starCount: 5,
          starSize: 20,
          maxValue: 5,
          starColor: Colors.amber,
          starSpacing: 1,
          valueLabelVisibility: false,
        ),
        const SizedBox(width: 8),
        Text(
          produk.rating.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "| ${produk.terjual}+ Terjual",
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  // 🔧 Widget Kategori Spesifik
  Widget _buildKategoriSpesifik() {
    if (widget.produk is ProdukCowo) {
      final produkCowo = widget.produk as ProdukCowo;
      return DetailProdukCowo(
        kategori: produkCowo.kategori,
        onSizeSelected: (size) => setState(() => selectedSize = size),
        onColorSelected: (color) => setState(() => selectedColor = color),
      );
    }

    if (widget.produk is ProdukCewe) {
      final produkCewe = widget.produk as ProdukCewe;
      return DetailProdukCewe(
        kategori: produkCewe.kategori,
        onSizeSelected: (size) => setState(() => selectedSize = size),
        onColorSelected: (color) => setState(() => selectedColor = color),
      );
    }

    if (widget.produk is ProdukAnak) {
      final produkAnak = widget.produk as ProdukAnak;
      return DetailProdukAnak(
        kategori: produkAnak.kategori,
        onSizeSelected: (size) => setState(() => selectedSize = size),
        onColorSelected: (color) => setState(() => selectedColor = color),
      );
    }

    if (widget.produk is ProdukAksesoris) {
      final produkAksesoris = widget.produk as ProdukAksesoris;
      return DetailProdukAksesoris(
        kategori: produkAksesoris.kategori,
        onColorSelected: (color) => setState(() => selectedColor = color),
      );
    }

    return const SizedBox();
  }
}

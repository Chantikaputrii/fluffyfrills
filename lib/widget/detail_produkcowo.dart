import 'package:flutter/material.dart';

class DetailProdukCowo extends StatefulWidget {
  final String kategori; // Contoh: "Sepatu", "Kemeja", "T-Shirt", "Celana"
  final Function(String) onSizeSelected;
  final Function(String) onColorSelected;
  
  const DetailProdukCowo({
    Key? key,
    required this.kategori,
    required this.onSizeSelected,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  State<DetailProdukCowo> createState() => _DetailProdukCowoState();
}

class _DetailProdukCowoState extends State<DetailProdukCowo> {
  String? selectedSize;
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    // Mapping kategori ke ukuran & warna
    final kategoriMap = {
      "sepatu": {
        "sizes": ["39", "40", "41", "42", "43"],
        "colors": ["Hitam", "Coklat", "Putih"],
        "labelSize": "Pilih Ukuran Sepatu",
        "labelColor": "Pilih Warna Sepatu",
      },
      "kemeja": {
        "sizes": ["S", "M", "L", "XL"],
        "colors": ["Putih", "Biru", "Hitam", "Abu-abu"],
        "labelSize": "Pilih Ukuran Kemeja",
        "labelColor": "Pilih Warna Kemeja",
      },
      "t-shirt": {
        "sizes": ["S", "M", "L", "XL"],
        "colors": ["Putih", "Hitam", "Biru", "Merah"],
        "labelSize": "Pilih Ukuran T-Shirt",
        "labelColor": "Pilih Warna T-Shirt",
      },
      "celana": {
        "sizes": ["28", "30", "32", "34", "36"],
        "colors": ["Hitam", "Abu-abu", "Navy"],
        "labelSize": "Pilih Ukuran Celana",
        "labelColor": "Pilih Warna Celana",
      },
    };

    // Lowercase & trim agar selalu cocok dengan key
    final key = widget.kategori.trim().toLowerCase();
    final data = kategoriMap[key];

    // Casting aman & fallback jika kategori baru
    final sizes = (data?["sizes"] as List<dynamic>?)?.cast<String>() ??
        ["S", "M", "L", "XL"];
    final colors = (data?["colors"] as List<dynamic>?)?.cast<String>() ??
        ["Hitam", "Putih"];
    final labelUkuran = (data?["labelSize"] as String?) ?? "Pilih Ukuran";
    final labelWarna = (data?["labelColor"] as String?) ?? "Pilih Warna";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== PILIH UKURAN ====================
          Text(
            labelUkuran,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: sizes.map((size) {
              final isSelected = selectedSize == size;
              return ChoiceChip(
                label: Text(size),
                selected: isSelected,
                selectedColor: Colors.pinkAccent,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                onSelected: (_) {
                  setState(() {
                    selectedSize = size;
                    widget.onSizeSelected(size);
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // ==================== PILIH WARNA ====================
          Text(
            labelWarna,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: colors.map((color) {
              final isSelected = selectedColor == color;
              return ChoiceChip(
                label: Text(color),
                selected: isSelected,
                selectedColor: Colors.pinkAccent,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                onSelected: (_) {
                  setState(() {
                    selectedColor = color;
                    widget.onColorSelected(color);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DetailProdukCewe extends StatefulWidget {
  final String kategori; // Contoh: "Sepatu", "Kemeja", "Dress", "T-Shirt", "Rok", "Celana"
  final Function(String) onSizeSelected;
  final Function(String) onColorSelected;

  const DetailProdukCewe({
    Key? key,
    required this.kategori,
    required this.onSizeSelected,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  State<DetailProdukCewe> createState() => _DetailProdukCeweState();
}

class _DetailProdukCeweState extends State<DetailProdukCewe> {
  String? selectedSize;
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    // Mapping kategori ke ukuran & warna
    final kategoriMap = {
      "sepatu": {
        "sizes": ["34", "35", "36", "37", "38", "39", "40"],
        "colors": ["Hitam", "Putih", "Merah", "Biru", "Coklat"],
        "labelSize": "Pilih Ukuran Sepatu",
        "labelColor": "Pilih Warna Sepatu",
      },
      "kemeja": {
        "sizes": ["S", "M", "L", "XL"],
        "colors": ["Putih", "Biru", "Hitam", "Abu-abu"],
        "labelSize": "Pilih Ukuran Kemeja",
        "labelColor": "Pilih Warna Kemeja",
      },
      "dress": {
        "sizes": ["S", "M", "L", "XL"],
        "colors": ["Merah", "Biru", "Putih", "Pink", "Hitam"],
        "labelSize": "Pilih Ukuran Dress",
        "labelColor": "Pilih Warna Dress",
      },
      "t-shirt": {
        "sizes": ["S", "M", "L", "XL"],
        "colors": ["Putih", "Hitam", "Biru", "Merah", "Pink"],
        "labelSize": "Pilih Ukuran T-Shirt",
        "labelColor": "Pilih Warna T-Shirt",
      },
      "rok": {
        "sizes": ["S", "M", "L", "XL"],
        "colors": ["Hitam", "Putih", "Merah", "Biru", "Coklat"],
        "labelSize": "Pilih Ukuran Rok",
        "labelColor": "Pilih Warna Rok",
      },
      "celana": {
        "sizes": ["28", "30", "32", "34", "36"],
        "colors": ["Hitam", "Abu-abu", "Navy", "Coklat"],
        "labelSize": "Pilih Ukuran Celana",
        "labelColor": "Pilih Warna Celana",
      },
    };

    final key = widget.kategori.trim().toLowerCase();
    final data = kategoriMap[key];

    final sizes = (data?["sizes"] as List<dynamic>?)?.cast<String>() ?? ["S", "M", "L", "XL"];
    final colors = (data?["colors"] as List<dynamic>?)?.cast<String>() ?? ["Hitam", "Putih"];
    final labelUkuran = (data?["labelSize"] as String?) ?? "Pilih Ukuran";
    final labelWarna = (data?["labelColor"] as String?) ?? "Pilih Warna";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pilih Ukuran
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

          // Pilih Warna
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

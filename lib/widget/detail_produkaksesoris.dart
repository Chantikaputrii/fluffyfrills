import 'package:flutter/material.dart';

class DetailProdukAksesoris extends StatefulWidget {
  final String kategori; // Contoh: "Topi", "Kacamata", "Jam Tangan"
  final Function(String) onColorSelected;

  const DetailProdukAksesoris({
    Key? key,
    required this.kategori,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  State<DetailProdukAksesoris> createState() => _DetailProdukAksesorisState();
}

class _DetailProdukAksesorisState extends State<DetailProdukAksesoris> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    // Mapping kategori ke warna
    final kategoriMap = {
      "topi": {
        "colors": ["Hitam", "Coklat", "Putih", "Biru"],
        "labelColor": "Pilih Warna Topi",
      },
      "kacamata": {
        "colors": ["Hitam", "Coklat", "Emas", "Perak"],
        "labelColor": "Pilih Warna Kacamata",
      },
      "jam tangan": {
        "colors": ["Hitam", "Coklat", "Emas", "Perak", "Putih"],
        "labelColor": "Pilih Warna Jam Tangan",
      },
    };

    final key = widget.kategori.trim().toLowerCase();
    final data = kategoriMap[key];

    final colors =
        (data?["colors"] as List<dynamic>?)?.cast<String>() ?? ["Hitam", "Putih"];
    final labelWarna = (data?["labelColor"] as String?) ?? "Pilih Warna";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================== PILIH WARNA ====================
          Text(
            labelWarna,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
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

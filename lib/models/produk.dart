class Produk {
  String _nama;
  String _gambar;
  int _harga;
  String _deskripsi;

  Produk({
    required String nama,
    required String gambar,
    required int harga,
    required String deskripsi,
  })  : _nama = nama,
        _gambar = gambar,
        _harga = harga,
        _deskripsi = deskripsi;

  // Getter
  String get nama => _nama;
  String get gambar => _gambar;
  int get harga => _harga;
  String get deskripsi => _deskripsi;

  // Setter
  set nama(String value) => _nama = value;
  set gambar(String value) => _gambar = value;
  set harga(int value) => _harga = value;
  set deskripsi(String value) => _deskripsi = value;

  // Polymorphism (overrideable if ada subclass misalnya ProdukCowo, ProdukCewe)
  String getInfo() {
    return "Produk: $_nama\nHarga: Rp $_harga\nDeskripsi: $_deskripsi";
  }
}

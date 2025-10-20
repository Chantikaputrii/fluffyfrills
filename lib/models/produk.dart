class Produk {
  String _nama;
  String _gambar;
  int _harga;
  String _deskripsi;
  double _rating;   // rating 0-5
  int _terjual;     // jumlah produk terjual

  Produk({
    required String nama,
    required String gambar,
    required int harga,
    required String deskripsi,
    double rating = 0.0,
    int terjual = 0,  // default 0
  })  : _nama = nama,
        _gambar = gambar,
        _harga = harga,
        _deskripsi = deskripsi,
        _rating = rating,
        _terjual = terjual;

  // Getter
  String get nama => _nama;
  String get gambar => _gambar;
  int get harga => _harga;
  String get deskripsi => _deskripsi;
  double get rating => _rating;
  int get terjual => _terjual;

  // Setter
  set nama(String value) => _nama = value;
  set gambar(String value) => _gambar = value;
  set harga(int value) => _harga = value;
  set deskripsi(String value) => _deskripsi = value;
  set rating(double value) => _rating = value;
  set terjual(int value) => _terjual = value;

  // Method bisa dioverride oleh subclass
  String getKategori() => "Umum";

  String getInfo() {
    return "Produk: $_nama\nHarga: Rp $_harga\nDeskripsi: $_deskripsi\nRating: $_rating\nTerjual: $_terjual";
  }
}

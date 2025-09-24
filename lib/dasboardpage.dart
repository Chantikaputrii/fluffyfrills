import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'produkpage.dart';

// tambahan import produk
import 'models/produkcowo.dart';
import 'models/produkcewe.dart';
import 'models/produkanak.dart';
import 'models/produkaksesoris.dart';

// ================== GLOBAL CART ==================
List<Map<String, dynamic>> globalCart = [];

// ================== SPLASH SCREEN ==================
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pinkAccent,
        child: Center(
          child: Image.asset("assets/logo_fashion.png", width: 120, height: 120),
        ),
      ),
    );
  }
}

// ================== WIDGET KERANJANG (REUSABLE) ==================
class CartIcon extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onTap;

  const CartIcon({Key? key, this.itemCount = 0, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black87),
          onPressed: onTap,
        ),
        if (itemCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$itemCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// ================== DASHBOARD ==================
class DashboardPage extends StatefulWidget {
  final String userEmail;

  const DashboardPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  String _searchQuery = ""; // query pencarian

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BerandaPage(userEmail: widget.userEmail, searchQuery: _searchQuery),
      ProdukPage(searchQuery: _searchQuery),
      const PesananPage(),
      const ProfilPage(),
      const PengaturanPage(),
    ];
  }

  void _onMenuTap(int index) {
    Navigator.pop(context);
    if (index == 5) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildSidebar() {
    final List<Map<String, dynamic>> menuItems = [
      {"icon": Icons.home, "title": "Beranda", "index": 0, "color": Colors.pinkAccent},
      {"icon": Icons.shopping_bag, "title": "Produk", "index": 1, "color": Colors.pinkAccent},
      {"icon": Icons.receipt_long, "title": "Pesanan", "index": 2, "color": Colors.pinkAccent},
      {"icon": Icons.person, "title": "Profil", "index": 3, "color": Colors.pinkAccent},
      {"icon": Icons.settings, "title": "Pengaturan", "index": 4, "color": Colors.pinkAccent},
      {"icon": Icons.logout, "title": "Logout", "index": 5, "color": Colors.redAccent},
    ];

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFff758c), Color(0xFFff7eb3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/logo_fashion.png"),
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  "Fluffy Frills",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Fashion Trend Masa Kini",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(item['icon'], color: item['color'], size: 28),
                      title: Text(
                        item['title'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: index != menuItems.length - 1
                          ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
                          : null,
                      onTap: () => _onMenuTap(item['index']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: (_selectedIndex == 0 || _selectedIndex == 1)
            ? Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: const Icon(Icons.search, color: Colors.black54),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _pages[0] = BerandaPage(
                        userEmail: widget.userEmail,
                        searchQuery: _searchQuery,
                      );
                      _pages[1] = ProdukPage(searchQuery: _searchQuery);
                    });
                  },
                ),
              )
            : const Text(
                "Fluffy Frills",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
        actions: [
          CartIcon(
            itemCount: globalCart.length,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const KeranjangPage(),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      drawer: _buildSidebar(),
      body: _pages[_selectedIndex],
    );
  }
}

// ================== HALAMAN BERANDA ==================
class BerandaPage extends StatelessWidget {
  final String userEmail;
  final String searchQuery; // ⬅️ tambahan untuk filter

  const BerandaPage({Key? key, required this.userEmail, this.searchQuery = ""})
      : super(key: key);

  Widget _buildSectionResponsive(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> produkList,
    Widget pageTujuan,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    final bigImageHeight = screenWidth * 0.35;
    final childAspectRatio = 1.0;

    if (produkList.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        .where((p) =>
            p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    final produkCewePreview = semuaProdukCewe
        .where((p) =>
            p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    final produkAnakPreview = semuaProdukAnak
        .where((p) =>
            p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    final produkAksesorisPreview = semuaProdukAksesoris
        .where((p) =>
            p.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .take(5)
        .map((p) => {"name": p.nama, "image": p.gambar, "price": p.harga})
        .toList();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text("Halo, selamat datang $userEmail 💖",
              style: const TextStyle(fontSize: 20)),
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
    );
  }
}

// ================== HALAMAN PESANAN ==================
class PesananPage extends StatelessWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.receipt_long),
            title: Text("Pesanan #${index + 1001}"),
            subtitle: const Text("Status: Diproses"),
          ),
        );
      },
    );
  }
}

// ================== HALAMAN PROFIL ==================
class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
              radius: 50,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white)),
          SizedBox(height: 12),
          Text("Cantika Putri",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("pcantika446@gmail.com"),
        ],
      ),
    );
  }
}

// ================== HALAMAN PENGATURAN ==================
class PengaturanPage extends StatelessWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(leading: Icon(Icons.palette), title: Text("Tema")),
        Divider(),
        ListTile(leading: Icon(Icons.notifications), title: Text("Notifikasi")),
        Divider(),
        ListTile(
            leading: Icon(Icons.security), title: Text("Privasi & Keamanan")),
      ],
    );
  }
}

// ================== HALAMAN KERANJANG ==================
class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Saya")),
      body: globalCart.isEmpty
          ? const Center(child: Text("Keranjang masih kosong 🛒"))
          : ListView.builder(
              itemCount: globalCart.length,
              itemBuilder: (context, index) {
                final item = globalCart[index];
                return ListTile(
                  leading: Image.asset(
                    item['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['name']),
                  subtitle:
                      Text("Rp${item['price']} | Ukuran: ${item['size']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        globalCart.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}

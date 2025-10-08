import 'package:flutter/material.dart';
import 'package:flutter_application_1/beranda_page.dart';
import 'package:flutter_application_1/keranjang_page.dart';
import 'package:flutter_application_1/pengaturan_page.dart';
import 'package:flutter_application_1/pesanan_page.dart';
import 'package:flutter_application_1/profil_page.dart';
import 'package:flutter_application_1/widget/cart_icon.dart';
import 'loginpage.dart';
import 'produkpage.dart';

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

// ================== DASHBOARD ==================
class DashboardPage extends StatefulWidget {
  final String userEmail;
  final String userName; // 🔥 tambahin nama

  const DashboardPage({
    Key? key,
    required this.userEmail,
    required this.userName,
  }) : super(key: key);

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
      ProfilPage( // 🔥 profil dapat data login
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
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
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/logo_fashion.png"),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.userName, // 🔥 nama user dari login
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  widget.userEmail, // 🔥 email user dari login
                  style: const TextStyle(color: Colors.white70),
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
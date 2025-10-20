import 'package:flutter/material.dart';
import 'package:flutter_application_1/keranjang_page.dart';
import 'package:getwidget/getwidget.dart';
import 'beranda_page.dart';
import 'produkpage.dart';
import 'pesanan_page.dart';
import 'profil_page.dart';
import 'pengaturan_page.dart';
import 'loginpage.dart';
import 'widget/cart_icon.dart';
import 'cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  final String userEmail;
  final String userName;
  final int initialIndex;

  const DashboardPage({
    Key? key,
    required this.userEmail,
    required this.userName,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _selectedIndex;
  String _searchQuery = "";
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _pages = _buildPages();
  }

  List<Widget> _buildPages() => [
        BerandaPage(
          userName: widget.userName,
          userEmail: widget.userEmail,
          searchQuery: _searchQuery,
        ),
        ProdukPage(
          searchQuery: _searchQuery,
        ),
        const PesananPage(),
        ProfilPage(
          userName: widget.userName,
          userEmail: widget.userEmail,
        ),
        const PengaturanPage(),
      ];

  Future<void> _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _onMenuTap(int index) async {
    Navigator.pop(context);
    if (index == 5) {
      await _handleLogout();
      return;
    }
    setState(() => _selectedIndex = index);
  }

  Widget _buildSidebar() {
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: const Color(0xFFFFB6C1),
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/logo_fashion.png"),
                  radius: 45,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  "Hi, ${widget.userName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.userEmail,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildGFDrawerItem("Beranda", Icons.home, 0),
          _buildGFDrawerItem("Produk", Icons.shopping_bag, 1),
          _buildGFDrawerItem("Pesanan", Icons.receipt_long, 2),
          _buildGFDrawerItem("Profil", Icons.person, 3),
          _buildGFDrawerItem("Pengaturan", Icons.settings, 4),
          const SizedBox(height: 10),
          _buildGFDrawerItem("Logout", Icons.logout, 5, isLogout: true),
        ],
      ),
    );
  }

  Widget _buildGFDrawerItem(String title, IconData icon, int index,
      {bool isLogout = false}) {
    final bool isSelected = _selectedIndex == index;
    final Color activeColor = const Color(0xFFFF7AA2);
    final Color inactiveColor = const Color(0xFFFFD6E0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isLogout
            ? inactiveColor.withOpacity(0.4)
            : (isSelected ? activeColor : inactiveColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GFListTile(
        color: Colors.transparent,
        icon: Icon(
          icon,
          color: isLogout
              ? Colors.redAccent
              : (isSelected ? Colors.white : const Color(0xFF7A0045)),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout
                ? Colors.redAccent
                : (isSelected ? Colors.white : const Color(0xFF7A0045)),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        onTap: () => _onMenuTap(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: const Color(0xFFFFE9EF),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: (_selectedIndex == 0 || _selectedIndex == 1)
            ? _buildSearchField()
            : const Text(
                "Fluffy Frills",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ValueListenableBuilder<int>(
              valueListenable: Cart().itemCountNotifier,
              builder: (context, count, child) {
                return CartIcon(
                  itemCount: count,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: _buildSidebar(),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFB6C1), width: 1.2),
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
            _pages = _buildPages(); // rebuild pages dengan query baru
          });
        },
      ),
    );
  }
}

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
        PesananPage(
          userName: widget.userName,
          userEmail: widget.userEmail,
        ),
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
    return Drawer(
      elevation: 0,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: const Color(0xFFFF7AA2),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage("assets/logo_fashion.png"),
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Hi, ${widget.userName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.userEmail,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // ✅ Menu dengan icon dekoratif di kanan
            _buildDrawerItem("Beranda", Icons.home, 0, rightIcon: Icons.home_filled),
            _buildDrawerItem("Produk", Icons.shopping_bag, 1, rightIcon: Icons.local_mall),
            _buildDrawerItem("Pesanan", Icons.receipt_long, 2, rightIcon: Icons.shopping_basket),
            _buildDrawerItem("Profil", Icons.person, 3, rightIcon: Icons.account_circle),
            _buildDrawerItem("Pengaturan", Icons.settings, 4, rightIcon: Icons.tune),
            const Divider(height: 30, thickness: 1),
            _buildDrawerItem("Logout", Icons.logout, 5, isLogout: true, rightIcon: Icons.exit_to_app),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    String title, 
    IconData icon, 
    int index, {
    bool isLogout = false,
    IconData? rightIcon, // Icon dekoratif
  }) {
    final bool isSelected = _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: isLogout
            ? Colors.red.shade50
            : (isSelected 
                ? const Color(0xFFFF7AA2)
                : Colors.white),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLogout
              ? Colors.red.shade200
              : (isSelected ? Colors.transparent : const Color(0xFFFFD6E0)),
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFFFF7AA2).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // ✅ Icon utama di KIRI dengan background
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.shade100
                : (isSelected 
                    ? Colors.white.withOpacity(0.25)
                    : const Color(0xFFFFE9EF)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 24,
            color: isLogout
                ? Colors.red.shade700
                : (isSelected 
                    ? Colors.white
                    : const Color(0xFFFF1493)),
          ),
        ),
        // ✅ Judul
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: isLogout
                ? Colors.red.shade700
                : (isSelected 
                    ? Colors.white
                    : const Color(0xFF7A0045)),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        // ✅ Icon dekoratif CUTE di KANAN (trailing)
        trailing: rightIcon != null
            ? Icon(
                rightIcon,
                size: 22,
                color: isLogout
                    ? Colors.red.shade300
                    : (isSelected 
                        ? Colors.white.withOpacity(0.6)
                        : const Color(0xFFFFB6C1)),
              )
            : null,
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
            icon: const Icon(Icons.menu, color: Colors.black87, size: 28),
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
                      MaterialPageRoute(
                        builder: (_) => CartPage(
                          userEmail: widget.userEmail,
                          userName: widget.userName,
                        ),
                      ),
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
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFB6C1), width: 1.2),
      ),
      child: TextField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          suffixIcon: const Icon(
            Icons.search,
            color: Color(0xFFFF7AA2),
            size: 22,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
            _pages = _buildPages();
          });
        },
      ),
    );
  }
}
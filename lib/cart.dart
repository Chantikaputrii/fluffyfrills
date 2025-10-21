// lib/cart.dart
import 'package:flutter/foundation.dart';

class Cart {
  // Singleton
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;
  Cart._internal();

  // List items private
  final List<Map<String, dynamic>> _items = [];

  // ValueNotifier untuk memberitahu perubahan
  final ValueNotifier<int> itemCountNotifier = ValueNotifier<int>(0);

  // Mengambil daftar items (read-only)
  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  // Total item count
  int get itemCount => _items.length;

  // Menambahkan item
  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    itemCountNotifier.value = _items.length; // update notifier
  }

  // Menghapus item
  void removeItem(Map<String, dynamic> item) {
    _items.remove(item);
    itemCountNotifier.value = _items.length; // update notifier
  }

  // Menghapus item berdasarkan index
  void removeItemByIndex(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      itemCountNotifier.value = _items.length; // update notifier
    }
  }

  // Menghapus beberapa item sekaligus (untuk checkout)
  void removeItems(List<Map<String, dynamic>> itemsToRemove) {
    for (var item in itemsToRemove) {
      _items.remove(item);
    }
    itemCountNotifier.value = _items.length;
  }

  // Menghapus semua item
  void clear() {
    _items.clear();
    itemCountNotifier.value = 0; // update notifier
  }

  // Cek apakah item sudah ada di keranjang
  bool containsItem(Map<String, dynamic> item) {
    return _items.any((i) => 
      i['name'] == item['name'] && 
      i['size'] == item['size'] && 
      i['color'] == item['color']
    );
  }

  // Hitung total harga semua item
  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += (item['price'] as num).toDouble();
    }
    return total;
  }

  // Hitung total harga item yang dipilih
  double getTotalPrice(List<int> selectedIndices) {
    double total = 0;
    for (int i in selectedIndices) {
      if (i >= 0 && i < _items.length) {
        total += (_items[i]['price'] as num).toDouble();
      }
    }
    return total;
  }
}
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

  // Menghapus semua item
  void clear() {
    _items.clear();
    itemCountNotifier.value = 0; // update notifier
  }
}

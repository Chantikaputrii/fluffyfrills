class Order {
  static final Order _instance = Order._internal();
  factory Order() => _instance;
  Order._internal();

  final List<Map<String, dynamic>> orders = [];

  void addOrder(Map<String, dynamic> orderData) {
    orders.add(orderData);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'font_size_provider.dart';
import 'home.dart';

class CartScreen extends StatelessWidget {
  static final List<Map<String, dynamic>> _cartItems = [];

  static void addToCart(String name, String price, String image, int quantity) {
    final existingItem = _cartItems.firstWhere((item) => item['name'] == name, orElse: () => {});
    if (existingItem.isNotEmpty) {
      existingItem['quantity'] = (existingItem['quantity'] ?? 0) + quantity;
    } else {
      _cartItems.add({'name': name, 'price': price, 'image': image, 'quantity': quantity});
    }
  }

  static void clearCart() {
    _cartItems.clear();
  }

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.pink[50],
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: fontSizeProvider.fontSize + 4,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: fontSizeProvider.fontSize,
                  color: isDarkMode ? Colors.white70 : Colors.grey[600],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                final totalPrice = double.parse(item['price'].replaceAll('\$', '')) * item['quantity'];
                return Card(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['image'],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 50,
                          width: 50,
                          color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 30, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: fontSizeProvider.fontSize,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: fontSizeProvider.fontSize,
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                    trailing: Text(
                      'Qty: ${item['quantity']}',
                      style: TextStyle(
                        fontSize: fontSizeProvider.fontSize,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: _cartItems.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16.0),
              color: isDarkMode ? Colors.grey[900] : Colors.pink[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${(_cartItems.fold(0.0, (sum, item) => sum + (double.parse(item['price'].replaceAll('\$', '')) * item['quantity']))).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: fontSizeProvider.fontSize + 2,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final shouldCheckout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Checkout'),
                          content: const Text('Are you sure you want to proceed with checkout? This will clear your cart.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      ) ?? false;
                      if (shouldCheckout) {
                        clearCart();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Homepage()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.orange[200] : Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: fontSizeProvider.fontSize,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
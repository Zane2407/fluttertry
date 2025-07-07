import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'font_size_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String weight;
  final String price;
  final String image;
  final String description;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
    required this.description,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    // Use the description passed from the constructor
    final newDescription = widget.description;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.pink[50],
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: fontSizeProvider.fontSize + 4,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: widget.name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.image,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 250,
                        width: double.infinity,
                        color:
                            isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Name and Price in one row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: fontSizeProvider.fontSize + 4,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    widget.price,
                    style: TextStyle(
                      fontSize: fontSizeProvider.fontSize + 2,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.orange[200] : Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Weight
              Text(
                widget.weight,
                style: TextStyle(
                  fontSize: fontSizeProvider.fontSize,
                  color: isDarkMode ? Colors.orange[200] : Colors.orange,
                ),
              ),

              const SizedBox(height: 10),

              // Description label
              Text(
                'Description',
                style: TextStyle(
                  fontSize: fontSizeProvider.fontSize + 2,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Description text (max 3 lines)
              Text(
                newDescription,
                style: TextStyle(
                  fontSize: fontSizeProvider.fontSize,
                  color: isDarkMode ? Colors.white70 : Colors.grey[600],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 16),

              // Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: _quantity <= 1
                          ? (isDarkMode
                              ? Colors.grey[600]
                              : Colors.grey[400])
                          : (isDarkMode ? Colors.white : Colors.black),
                    ),
                    onPressed: _quantity <= 1
                        ? null
                        : () => setState(() => _quantity--),
                  ),
                  Text(
                    '$_quantity',
                    style: TextStyle(
                      fontSize: fontSizeProvider.fontSize,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () => setState(() => _quantity++),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Add to Cart Button (Full width)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    CartScreen.addToCart(
                        widget.name, widget.price, widget.image, _quantity);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkMode ? Colors.orange[200] : Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: fontSizeProvider.fontSize,
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

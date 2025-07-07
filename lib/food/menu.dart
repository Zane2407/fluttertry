import 'package:flutter/material.dart';
import 'product_detail.dart';

class MenuScreen extends StatelessWidget {
  final List<Map<String, String>> menuItems = [
    {
      "name": "Special Burger",
      "price": "\$10.00",
      "rating": "4.99",
      "image": "images/pasta.jpg",
    },
    {
      "name": "Spicy Pasta",
      "price": "\$10.00",
      "rating": "4.99",
      "image": "images/p.jpg",
    },
    {
      "name": "Special Pizza",
      "price": "\$10.00",
      "rating": "4.99",
      "image": "images/a.jpg",
    },
    {
      "name": "Special Chicken",
      "price": "\$10.00",
      "rating": "4.99",
      "image": "images/chicken.jpg",
    },
    {
      "name": "Kacchi Biriyani",
      "price": "\$10.00",
      "rating": "4.99",
      "image": "images/cheese.jpg",
    },
    {
      "name": "Chicken Biriyani",
      "price": "\$10.00",
      "rating": "4.99",
      "image": "images/kacchi.jpg",
    },
  ];

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'Our Menu',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          bottom: TabBar(
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.orange,
            tabs: [Tab(text: "Meals"), Tab(text: "Sides"), Tab(text: "Snacks")],
          ),
        ),
        body: TabBarView(
          children: [
            buildGrid(),
            Center(child: Text("Sides")),
            Center(child: Text("Snacks")),
          ],
        ),
      ),
    );
  }

  Widget buildGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: menuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ProductDetailScreen(
                                      name: item["name"]!,
                                      weight:
                                          '', // Placeholder, not in menuItems
                                      price: item["price"]!,
                                      image: item["image"]!,
                                      description:
                                          'A delicious ${item["name"]} made with fresh ingredients.',
                                    ),
                              ),
                            );
                          },
                          child: ClipOval(
                            child: Image.asset(
                              item["image"]!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["name"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item["price"]!,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 246, 118, 5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    item["rating"]!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

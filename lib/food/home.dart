import 'package:flutter/material.dart';
import 'package:fluttertry/food/cart_screen.dart';
import 'package:provider/provider.dart';
import 'about_us.dart';
import 'menu.dart';
import 'font_size_provider.dart';
import 'getstart_screen.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _navIndex = 0;
  bool isDarkMode = false;

  final List<Widget> _pages = [
    const HomeContent(),
    MenuScreen(),
    const CartScreen(),
    const AboutUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FontSizeProvider(),
      child: MaterialApp(
        theme:
            isDarkMode
                ? ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: Colors.black,
                  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.black,
                  ),
                )
                : ThemeData.light(),
        home: Scaffold(
          backgroundColor: isDarkMode ? Colors.black : Colors.pink[50],
          appBar: AppBar(
            leading: Builder(
              builder:
                  (context) => IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
            ),
            title: const Text(
              "One Food",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.nightlight_round,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                onPressed: () => setState(() => isDarkMode = !isDarkMode),
              ),
            ],
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            elevation: 0,
          ),
          drawer: Consumer<FontSizeProvider>(
            builder:
                (context, fontSizeProvider, child) => Drawer(
                  backgroundColor: isDarkMode ? Colors.black : Colors.grey[200],
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: const Text(
                          "So Cheat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        accountEmail: const Text(
                          "socheat@gmail.com",
                          style: TextStyle(fontSize: 14),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor:
                              isDarkMode ? Colors.grey[800] : Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              'images/profile.jpg',
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Icon(
                                    Icons.person,
                                    color:
                                        isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                    size: 40,
                                  ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? Colors.grey[900]
                                  : const Color.fromARGB(255, 58, 14, 77),
                          border: Border(
                            bottom: BorderSide(
                              color:
                                  isDarkMode
                                      ? Colors.grey[700]!
                                      : Colors.grey[400]!,
                            ),
                          ),
                        ),
                      ),
                      ..._buildDrawerItems(context),
                      Divider(
                        color: isDarkMode ? Colors.grey[700] : Colors.grey[400],
                        indent: 16,
                        endIndent: 16,
                      ),
                      _buildFontSizeControls(context, fontSizeProvider),
                    ],
                  ),
                ),
          ),
          body: _pages[_navIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _navIndex,
            onTap: (index) => setState(() => _navIndex = index),
            selectedItemColor: isDarkMode ? Colors.white : Colors.red,
            unselectedItemColor:
                isDarkMode ? Colors.grey[400] : Colors.grey[600],
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: "Menu",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: "About Us",
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDrawerItems(BuildContext context) {
    final items = [
      {'icon': Icons.home, 'label': 'Home', 'index': 0},
      {'icon': Icons.menu_book, 'label': 'Menu', 'index': 1},
      {'icon': Icons.shopping_cart_outlined, 'label': 'Cart', 'index': 2},
      {'icon': Icons.settings, 'label': 'Settings', 'index': -1},
      {'icon': Icons.info, 'label': 'About Us', 'index': 3},
      {'icon': Icons.logout, 'label': 'Logout', 'index': -1},
    ];
    return items
        .map(
          (item) => ListTile(
            leading: Icon(
              item['icon'] as IconData,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text(
              item['label'] as String,
              style: const TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              if (item['label'] == 'Logout') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const GetStartScreen()),
                );
              } else if (item['index'] != -1) {
                setState(() => _navIndex = item['index'] as int);
              }
            },
            selected: _navIndex == item['index'],
            selectedTileColor: isDarkMode ? Colors.grey[800] : Colors.pink[50],
          ),
        )
        .toList();
  }

  Widget _buildFontSizeControls(
    BuildContext context,
    FontSizeProvider fontSizeProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              color:
                  fontSizeProvider.fontSize <= 12.0
                      ? (isDarkMode ? Colors.grey[600] : Colors.grey[400])
                      : (isDarkMode ? Colors.white : Colors.black),
              size: 32,
            ),
            onPressed:
                fontSizeProvider.fontSize <= 12.0
                    ? null
                    : () => fontSizeProvider.setFontSize(
                      fontSizeProvider.fontSize - 2.0,
                    ),
            tooltip: 'Decrease font size',
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color:
                  fontSizeProvider.fontSize >= 20.0
                      ? (isDarkMode ? Colors.grey[600] : Colors.grey[400])
                      : (isDarkMode ? Colors.white : Colors.black),
              size: 32,
            ),
            onPressed:
                fontSizeProvider.fontSize >= 20.0
                    ? null
                    : () => fontSizeProvider.setFontSize(
                      fontSizeProvider.fontSize + 2.0,
                    ),
            tooltip: 'Increase font size',
          ),
          const SizedBox(width: 16),
          Text(
            '${fontSizeProvider.fontSize.toInt()} px',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 32,
            ),
            onPressed: () {
              fontSizeProvider.resetFontSize();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Font size reset to 16 px')),
              );
            },
            tooltip: 'Reset font size',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _bannerImages = [
    'images/Food-Banner.jpg',
    'images/cheese.jpg',
    'images/a.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final items = [
      {
        'name': 'Cheese Burger',
        'weight': '250g (1 pcs)',
        'price': '\$7',
        'image': 'images/cheese.jpg',
      },
      {
        'name': 'Spicy Pasta',
        'weight': '200g (1 pcs)',
        'price': '\$8',
        'image': 'images/pasta.jpg',
      },
      {
        'name': 'Special Pizza',
        'weight': '300g (1 pcs)',
        'price': '\$9',
        'image': 'images/kacchi.jpg',
      },
      {
        'name': 'Chicken Biriyani',
        'weight': '350g (1 pcs)',
        'price': '\$10',
        'image': 'images/chicken.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(isDarkMode),
          const SizedBox(height: 15),
          _buildBanner(),
          const SizedBox(height: 15),
          _buildCategoryRow(isDarkMode),
          const SizedBox(height: 10),
          const Text(
            'Popular',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children:
                  items
                      .map((item) => _buildItemCard(item, isDarkMode))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDarkMode) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black12 : Colors.black,
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.search),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _bannerImages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(_bannerImages[index]),
                /**************************** CodeGeeX Inline Diff ****************************/
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryRow(bool isDarkMode) {
    final categories = [
      {'icon': Icons.food_bank, 'label': 'Food'},
      {'icon': Icons.local_pizza, 'label': 'Pizza'},
      {'icon': Icons.icecream, 'label': 'Dessert'},
      {'icon': Icons.local_cafe, 'label': 'Cafe'},
      {'icon': Icons.local_drink, 'label': 'Drinks'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          categories
              .map(
                (category) => Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? Colors.grey[900] : Colors.orange[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        category['icon'] as IconData,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      category['label'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
              .toList(),
    );
  }

  Widget _buildItemCard(Map<String, String> item, bool isDarkMode) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item['image']!,
                height: 64,
                width: 64,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    item['weight']!,
                    style: TextStyle(
                      color: isDarkMode ? Colors.orange[200] : Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    item['price']!,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite,
              color: isDarkMode ? Colors.orange[200] : Colors.orange,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'font_size_provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.pink[50],
        appBar: AppBar(
          title: Text(
            'About Us',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Consumer<FontSizeProvider>(
          builder: (context, fontSizeProvider, child) {
            return TabBarView(
              children: [
                // About Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'images/img.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Icon(
                                Icons.error,
                                size: 50,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                          semanticLabel: 'Company logo',
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Developers',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          InstructorCard(
                            'Phy Sophavat',
                            'images/vat.png',
                            isDarkMode,
                          ),
                          InstructorCard(
                            'Moeun Sineth',
                            'images/neth.jpg',
                            isDarkMode,
                          ),
                          InstructorCard(
                            'Reth Socheat',
                            'images/st.jpg',
                            isDarkMode,
                          ),
                          InstructorCard(
                            'Thoeng Kuyheng',
                            'images/ly.jpg',
                            isDarkMode,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Text Size (Controlled by Drawer)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${fontSizeProvider.fontSize.toInt()} px',
                        style: TextStyle(
                          color:
                              isDarkMode
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: fontSizeProvider.fontSize,
                          color: isDarkMode ? Colors.white : Colors.black,
                          height: 1.4,
                        ),
                        child: Text(
                          'About\n\n'
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
                          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                          textAlign: TextAlign.justify,
                          semanticsLabel:
                              'About text with adjustable font size',
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                // Classes Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Our Classes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        separatorBuilder:
                            (context, index) => SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final classes = [
                            {
                              'name': 'Cooking Basics',
                              'desc': 'Learn essential cooking techniques.',
                              'image': 'images/cooking.jpg',
                            },
                            {
                              'name': 'Baking Mastery',
                              'desc': 'Master the art of baking.',
                              'image': 'images/baking.jpg',
                            },
                            {
                              'name': 'Advanced Cuisine',
                              'desc': 'Explore gourmet cooking skills.',
                              'image': 'images/cuisine.jpg',
                            },
                          ];
                          return Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode ? Colors.grey[900] : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      isDarkMode
                                          ? Colors.black26
                                          : const Color.fromARGB(
                                            255,
                                            255,
                                            255,
                                            255,
                                          ).withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    classes[index]['image']!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                          Icons.error,
                                          color:
                                              isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        classes[index]['name']!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        classes[index]['desc']!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              isDarkMode
                                                  ? Colors.grey[400]
                                                  : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class InstructorCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool isDarkMode;

  const InstructorCard(this.name, this.imagePath, this.isDarkMode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage(imagePath),
          backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
          onBackgroundImageError:
              (error, stackTrace) => Icon(
                Icons.person,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

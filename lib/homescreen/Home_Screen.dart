import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Home Screen', style: TextStyle(color: Colors.white)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 81, 0, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Home Screen',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              subtitle: Text('Home Screen'),
              trailing: Text('about'),
            ),
          ],
        ),
      ),
    );
  }
}

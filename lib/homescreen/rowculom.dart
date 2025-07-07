import 'package:flutter/material.dart';

class RowCulom extends StatelessWidget {
  const RowCulom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Rowculom());
  }
}

class Rowculom extends StatelessWidget {
  const Rowculom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Row and Column', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            color: const Color.fromARGB(255, 255, 0, 200),
            child: Text('Container 1'),
          ),
          Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            color: const Color.fromARGB(255, 13, 33, 252),
            child: Text('Container 2'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Practice1 extends StatelessWidget {
  const Practice1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice 1', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello World',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Image.network(
                'https://static.wixstatic.com/media/2a2f07_058efa2f0f674bf7891d83a5085a8c29~mv2.png/v1/crop/x_0,y_0,w_2701,h_2941/fill/w_422,h_460,al_c,q_85,usm_2.00_1.00_0.00,enc_avif,quality_auto/Universetia%20online%20course%20.png',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

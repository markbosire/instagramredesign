import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
            ),
            Container(
              color: Colors.white,
            ),
            Positioned(
              bottom: 30.0,
              left: 30.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: 200.0,
                height: 100.0,
                child: Text('This is a chat bubble'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

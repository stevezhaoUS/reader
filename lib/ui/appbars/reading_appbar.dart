import 'package:flutter/material.dart';

class readingAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final String title;

  readingAppBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Container(
        color: Colors.blue, // Customize the background color
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white), // Back button
              onPressed: onBack,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white, // Customize the text color
                fontSize: 18.0, // Customize the font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class readingAppBar extends StatelessWidget {
  final VoidCallback onBack;
  final String title;

  readingAppBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        color: const Color(0xFF0E3311).withOpacity(0.5), // Customize the background color
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black), // Back button
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

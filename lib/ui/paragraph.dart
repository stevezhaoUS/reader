import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final List<String> paragraphs;
  final double padding;
  final int leadingSpace;

  const Paragraph({super.key, required this.paragraphs, this.padding = 8.0, this.leadingSpace = 8});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((paragraph) {
        return Padding(
          padding: EdgeInsets.only(left: padding),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: ' ' * leadingSpace), // Add leading space
                TextSpan(text: paragraph),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

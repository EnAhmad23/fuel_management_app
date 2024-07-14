import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final String content;

  InfoBox({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                content,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

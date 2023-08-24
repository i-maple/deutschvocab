import 'package:flutter/material.dart';

class VocabDetailsScreen extends StatelessWidget {
  const VocabDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(
                Icons.book_outlined,
              ),
            ),
          )
        ],
      ),
    );
  }
}

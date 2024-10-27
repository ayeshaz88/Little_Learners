import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.star, size: 40, color: Colors.orange),
            title: Text(
              'Learn New Words',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text('Goal: 10 words a day'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.color_lens, size: 40, color: Colors.green),
            title: Text(
              'Create Artwork',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text('Goal: Finish a painting'),
          ),
          // Add more goal items here
        ],
      ),
    );
  }
}

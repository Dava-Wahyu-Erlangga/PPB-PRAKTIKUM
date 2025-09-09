import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Page")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama Aplikasi: Praktikum 2 Mobile",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Versi: Beta 1.0", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Developer: Dava Wahyu Erlangga", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
